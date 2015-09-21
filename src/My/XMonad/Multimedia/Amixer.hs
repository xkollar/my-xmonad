{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.Multimedia.Amixer (alsaKeys) where

import Control.Arrow ((***))
import Data.Function ((.), ($))
import Data.List (map)
import qualified Data.Map.Lazy as M (Map, fromList)

import qualified Graphics.X11.ExtraTypes.XF86 as XF86
import XMonad (KeyMask, KeySym, X, noModMask)

import My.XMonad.Core (spawn)

alsaKeys :: a -> M.Map (KeyMask, KeySym) (X ())
alsaKeys _ = M.fromList . map ((,) noModMask *** amixer) $
    [ (XF86.xF86XK_AudioLowerVolume, "5%-")
    , (XF86.xF86XK_AudioMute, "toggle")
    , (XF86.xF86XK_AudioRaiseVolume, "5%+")
    ]
    where amixer c = spawn "amixer" ["-q", "set", "Master", c]
