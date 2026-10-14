"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";
import { getLogger } from "@/server/lib/logger";
import { DEFAULT_SECTION } from "./queries";

/**
 * Walkie 액션.
 * - 모든 액션은 로그인 세션을 요구한다.
 * - RLS가 소유권을 강제하므로, 액션에서는 사용자 ID만 확인한다.
 * - 첫 저장 시 FAVORITES 섹션을 자동 생성한다.
 */

const entitySchema = z.object({
  entityType: z.enum(["SONG", "ALBUM"]),
  entityId: z.string().uuid(),
});

async function requireUserId(): Promise<string> {
  const supabase = await createClient();
  const { data } = await supabase.auth.getUser();
  if (!data.user) redirect("/login");
  return data.user.id;
}

async function getOrCreateDefaultSection(
  supabase: Awaited<ReturnType<typeof createClient>>,
  userId: string,
): Promise<string> {
  const { data: existing } = await supabase
    .from("walkie_sections")
    .select("id")
    .eq("user_id", userId)
    .eq("name", DEFAULT_SECTION)
    .limit(1);
  if (existing?.[0]?.id) return existing[0].id as string;

  const { data: created, error } = await supabase
    .from("walkie_sections")
    .insert({ user_id: userId, name: DEFAULT_SECTION, position: 0 })
    .select("id")
    .single();
  if (error || !created) {
    getLogger().error({ err: error?.message }, "walkie section create failed");
    throw new Error("섹션 생성에 실패했습니다.");
  }
  return created.id as string;
}

export interface WalkieActionState {
  error?: string;
  done?: boolean;
}

/** 앨범/곡을 Walkie에 담기. sectionId 없으면 FAVORITES. 이미 있으면 무시. */
export async function saveToWalkie(
  _prev: WalkieActionState,
  formData: FormData,
): Promise<WalkieActionState> {
  const parsed = entitySchema.safeParse({
    entityType: formData.get("entityType"),
    entityId: formData.get("entityId"),
  });
  if (!parsed.success) return { error: "입력값이 올바르지 않습니다." };
  const sectionIdInput = formData.get("sectionId");
  const sectionIdRaw =
    typeof sectionIdInput === "string" && sectionIdInput.length > 0
      ? sectionIdInput
      : null;

  const userId = await requireUserId();
  const supabase = await createClient();

  // 지정된 섹션이 본인 것인지 확인 (RLS가 최종 방어선)
  let sectionId = sectionIdRaw;
  if (sectionId) {
    const { data: owned } = await supabase
      .from("walkie_sections")
      .select("id")
      .eq("id", sectionId)
      .eq("user_id", userId)
      .limit(1);
    if (!owned?.[0]) return { error: "섹션을 찾을 수 없습니다." };
  } else {
    sectionId = await getOrCreateDefaultSection(supabase, userId);
  }

  const { error } = await supabase.from("walkie_items").upsert(
    {
      section_id: sectionId,
      entity_type: parsed.data.entityType,
      entity_id: parsed.data.entityId,
    },
    { onConflict: "section_id,entity_type,entity_id", ignoreDuplicates: true },
  );
  if (error) {
    getLogger().warn({ err: error.message }, "walkie save failed");
    return { error: "담기에 실패했습니다." };
  }
  revalidatePath("/walkie");
  return { done: true };
}

/** Walkie에서 빼기. */
export async function removeFromWalkie(
  _prev: WalkieActionState,
  formData: FormData,
): Promise<WalkieActionState> {
  const itemId = formData.get("itemId");
  if (typeof itemId !== "string") return { error: "입력값이 올바르지 않습니다." };

  await requireUserId();
  const supabase = await createClient();
  const { error } = await supabase
    .from("walkie_items")
    .delete()
    .eq("id", itemId);
  if (error) {
    getLogger().warn({ err: error.message }, "walkie remove failed");
    return { error: "삭제에 실패했습니다." };
  }
  revalidatePath("/walkie");
  return { done: true };
}

const ratingSchema = z.object({
  itemId: z.string().uuid(),
  // 0~5, 0.5 단위
  rating: z.coerce
    .number()
    .min(0)
    .max(5)
    .refine((v) => Math.round(v * 2) === v * 2, "0.5 단위로 입력해 주세요."),
});

/** 평점 매기기 (0~5, 0.5 단위). */
export async function rateWalkieItem(
  _prev: WalkieActionState,
  formData: FormData,
): Promise<WalkieActionState> {
  const parsed = ratingSchema.safeParse({
    itemId: formData.get("itemId"),
    rating: formData.get("rating"),
  });
  if (!parsed.success) {
    return {
      error: parsed.error.issues[0]?.message ?? "입력값이 올바르지 않습니다.",
    };
  }

  await requireUserId();
  const supabase = await createClient();
  const { error } = await supabase
    .from("walkie_items")
    .update({ rating: parsed.data.rating })
    .eq("id", parsed.data.itemId);
  if (error) {
    getLogger().warn({ err: error.message }, "walkie rate failed");
    return { error: "평점에 실패했습니다." };
  }
  revalidatePath("/walkie");
  return { done: true };
}

const sectionNameSchema = z.object({
  name: z
    .string()
    .trim()
    .min(1, "섹션 이름을 입력해 주세요.")
    .max(30, "섹션 이름은 30자까지 가능합니다."),
});

/** 새 섹션 만들기. */
export async function createSection(
  _prev: WalkieActionState,
  formData: FormData,
): Promise<WalkieActionState> {
  const parsed = sectionNameSchema.safeParse({ name: formData.get("name") });
  if (!parsed.success) {
    return {
      error: parsed.error.issues[0]?.message ?? "입력값이 올바르지 않습니다.",
    };
  }

  const userId = await requireUserId();
  const supabase = await createClient();
  const { error } = await supabase.from("walkie_sections").insert({
    user_id: userId,
    name: parsed.data.name,
  });
  if (error) {
    // unique 위반 = 중복 이름
    if (error.code === "23505") return { error: "이미 있는 섹션 이름입니다." };
    getLogger().warn({ err: error.message }, "walkie section create failed");
    return { error: "섹션 만들기에 실패했습니다." };
  }
  revalidatePath("/walkie");
  return { done: true };
}

/** 섹션 삭제 (안의 아이템도 함께 삭제). */
export async function deleteSection(
  _prev: WalkieActionState,
  formData: FormData,
): Promise<WalkieActionState> {
  const sectionId = formData.get("sectionId");
  if (typeof sectionId !== "string" || sectionId.length === 0) {
    return { error: "입력값이 올바르지 않습니다." };
  }

  await requireUserId();
  const supabase = await createClient();
  const { error } = await supabase
    .from("walkie_sections")
    .delete()
    .eq("id", sectionId);
  if (error) {
    getLogger().warn({ err: error.message }, "walkie section delete failed");
    return { error: "섹션 삭제에 실패했습니다." };
  }
  revalidatePath("/walkie");
  return { done: true };
}
