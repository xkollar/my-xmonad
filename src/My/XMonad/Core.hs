{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.Core (spawn, spawn') where

import Prelude (String)

import Control.Monad (Functor, void)
import Control.Monad.IO.Class (MonadIO)
import Data.Bool (Bool(True))
import Data.Function (($), (.))
import Data.Maybe (Maybe(Nothing))

import XMonad.Core (xfork)
import System.Posix.Process (executeFile)

spawn :: (Functor m, MonadIO m) => String -> [String] -> m ()
spawn command args = void . xfork $ executeFile command True args Nothing

spawn' :: (Functor m, MonadIO m) => String -> m ()
spawn' command = spawn command []
