{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.Core
    ( KeyConfig
    , KeyMap
    , spawn
    , spawn'
    , spawnSh
    ) where

import Prelude (String)

import Control.Monad (Functor, void)
import Control.Monad.IO.Class (MonadIO)
import Data.Bool (Bool(True))
import Data.Function (($), (.))
import Data.Map.Lazy (Map)
import Data.Maybe (Maybe(Nothing))

import System.Posix.Process (executeFile)

import XMonad
    ( KeyMask
    , KeySym
    , Layout
    , X
    , XConfig
    )
import qualified XMonad.Core as X (spawn, xfork)

type KeyMap = Map (KeyMask, KeySym) (X ())
type KeyConfig = XConfig Layout -> KeyMap

spawn :: (Functor m, MonadIO m) => String -> [String] -> m ()
spawn command args = void . X.xfork $ executeFile command True args Nothing

spawn' :: (Functor m, MonadIO m) => String -> m ()
spawn' command = spawn command []

spawnSh :: MonadIO m => String -> m ()
spawnSh = X.spawn
