import { createServerClient } from "@supabase/ssr";
import { NextResponse, type NextRequest } from "next/server";

/**
 * 세션 갱신 미들웨어 로직 (Next.js 16 proxy.ts에서 호출).
 * Edge runtime에서 동작하므로 pino 등 node 전용 모듈을 사용하지 않는다.
 */
export async function updateSession(request: NextRequest) {
  let supabaseResponse = NextResponse.next({ request });

  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll() {
          return request.cookies.getAll();
        },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value }) => request.cookies.set(name, value));
          supabaseResponse = NextResponse.next({ request });
          cookiesToSet.forEach(({ name, value, options }) =>
            supabaseResponse.cookies.set(name, value, options),
          );
        },
      },
    },
  );

  // getUser() 호출로 만료된 토큰을 갱신하고 쿠키에 반영한다.
  // 외부 장애(D-014)나 잘못된 env에서도 앱이 죽지 않도록 best-effort로 처리한다.
  try {
    await supabase.auth.getUser();
  } catch {
    // 세션 갱신 실패 시 요청은 그대로 통과시킨다.
  }

  return supabaseResponse;
}
