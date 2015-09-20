{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.Config.Tools
    ( prependLogHook
    ) where

import Control.Monad ((>>))

import XMonad (X, XConfig(logHook))

prependLogHook :: X a -> XConfig l -> XConfig l
prependLogHook f c = c { logHook = f >> logHook c }
