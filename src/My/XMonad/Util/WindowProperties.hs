{-# LANGUAGE NoImplicitPrelude #-}

module My.XMonad.Util.WindowProperties where

import Control.Monad ((>>=), return)
import Control.Monad.Reader (ask)
import Data.Bits (testBit)
import Data.Bool (Bool(False), not)
import Data.Function (($))
import Data.Maybe (Maybe(Just))

import XMonad (Query, liftX)
import XMonad.Util.WindowProperties (getProp32s)

doesNotAcceptInput :: Query Bool
doesNotAcceptInput = ask >>= \ w -> liftX $ do
    p <- getProp32s "WM_HINTS" w
    return $ case p of
        Just (_:n:_) -> not (n `testBit` 0) -- Accept Intput Bit... 0 if does not accept input
        _ -> False

