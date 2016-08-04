{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE TemplateHaskell #-}
module My.XMonad.Config.L
    ( set
    , update
    , borderWidth
    , keys
    , logHook
    , manageHook
    ) where

import Data.Map.Lazy (Map)

import XMonad
    ( ButtonMask
    , Dimension
    , KeySym
    , Layout
    , ManageHook
    , X
    , XConfig
    )
import qualified XMonad as X
    ( XConfig
        ( borderWidth
        , keys
        , logHook
        , manageHook
        )
    )

import My.XMonad.Config.LTH (genL)


--- {{{ Totally not a lens... -------------------------------------------------
data L a b = L
    { get :: a -> b
    , set :: b -> a -> a
    }

update :: L a b -> (b -> b) -> a -> a
update l f x = set l (f (get l x)) x

genL "borderWidth"
borderWidth :: L (XConfig l) Dimension

type KeyConfig = XConfig Layout -> Map (ButtonMask, KeySym) (X ())

genL "keys"
keys :: L (XConfig l) KeyConfig

genL "logHook"
logHook :: L (XConfig l) (X ())

genL "manageHook"
manageHook :: L (XConfig l) ManageHook

-- Todo...
-- clickJustFocuses   :: Bool
-- focusFollowsMouse  :: Bool
-- focusedBorderColor :: String
-- handleEventHook    :: (Event -> X All)
-- keys               :: (XConfig Layout -> M.Map (ButtonMask,KeySym) (X ()))
-- layoutHook         :: (l Window)
-- logHook            :: (X ())
-- manageHook         :: ManageHook
-- modMask            :: KeyMask
-- mouseBindings      :: (XConfig Layout -> M.Map (ButtonMask, Button) (Window -> X ()))
-- normalBorderColor  :: String
-- startupHook        :: (X ())
-- terminal           :: String
-- workspaces         :: [String]

--- }}} Totally not a lens... -------------------------------------------------
