module Main (main) where

import System.IO (Handle, hPutStrLn)

import XMonad (xmonad, (<+>))
import XMonad.Util.Run (spawnPipe)

import My.XMonad.Config (myConfig)
import My.XMonad.Config.Compositing (addCompositing)
import My.XMonad.Config.Xmobar (addXmobar)
import My.XMonad.Multimedia.Amixer (alsaKeys)

import My.XMonad.Config.Tools (update, keys)


main :: IO ()
main = do
    h <- spawnPipe "xmobar"
    xmonad
        . update keys (alsaKeys <+>)
        . addCompositing 0.8
        $ addXmobar h myConfig
