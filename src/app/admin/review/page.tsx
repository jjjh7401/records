import Link from "next/link";
import {
  getCurrentAdmin,
  getReviewStats,
  listPendingAssets,
  type PendingAsset,
} from "@/server/modules/review/queries";
import { DecisionButtons } from "./decision-buttons";

// 관리자 세션에 따라 렌더링되므로 서버에서 블로킹 렌더링
export const instant = false;

function Stat({ label, value }: { label: string; value: number }) {
  return (
    <div className="rounded-xl border border-neutral-200 px-4 py-3">
      <p className="text-2xl font-bold">{value}</p>
      <p className="mt-0.5 text-xs text-neutral-500">{label}</p>
    </div>
  );
}

function AssetCard({ asset }: { asset: PendingAsset }) {
  return (
    <li className="flex gap-4 rounded-xl border border-neutral-200 p-4">
      {/* 제3자 아트워크는 자가 호스팅하지 않고 원본 URL을 참조만 한다 (D-006) */}
      <img
        src={asset.sourceUrl}
        alt={`${asset.albumTitle} 커버 아트`}
        loading="lazy"
        className="h-24 w-24 shrink-0 rounded-lg border border-neutral-100 bg-neutral-50 object-cover"
      />
      <div className="flex min-w-0 flex-1 flex-col">
        <p className="truncate font-medium">{asset.albumTitle}</p>
        {asset.albumArtistCredit && (
          <p className="mt-0.5 truncate text-sm text-neutral-500">
            {asset.albumArtistCredit}
          </p>
        )}
        <p className="mt-1 text-xs text-neutral-400">
          {asset.sourceType} · 권리 {asset.rightsType ?? "미지정"}
        </p>
        <div className="mt-3">
          <DecisionButtons assetId={asset.id} />
        </div>
      </div>
    </li>
  );
}

export default async function ReviewPage() {
  const admin = await getCurrentAdmin();

  if (!admin) {
    return (
      <main className="mx-auto flex min-h-screen w-full max-w-2xl flex-col justify-center px-6">
        <h1 className="text-2xl font-bold tracking-tight">접근 권한이 없어요</h1>
        <p className="mt-2 text-sm text-neutral-500">
          아트워크 검토는 관리자(SUPER_ADMIN, MODERATOR)만 할 수 있어요.
        </p>
        <div className="mt-6">
          <Link
            href="/login"
            className="rounded-lg bg-neutral-900 px-4 py-2 text-sm font-medium text-white"
          >
            로그인하기
          </Link>
        </div>
      </main>
    );
  }

  let pending: PendingAsset[] = [];
  let stats = { pending: 0, active: 0, blocked: 0 };
  try {
    [pending, stats] = await Promise.all([listPendingAssets(), getReviewStats()]);
  } catch {
    // 빈 상태로 렌더링 (D-014)
  }

  return (
    <main className="mx-auto min-h-screen w-full max-w-2xl px-6 py-10">
      <div className="mb-6 flex items-center justify-between">
        <h1 className="text-xl font-bold tracking-tight">아트워크 검토</h1>
        <span className="text-xs text-neutral-400">{admin.role}</span>
      </div>

      <div className="grid grid-cols-3 gap-3">
        <Stat label="검토 대기" value={stats.pending} />
        <Stat label="승인됨" value={stats.active} />
        <Stat label="반려됨" value={stats.blocked} />
      </div>

      {pending.length > 0 ? (
        <ul className="mt-6 flex flex-col gap-3">
          {pending.map((a) => (
            <AssetCard key={a.id} asset={a} />
          ))}
        </ul>
      ) : (
        <p className="mt-12 text-center text-sm text-neutral-500">
          검토 대기 중인 아트워크가 없어요.
        </p>
      )}

      <p className="mt-8 text-xs text-neutral-400">
        승인된 아트워크만 공개 카탈로그에 노출됩니다. 모든 결정은 감사 로그에
        기록됩니다.
      </p>
    </main>
  );
}
