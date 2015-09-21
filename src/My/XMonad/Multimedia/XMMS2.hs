{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.Multimedia.XMMS2 (xmms2Keys) where

import Control.Arrow ((***))
import Data.Function ((.), ($))
import Data.List (map)
import qualified Data.Map.Lazy as M (Map, fromList)

import qualified Graphics.X11.ExtraTypes.XF86 as XF86
import XMonad (KeyMask, KeySym, X, noModMask)

import My.XMonad.Core (spawn)


xmms2Keys :: a -> M.Map (KeyMask, KeySym) (X ())
xmms2Keys _ = M.fromList . map ((,) noModMask *** nyxmms2) $
    [ (XF86.xF86XK_AudioLowerVolume, ["server", "volume", "-5"])
    , (XF86.xF86XK_AudioMute, ["server", "volume", "0"])
    , (XF86.xF86XK_AudioRaiseVolume, ["server", "volume", "+5"])
    , (XF86.xF86XK_AudioPlay, ["toggle"])
    , (XF86.xF86XK_AudioStop, ["stop"])
    , (XF86.xF86XK_AudioPrev, ["prev"])
    , (XF86.xF86XK_AudioNext, ["next"])
    ]
    where nyxmms2 = spawn "nyxmms2"
