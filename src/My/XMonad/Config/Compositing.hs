{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.Config.Compositing (addCompositing) where

import Prelude (Rational)

import Data.Function ((.))

import XMonad (X, XConfig)
import XMonad.Hooks.FadeInactive (fadeInactiveLogHook)

import My.XMonad.Config.Tools (prependLogHook)

addCompositing :: Rational -> XConfig l -> XConfig l
addCompositing = prependLogHook . fadeInactiveLogHook
