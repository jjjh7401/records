import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import { recordLoginAttempt, recordSecurityEvent } from "@/server/modules/auth/audit";

/**
 * OAuth / 이메일 확인 콜백.
 * Supabase가 ?code=... 로 리다이렉트하면 세션으로 교환한다.
 * public 행 생성은 DB trigger(supabase/auth_trigger.sql)가 담당한다.
 */
export async function GET(request: Request) {
  const { searchParams, origin } = new URL(request.url);
  const code = searchParams.get("code");
  const next = searchParams.get("next") ?? "/";

  if (code) {
    const supabase = await createClient();
    const { data, error } = await supabase.auth.exchangeCodeForSession(code);
    if (!error) {
      await recordLoginAttempt({ userId: data.user?.id, result: "SUCCESS" });
      await recordSecurityEvent({ userId: data.user?.id, type: "LOGIN" });
      return NextResponse.redirect(`${origin}${next}`);
    }
  }

  await recordSecurityEvent({ type: "FAILED_LOGIN", detail: { reason: "oauth_callback_failed" } });
  return NextResponse.redirect(`${origin}/login?error=oauth_failed`);
}
