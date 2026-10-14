"use server";

import { revalidatePath } from "next/cache";
import { z } from "zod";
import { and, eq } from "drizzle-orm";
import { getDb } from "@/server/db/client";
import { adminAuditLogs, mediaAssets } from "@/server/db/schema";
import { getLogger } from "@/server/lib/logger";
import { getCurrentAdmin } from "./queries";

/**
 * 커버아트 승인/반려 액션.
 * - 매 호출마다 관리자 권한을 재확인한다 (페이지를 믿지 않는다).
 * - 상태 전이는 NEEDS_REVIEW에서만 허용한다.
 * - 모든 결정은 admin_audit_logs에 기록한다.
 */

const assetIdSchema = z.object({
  assetId: z.string().uuid("올바르지 않은 아트워크 ID입니다."),
});

export interface ReviewActionState {
  error?: string;
  done?: string;
}

async function decide(
  formData: FormData,
  to: "ACTIVE" | "BLOCKED",
  actionName: string,
  doneMessage: string,
): Promise<ReviewActionState> {
  const parsed = assetIdSchema.safeParse({ assetId: formData.get("assetId") });
  if (!parsed.success) {
    return { error: parsed.error.issues[0]?.message ?? "입력값이 올바르지 않습니다." };
  }

  const admin = await getCurrentAdmin();
  if (!admin) {
    getLogger().warn("unauthorized review decision attempt");
    return { error: "관리자 권한이 필요합니다." };
  }

  const db = getDb();
  // NEEDS_REVIEW 상태에서만 전이 허용 (중복 제출/레이스 방지)
  const updated = await db
    .update(mediaAssets)
    .set({ status: to, updatedAt: new Date() })
    .where(
      and(
        eq(mediaAssets.id, parsed.data.assetId),
        eq(mediaAssets.status, "NEEDS_REVIEW"),
      ),
    )
    .returning({ id: mediaAssets.id });

  if (updated.length === 0) {
    return { error: "해당 아트워크를 찾을 수 없습니다." };
  }

  await db.insert(adminAuditLogs).values({
    adminUserId: admin.userId,
    action: actionName,
    targetType: "media_assets",
    targetId: parsed.data.assetId,
    detail: { from: "NEEDS_REVIEW", to, role: admin.role },
  });

  getLogger().info(
    { admin: admin.userId, asset: parsed.data.assetId, to },
    "media asset review decision",
  );
  revalidatePath("/admin/review");
  return { done: doneMessage };
}

export async function approveAsset(
  _prev: ReviewActionState,
  formData: FormData,
): Promise<ReviewActionState> {
  return decide(formData, "ACTIVE", "media_asset.approve", "승인했습니다.");
}

export async function rejectAsset(
  _prev: ReviewActionState,
  formData: FormData,
): Promise<ReviewActionState> {
  return decide(formData, "BLOCKED", "media_asset.reject", "반려했습니다.");
}
