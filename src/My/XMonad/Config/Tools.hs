{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.Config.Tools
    ( prependLogHook
    , updateKeys
    ) where

import Control.Monad ((>>))
import Data.Map.Lazy (Map)

import XMonad
    ( ButtonMask
    , KeySym
    , Layout
    , X
    , XConfig
        ( logHook
        , keys
        )
    )

prependLogHook :: X a -> XConfig l -> XConfig l
prependLogHook f c = c { logHook = f >> logHook c }

type KeyConfig = XConfig Layout -> Map (ButtonMask, KeySym) (X ())

updateKeys :: (KeyConfig -> KeyConfig) -> XConfig l -> XConfig l
updateKeys f c = c { keys = f (keys c) }
