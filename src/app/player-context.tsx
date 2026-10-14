"use client";

import {
  createContext,
  useCallback,
  useContext,
  useState,
  type ReactNode,
} from "react";

export interface NowPlaying {
  videoId: string;
  title: string;
  artist: string;
}

interface PlayerContextValue {
  nowPlaying: NowPlaying | null;
  play: (item: NowPlaying) => void;
  close: () => void;
}

const PlayerContext = createContext<PlayerContextValue | null>(null);

export function PlayerProvider({ children }: { children: ReactNode }) {
  const [nowPlaying, setNowPlaying] = useState<NowPlaying | null>(null);

  const play = useCallback((item: NowPlaying) => {
    setNowPlaying(item);
  }, []);

  const close = useCallback(() => {
    setNowPlaying(null);
  }, []);

  return (
    <PlayerContext.Provider value={{ nowPlaying, play, close }}>
      {children}
    </PlayerContext.Provider>
  );
}

export function usePlayer(): PlayerContextValue {
  const ctx = useContext(PlayerContext);
  if (!ctx) throw new Error("usePlayer must be used within PlayerProvider");
  return ctx;
}
