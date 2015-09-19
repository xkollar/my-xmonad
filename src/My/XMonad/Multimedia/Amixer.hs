{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.Multimedia.Amixer where

import Control.Arrow (first)
import Data.Function ((.), ($))
import Data.List (map)
import qualified Data.Map.Lazy as M (Map, fromList)

import qualified Graphics.X11.ExtraTypes.XF86 as XF86
import XMonad (KeyMask, KeySym, X, noModMask)

import My.XMonad.Core (spawn)

alsaKeys :: M.Map (KeyMask, KeySym) (X ())
alsaKeys = M.fromList . map (first $ (,) noModMask) $
    [ (XF86.xF86XK_AudioLowerVolume, amixer "5%-")
    , (XF86.xF86XK_AudioMute,        amixer "toggle")
    , (XF86.xF86XK_AudioRaiseVolume, amixer "5%+")
    ]
    where amixer c = spawn "amixer" ["set", "Master", c]
