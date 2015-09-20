{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.Config.Xmobar (addXmobar) where

import Control.Monad ((>>))
import Data.Function ((.), const)
import Data.List ((++))

import System.IO (Handle, hPutStrLn)

import XMonad (X, XConfig)
import XMonad.Hooks.DynamicLog
    ( dynamicLogWithPP
    , ppCurrent
    , ppHiddenNoWindows
    , ppOutput
    , ppTitle
    , ppVisible
    , shorten
    , xmobarColor
    , xmobarPP)

import My.XMonad.Config.Tools (update, logHook)

addXmobar :: Handle -> XConfig l -> XConfig l
addXmobar = update logHook . (>>) . myXmobarLogHook

myXmobarLogHook :: Handle -> X ()
myXmobarLogHook h = dynamicLogWithPP xmobarPP
    { ppCurrent = xmobarColor "yellow" ""
    , ppHiddenNoWindows = const "_"
    , ppOutput = hPutStrLn h . (++")") . ('(':)
    , ppTitle = xmobarColor "green"  "" . shorten 150
    , ppVisible = xmobarColor "orange" ""
    }
