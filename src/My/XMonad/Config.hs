{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.Config (myConfig) where

import Prelude (String)

import Control.Monad ((>>), return)
import Data.Bool (Bool(False, True), not)
import Data.Char (isSpace)
import Data.Function ((.), ($))
import Data.List ((++), dropWhile, filter, map, nub, null, zip)
import qualified Data.Map.Lazy as M (Map, fromList)
import Data.Monoid (All(All))

import System.Exit (exitSuccess)

import qualified XMonad as XM
    ( XConfig
        ( XConfig
        , borderWidth
        , clickJustFocuses
        , focusFollowsMouse
        , focusedBorderColor
        , handleEventHook
        , keys
        , layoutHook
        , logHook
        , manageHook
        , modMask
        , mouseBindings
        , normalBorderColor
        , startupHook
        , terminal
        , workspaces
        )
    )
import XMonad
    ( X
    , Button
    , Dimension
    , Event
    , KeyMask
    , KeySym
    , Layout
    , ManageHook
    , Window
    , X
    , (.|.)
    , button1
    , button2
    , button3
    , composeAll
    , defaultConfig
    , io
    , mod4Mask
    , noModMask
    , shiftMask
    , xK_1
    , xK_9
    , xK_Return
    , xK_Tab
    , xK_b
    , xK_c
    , xK_comma
    , xK_h
    , xK_j
    , xK_k
    , xK_l
    , xK_m
    , xK_n
    , xK_p
    , xK_period
    , xK_q
    , xK_space
    , xK_t
    )
import XMonad.Hooks.ManageHelpers (isFullscreen, doCenterFloat, doFullFloat )
import XMonad.Layout
    ( Full
    , IncMasterN(IncMasterN)
    , Mirror
    , Resize(Expand, Shrink)
    , Tall
    , ChangeLayout(NextLayout)
    , Choose
    )
import XMonad.Layout.LayoutModifier (ModifiedLayout)
import XMonad.Layout.NoBorders (smartBorders, SmartBorder)
import XMonad.ManageHook ((-->), (=?), className)
import XMonad.Hooks.ManageDocks
    ( AvoidStruts
    , ToggleStruts (ToggleStruts)
    , avoidStruts
    )
import XMonad.Prompt
    ( XPConfig
        ( font
        , historyFilter
        )
    , defaultXPConfig
    )
import XMonad.Prompt.Shell (shellPrompt)
import qualified XMonad.StackSet as W
import qualified XMonad.Operations as XM

import My.XMonad.Core (spawn', spawnSh)
import My.XMonad.StackSet (simpleView)


myConfig :: XM.XConfig (ModifiedLayout AvoidStruts (ModifiedLayout SmartBorder (Choose Tall (Choose (Mirror Tall) Full))))
myConfig = XM.XConfig
    { XM.borderWidth        = myBorderWidth
    , XM.workspaces         = myWorkspaces
    , XM.layoutHook         = myLayoutHook
    , XM.terminal           = "xterm"
    , XM.normalBorderColor  = "gray"
    , XM.focusedBorderColor = "red"
    , XM.modMask            = mod4Mask
    , XM.keys               = myKeys
    , XM.logHook            = return ()
    , XM.startupHook        = return ()
    , XM.mouseBindings      = myMouseBindings
    , XM.manageHook         = myManageHook
    , XM.handleEventHook    = myHandleEventHook
    , XM.focusFollowsMouse  = False
    , XM.clickJustFocuses   = True
    }

myBorderWidth :: Dimension
myBorderWidth = 1

myWorkspaces :: [String]
myWorkspaces = map (:[]) "αβγδεζηθι"

myLayoutHook :: ModifiedLayout
    AvoidStruts (ModifiedLayout SmartBorder (Choose Tall (Choose (Mirror Tall) Full)))
    Window
myLayoutHook = avoidStruts . smartBorders $ XM.layoutHook defaultConfig

myKeys :: XM.XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XM.XConfig {XM.modMask = modMask}) = M.fromList $
    [
      --- {{{ Launching and killing programs --------------------
      ((modMask .|. shiftMask, xK_Return), spawn' (XM.terminal conf)) -- %! Launch terminal
    , ((modMask,               xK_c), spawn' (XM.terminal conf)     ) -- %! Launch terminal
    , ((modMask .|. shiftMask, xK_c), XM.kill                       ) -- %! Close the focused window
    , ((modMask,               xK_p), myShellPrompt                 ) -- %! Launch prompt
      --- }}} Launching and killing programs --------------------

      --- {{{ Moving around -------------------------------------
    , ((modMask,               xK_space), XM.sendMessage NextLayout        ) -- %! Rotate through the available layout algorithms
    , ((modMask .|. shiftMask, xK_space), XM.setLayout $ XM.layoutHook conf) -- %!  Reset the layouts on the current workspace to default
    , ((modMask,               xK_n    ), XM.refresh                       ) -- %! Resize viewed windows to the correct size

      --- {{{ Move focus up or down the window stack ------------
    , ((modMask,               xK_Tab), XM.windows W.focusDown  ) -- %! Move focus to the next window
    , ((modMask .|. shiftMask, xK_Tab), XM.windows W.focusUp    ) -- %! Move focus to the previous window
    , ((modMask,               xK_j  ), XM.windows W.focusDown  ) -- %! Move focus to the next window
    , ((modMask,               xK_k  ), XM.windows W.focusUp    ) -- %! Move focus to the previous window
    , ((modMask,               xK_m  ), XM.windows W.focusMaster) -- %! Move focus to the master window
      --- }}} Move focus up or down the window stack ------------

      --- {{{ Modifying the window order ------------------------
    , ((modMask,               xK_Return), XM.windows W.swapMaster) -- %! Swap the focused window and the master window
    , ((modMask .|. shiftMask, xK_j     ), XM.windows W.swapDown  ) -- %! Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_k     ), XM.windows W.swapUp    ) -- %! Swap the focused window with the previous window
      --- }}} Modifying the window order ------------------------

      --- {{{ Resizing the master/slave ratio -------------------
    , ((modMask,               xK_h), XM.sendMessage Shrink) -- %! Shrink the master area
    , ((modMask,               xK_l), XM.sendMessage Expand) -- %! Expand the master area
      --- }}} Resizing the master/slave ratio -------------------

      -- Floating layer support
    , ((modMask,               xK_t), XM.withFocused $ XM.windows . W.sink) -- %! Push window back into tiling

      --- {{{ Increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), XM.sendMessage (IncMasterN 1)   ) -- %! Increment the number of windows in the master area
    , ((modMask              , xK_period), XM.sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area
      --- }}} Increase or decrease number of windows in the master area
      --- }}} Moving around -------------------------------------

    --- {{{ Quit or restart
    , ((modMask .|. shiftMask, xK_q), io exitSuccess) -- %! Quit xmonad
    , ((modMask              , xK_q), spawnSh
        "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad
    --- }}} Quit or restart

    -- Toggle Structure (status bars and such...)
    , ((modMask              , xK_b), XM.sendMessage ToggleStruts)
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), XM.windows $ f i)
        | (i, k) <- zip (XM.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(simpleView, noModMask), (W.shift, shiftMask)]]

myShellPrompt :: X ()
myShellPrompt = shellPrompt defaultXPConfig { historyFilter = hf , font = fn }
    where
    hf = nub . filter (not . null) . map (dropWhile isSpace)
    fn = "-*-Terminus-*-*-*-*-*-*-*-*-*-*-iso10646-*"


myMouseBindings :: XM.XConfig Layout -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings (XM.XConfig {XM.modMask = modMask}) = M.fromList
    -- mod-button1 %! Set the window to floating mode and move by dragging
    [ ((modMask, button1), \ w -> XM.focus w >> XM.mouseMoveWindow w
                                            >> XM.windows W.shiftMaster)
    -- mod-button2 %! Raise the window to the top of the stack
    , ((modMask, button2), XM.windows . (W.shiftMaster .) . W.focusWindow)
    -- mod-button3 %! Set the window to floating mode and resize by dragging
    , ((modMask, button3), \ w -> XM.focus w >> XM.mouseResizeWindow w
                                            >> XM.windows W.shiftMaster)
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

-- Some good defaults...
myManageHook :: ManageHook
myManageHook = composeAll
    [ isFullscreen --> doFullFloat
    , className =? "MPlayer" --> doCenterFloat
    , className =? "Xmessage" --> doCenterFloat
    , className =? "Gitk" --> doCenterFloat
    ]

myHandleEventHook :: Event -> X All
myHandleEventHook _ = return (All True)
