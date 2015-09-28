{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.Config.Mods.Sandboxed
    ( sandboxed
    , recompileSandboxed
    ) where

import Data.Function (($))
import Data.List (concat)
import Data.Map.Lazy (fromList)

import XMonad (X, XConfig(modMask), xK_q, (<+>), spawn)

import My.XMonad.Config.L (update, keys)
import My.XMonad.Core (KeyConfig)

sandboxed :: XConfig l -> XConfig l
sandboxed = update keys (recompileSandboxedKeys <+>)

recompileSandboxedKeys :: KeyConfig
recompileSandboxedKeys c = fromList
    [((modMask c, xK_q), recompileSandboxed)]

recompileSandboxed :: X ()
recompileSandboxed = spawn $ concat
    [ "if type xmonad;then "
    , "GHC_PACKAGE_PATH=\"`echo \"\\` which xmonad"
    , "|xargs readlink -f"
    , "|sed 's/\\(.*\\/\\.cabal-sandbox\\)\\/bin\\/xmonad/\\1/'\\`\""
    , "/*-packages.conf.d`\": xmonad --recompile"
    , "&& xmonad --restart"
    , ";else xmessage xmonad not in \\$PATH: \"$PATH\"; fi"
    ]
