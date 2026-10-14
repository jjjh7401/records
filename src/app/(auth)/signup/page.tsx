"use client";

import { useActionState } from "react";
import Link from "next/link";
import { signUpWithEmail, type AuthActionState } from "@/server/modules/auth/actions";

const initialState: AuthActionState = { error: "" };

export default function SignupPage() {
  const [state, formAction, pending] = useActionState(signUpWithEmail, initialState);

  return (
    <main className="mx-auto flex min-h-screen w-full max-w-sm flex-col justify-center px-6">
      <h1 className="text-2xl font-bold tracking-tight">RECORDS</h1>
      <p className="mt-2 text-sm text-neutral-500">J-POP 음악 도시에 오신 것을 환영합니다.</p>

      <form action={formAction} className="mt-8 flex flex-col gap-3">
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
          autoComplete="new-password"
          placeholder="비밀번호 (8자 이상)"
          minLength={8}
          className="rounded-lg border border-neutral-300 px-4 py-2.5 text-sm outline-none focus:border-neutral-500"
        />
        {state.error && <p className="text-sm text-red-600">{state.error}</p>}
        <button
          type="submit"
          disabled={pending}
          className="rounded-lg bg-neutral-900 px-4 py-2.5 text-sm font-medium text-white disabled:opacity-50"
        >
          {pending ? "가입 중..." : "회원가입"}
        </button>
      </form>

      <p className="mt-6 text-center text-sm text-neutral-500">
        이미 계정이 있으신가요?{" "}
        <Link href="/login" className="font-medium text-neutral-900 underline">
          로그인
        </Link>
      </p>
    </main>
  );
}
