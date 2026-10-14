"use server";

import { headers } from "next/headers";
import { redirect } from "next/navigation";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";
import { getEnv } from "@/server/lib/env";
import { getLogger } from "@/server/lib/logger";
import { recordLoginAttempt, recordSecurityEvent } from "./audit";

const emailSchema = z.object({
  email: z.string().email("올바른 이메일 형식이 아닙니다."),
  password: z.string().min(8, "비밀번호는 8자 이상이어야 합니다."),
});

export interface AuthActionState {
  error: string;
}

async function getClientInfo() {
  const h = await headers();
  const forwarded = h.get("x-forwarded-for");
  return {
    ip: forwarded?.split(",")[0]?.trim() ?? "unknown",
    userAgent: h.get("user-agent") ?? "unknown",
  };
}

export async function signUpWithEmail(
  _prev: AuthActionState,
  formData: FormData,
): Promise<AuthActionState> {
  const parsed = emailSchema.safeParse({
    email: formData.get("email"),
    password: formData.get("password"),
  });
  if (!parsed.success) {
    return { error: parsed.error.issues[0]?.message ?? "입력값이 올바르지 않습니다." };
  }

  const supabase = await createClient();
  const { ip, userAgent } = await getClientInfo();
  const { data, error } = await supabase.auth.signUp({
    email: parsed.data.email,
    password: parsed.data.password,
    options: { emailRedirectTo: `${getEnv().APP_URL}/auth/callback` },
  });

  if (error) {
    getLogger().warn({ err: error.message }, "signup failed");
    await recordLoginAttempt({ ip, userAgent, result: "FAILED" });
    return { error: "회원가입에 실패했습니다. 입력 정보를 확인해 주세요." };
  }

  await recordLoginAttempt({ userId: data.user?.id, ip, userAgent, result: "SUCCESS" });
  await recordSecurityEvent({ userId: data.user?.id, type: "LOGIN" });
  redirect("/");
}

export async function signInWithEmail(
  _prev: AuthActionState,
  formData: FormData,
): Promise<AuthActionState> {
  const parsed = emailSchema.safeParse({
    email: formData.get("email"),
    password: formData.get("password"),
  });
  if (!parsed.success) {
    return { error: parsed.error.issues[0]?.message ?? "입력값이 올바르지 않습니다." };
  }

  const supabase = await createClient();
  const { ip, userAgent } = await getClientInfo();
  const { data, error } = await supabase.auth.signInWithPassword({
    email: parsed.data.email,
    password: parsed.data.password,
  });

  if (error) {
    getLogger().warn({ err: error.message }, "signin failed");
    await recordLoginAttempt({ ip, userAgent, result: "FAILED" });
    await recordSecurityEvent({ type: "FAILED_LOGIN", detail: { ip } });
    return { error: "이메일 또는 비밀번호가 올바르지 않습니다." };
  }

  await recordLoginAttempt({ userId: data.user?.id, ip, userAgent, result: "SUCCESS" });
  await recordSecurityEvent({ userId: data.user?.id, type: "LOGIN" });
  redirect("/");
}

const oauthProviders = ["google", "apple", "kakao"] as const;
export type OAuthProvider = (typeof oauthProviders)[number];

export async function signInWithOAuth(provider: OAuthProvider): Promise<void> {
  const supabase = await createClient();
  const { data, error } = await supabase.auth.signInWithOAuth({
    provider,
    options: { redirectTo: `${getEnv().APP_URL}/auth/callback` },
  });

  if (error || !data.url) {
    getLogger().warn({ err: error?.message, provider }, "oauth init failed");
    redirect(`/login?error=${encodeURIComponent("소셜 로그인에 실패했습니다.")}`);
  }
  redirect(data.url);
}

export async function signOut(): Promise<void> {
  const supabase = await createClient();
  await supabase.auth.signOut();
  redirect("/login");
}
