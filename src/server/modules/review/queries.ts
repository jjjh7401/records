import "server-only";
import { eq, desc, sql } from "drizzle-orm";
import { createClient } from "@/lib/supabase/server";
import { getDb } from "@/server/db/client";
import { adminRoles, albums, mediaAssets } from "@/server/db/schema";

/**
 * 커버아트 승인 큐 조회 모듈.
 *
 * media_assets/admin_roles는 RLS가 기본 deny이므로,
 * 서버 전용 직접 연결(getDb, postgres role)로 조회한다.
 * 호출 전 반드시 getCurrentAdmin()으로 권한을 확인한다.
 */

export interface AdminIdentity {
  userId: string;
  role: "SUPER_ADMIN" | "MODERATOR";
}

/** 세션 사용자 중 관리자 권한이 있으면 반환, 없으면 null. */
export async function getCurrentAdmin(): Promise<AdminIdentity | null> {
  const supabase = await createClient();
  const { data } = await supabase.auth.getUser();
  const userId = data.user?.id;
  if (!userId) return null;

  const db = getDb();
  const rows = await db
    .select({ role: adminRoles.role })
    .from(adminRoles)
    .where(eq(adminRoles.userId, userId))
    .limit(1);
  const role = rows[0]?.role;
  if (!role) return null;
  return { userId, role };
}

export interface PendingAsset {
  id: string;
  sourceUrl: string;
  sourceType: string;
  rightsType: string | null;
  createdAt: Date;
  albumTitle: string;
  albumArtistCredit: string | null;
}

/** 승인 대기(NEEDS_REVIEW) 아트워크 목록. 오래된 것부터. */
export async function listPendingAssets(): Promise<PendingAsset[]> {
  const db = getDb();
  const rows = await db
    .select({
      id: mediaAssets.id,
      sourceUrl: mediaAssets.sourceUrl,
      sourceType: mediaAssets.sourceType,
      rightsType: mediaAssets.rightsType,
      createdAt: mediaAssets.createdAt,
      albumTitle: albums.title,
      albumArtistCredit: albums.artistCredit,
    })
    .from(mediaAssets)
    .innerJoin(albums, eq(mediaAssets.entityId, albums.id))
    .where(eq(mediaAssets.status, "NEEDS_REVIEW"))
    .orderBy(mediaAssets.createdAt);
  return rows;
}

export interface ReviewStats {
  pending: number;
  active: number;
  blocked: number;
}

/** 상태별 아트워크 건수. */
export async function getReviewStats(): Promise<ReviewStats> {
  const db = getDb();
  const rows = await db
    .select({
      status: mediaAssets.status,
      count: sql<number>`count(*)::int`,
    })
    .from(mediaAssets)
    .groupBy(mediaAssets.status);
  const byStatus = new Map(rows.map((r) => [r.status, r.count]));
  return {
    pending: byStatus.get("NEEDS_REVIEW") ?? 0,
    active: byStatus.get("ACTIVE") ?? 0,
    blocked: byStatus.get("BLOCKED") ?? 0,
  };
}
