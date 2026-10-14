"use client";

import { useActionState } from "react";
import Link from "next/link";
import {
  signInWithEmail,
  signInWithOAuth,
  type AuthActionState,
  type OAuthProvider,
} from "@/server/modules/auth/actions";

const initialState: AuthActionState = { error: "" };

function OAuthButton({ provider, label }: { provider: OAuthProvider; label: string }) {
  return (
    <button
      type="button"
      onClick={() => signInWithOAuth(provider)}
      className="w-full rounded-lg border border-neutral-300 px-4 py-2.5 text-sm font-medium hover:bg-neutral-50"
    >
      {label}로 계속하기
    </button>
  );
}

export default function LoginPage() {
  const [state, formAction, pending] = useActionState(signInWithEmail, initialState);

  return (
    <main className="mx-auto flex min-h-screen w-full max-w-sm flex-col justify-center px-6">
      <h1 className="text-2xl font-bold tracking-tight">RECORDS</h1>
      <p className="mt-2 text-sm text-neutral-500">
        좋아하는 음악을 모으고, 나누고, 기록하는 곳.
      </p>

      <div className="mt-8 flex flex-col gap-2">
        <OAuthButton provider="google" label="Google" />
        <OAuthButton provider="apple" label="Apple" />
        <OAuthButton provider="kakao" label="Kakao" />
      </div>

      <div className="my-6 flex items-center gap-3 text-xs text-neutral-400">
        <span className="h-px flex-1 bg-neutral-200" />
        또는 이메일로
        <span className="h-px flex-1 bg-neutral-200" />
      </div>

      <form action={formAction} className="flex flex-col gap-3">
        <input
          name="email"
          type="email"
          required
          autoComplete="email"
          placeholder="이메일"
          className="rounded-lg border border-neutral-300 px-4 py-2.5 text-sm outline-none focus:border-neutral-500"
        />
        <input
          name="password"
          type="password"
          required
          autoComplete="current-password"
          placeholder="비밀번호"
          className="rounded-lg border border-neutral-300 px-4 py-2.5 text-sm outline-none focus:border-neutral-500"
        />
        {state.error && <p className="text-sm text-red-600">{state.error}</p>}
        <button
          type="submit"
          disabled={pending}
          className="rounded-lg bg-neutral-900 px-4 py-2.5 text-sm font-medium text-white disabled:opacity-50"
        >
          {pending ? "로그인 중..." : "로그인"}
        </button>
      </form>

      <p className="mt-6 text-center text-sm text-neutral-500">
        계정이 없으신가요?{" "}
        <Link href="/signup" className="font-medium text-neutral-900 underline">
          회원가입
        </Link>
      </p>
    </main>
  );
}
