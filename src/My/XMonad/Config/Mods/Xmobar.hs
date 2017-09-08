{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.Config.Mods.Xmobar (addXmobar) where

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
import XMonad.Hooks.ManageDocks (docks)

import My.XMonad.Config.L (update, logHook)

addXmobar :: Handle -> XConfig l -> XConfig l
addXmobar = (.) docks . update logHook . (>>) . myXmobarLogHook

myXmobarLogHook :: Handle -> X ()
myXmobarLogHook h = dynamicLogWithPP xmobarPP
    { ppCurrent = xmobarColor "yellow" ""
    , ppHiddenNoWindows = const "_"
    , ppOutput = hPutStrLn h . (++")") . ('(':)
    , ppTitle = xmobarColor "green"  "" . shorten 150
    , ppVisible = xmobarColor "orange" ""
    }
