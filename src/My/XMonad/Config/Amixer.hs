{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.Config.Amixer (alsaKeys) where

import Control.Arrow ((***))
import Data.Function ((.), ($))
import Data.List (map)
import Data.Map.Lazy (fromList)

import qualified Graphics.X11.ExtraTypes.XF86 as XF86
import XMonad (noModMask)

import My.XMonad.Core (KeyConfig, spawn)

alsaKeys :: KeyConfig
alsaKeys _ = fromList . map ((,) noModMask *** amixer) $
    [ (XF86.xF86XK_AudioLowerVolume, "5%-")
    , (XF86.xF86XK_AudioMute, "toggle")
    , (XF86.xF86XK_AudioRaiseVolume, "5%+")
    ]
    where amixer c = spawn "amixer" ["-q", "set", "Master", c]
