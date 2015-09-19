module Main (main) where

import XMonad (xmonad)
import My.XMonad.Config (myConfig)

main :: IO ()
main = xmonad myConfig
