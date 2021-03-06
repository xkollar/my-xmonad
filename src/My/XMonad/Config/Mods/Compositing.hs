{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.Config.Mods.Compositing (addCompositing) where

import Prelude (Rational)

import Control.Monad ((>>))
import Data.Function ((.))

import XMonad (XConfig)
import XMonad.Hooks.FadeInactive (fadeInactiveCurrentWSLogHook)

import My.XMonad.Config.L (update, logHook)

addCompositing :: Rational -> XConfig l -> XConfig l
addCompositing = update logHook . (>>) . fadeInactiveCurrentWSLogHook
