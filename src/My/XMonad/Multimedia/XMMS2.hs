{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.Multimedia.XMMS2 (
      xmms2Keys
    , xmms2KeysBase
    , xmms2KeysExtra
    ) where

import Prelude (String)

import Control.Arrow ((***))
import Data.Function ((.), ($))
import Data.List (map)
import Data.Map.Lazy (Map, fromList)

import qualified Graphics.X11.ExtraTypes.XF86 as XF86
import XMonad (KeyMask, KeySym, Layout, X, XConfig(modMask), noModMask, (<+>))

import My.XMonad.Core (spawn)

type KeyMap = Map (KeyMask, KeySym) (X ())
type KeyConfig = XConfig Layout -> KeyMap

xmms2Keys :: KeyConfig
xmms2Keys = xmms2KeysBase <+> xmms2KeysExtra

xmms2KeysBase :: KeyConfig
xmms2KeysBase _ = xmms2BindingsFromList noModMask $
    [ (XF86.xF86XK_AudioLowerVolume, ["server", "volume", "-5"])
    , (XF86.xF86XK_AudioMute, ["server", "volume", "0"])
    , (XF86.xF86XK_AudioRaiseVolume, ["server", "volume", "+5"])
    , (XF86.xF86XK_AudioPlay, ["toggle"])
    , (XF86.xF86XK_AudioStop, ["stop"])
    , (XF86.xF86XK_AudioPrev, ["prev"])
    , (XF86.xF86XK_AudioNext, ["next"])
    ]

xmms2KeysExtra :: KeyConfig
xmms2KeysExtra c = xmms2BindingsFromList (modMask c) $
    [ (XF86.xF86XK_AudioPrev, ["seek", "-10"])
    , (XF86.xF86XK_AudioNext, ["seek", "+10"])
    ]

xmms2BindingsFromList :: KeyMask -> [(KeySym, [String])] -> KeyMap
xmms2BindingsFromList mask = fromList . map ((,) mask *** nyxmms2) where
    nyxmms2 = spawn "nyxmms2"
