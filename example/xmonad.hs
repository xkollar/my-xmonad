module Main (main) where

import XMonad (xmonad, (<+>))
import XMonad.Util.Run (spawnPipe)

import My.XMonad.Config.Compositing (addCompositing)
import My.XMonad.Config (myConfig)
import My.XMonad.Config.Tools (update, keys)
import My.XMonad.Config.Xmobar (addXmobar)
import My.XMonad.Multimedia.Amixer (alsaKeys)


main :: IO ()
main = do
    h <- spawnPipe "xmobar"
    xmonad
        . update keys (alsaKeys <+>)
        . addCompositing 0.8
        $ addXmobar h myConfig
