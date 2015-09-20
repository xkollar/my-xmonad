{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.Config.L
    ( update
    , keys
    , logHook
    , manageHook
    ) where

import Data.Map.Lazy (Map)

import XMonad
    ( ButtonMask
    , KeySym
    , Layout
    , ManageHook
    , X
    , XConfig
    )
import qualified XMonad as X
    ( XConfig
        ( logHook
        , keys
        , manageHook
        )
    )


--- {{{ Totally not a lens... -------------------------------------------------
data L a b = L
    { get :: a -> b
    , set :: b -> a -> a
    }

update :: L a b -> (b -> b) -> a -> a
update l f x = set l (f (get l x)) x

type KeyConfig = XConfig Layout -> Map (ButtonMask, KeySym) (X ())

keys :: L (XConfig l) KeyConfig
keys = L X.keys (\ x c -> c { X.keys = x })

logHook :: L (XConfig l) (X ())
logHook = L X.logHook (\ x c -> c { X.logHook = x })

manageHook :: L (XConfig l) ManageHook
manageHook = L X.manageHook (\ x c -> c { X.manageHook = x })
--- }}} Totally not a lens... -------------------------------------------------
