{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.Config.Desktop (addDesktop) where

import Data.Function ((.))

import XMonad (XConfig, ManageHook, (<+>), composeAll)
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks (manageDocks)
import XMonad.Hooks.ManageHelpers (doCenterFloat)
import XMonad.ManageHook ((-->), (=?), className, doIgnore)

import My.XMonad.Config.L (update, manageHook)

addDesktop :: XConfig l -> XConfig l
addDesktop = ewmh . update manageHook (myManageHook <+>)

myManageHook :: ManageHook
myManageHook = manageDocks <+> composeAll
    [ className =? "Xfce4-notifyd"  --> doIgnore
    , className =? "Workrave"       --> doCenterFloat
    , className =? "Xfrun4"         --> doCenterFloat
    ]
