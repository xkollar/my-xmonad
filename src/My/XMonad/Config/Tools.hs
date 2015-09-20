{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.Config.Tools
    ( update
    , _logHook
    , _keys
    ) where

import Data.Map.Lazy (Map)

import XMonad
    ( ButtonMask
    , KeySym
    , Layout
    , ManageHook
    , X
    , XConfig
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

_keys :: L (XConfig l) KeyConfig
_keys = L keys (\ x c -> c { keys = x })

_logHook :: L (XConfig l) (X ())
_logHook = L logHook (\ x c -> c { logHook = x })

_manageHook :: L (XConfig l) ManageHook
_manageHook = L manageHook (\ x c -> c { manageHook = x })
--- }}} Totally not a lens... -------------------------------------------------
