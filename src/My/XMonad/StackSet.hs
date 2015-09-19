{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.StackSet (simpleView) where

import Data.Bool (otherwise)
import Data.Eq (Eq, (==))
import Data.Function (($), (.), on)
import Data.List (any, deleteBy, minimumBy)
import Data.Ord (Ord, compare)

import qualified XMonad.StackSet as W

-- Alternative to W.view and W.greedyView.
-- One workspace per screen except for main screen
-- which "holds" all other workspaces
simpleView :: (Eq i, Ord b) => i -> W.StackSet i l a b sd -> W.StackSet i l a b sd
simpleView i s
    -- Same workspace requested
    | i == W.currentTag s = s
    -- If worspace is visible it becomes current
    -- (Whaw W.view would do anyway)
    | any (iTag . W.workspace) (W.visible s) = W.view i s
    -- If workspace is hidden then jump to main screen and make it current
    -- | Just x <- L.find iTag (W.hidden s)
    | any iTag (W.hidden s) = W.view i $ s
        { W.current = mainScreen
        , W.visible = deleteBy ((==) `on` W.screen) mainScreen $ W.screens s
        }
    -- Error? (Probably out of bounds or something) Do not change anything...
    | otherwise = s
    where
    iTag = (i ==) . W.tag
    mainScreen = minimumBy (compare `on` W.screen) $ W.screens s

