import XMonad
import XMonad.Config.Xfce
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Layout.Decoration

import qualified Data.Map as M
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops

--import XMonad.Util.Font

--import Monad
import Data.Monoid (All (All), mappend)

-- Pipe Stuff
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog

import XMonad.Hooks.InsertPosition as H


main = do
--        h <- spawnPipe "xmobar"
        xmonad $ ewmh xfceConfig
            { terminal              = "terminal"
            , modMask               = mod4Mask
            , focusFollowsMouse     = False
            , workspaces            = ["1:main","2:dev","3:im","4","5","6","7","8","9","0"]
            , layoutHook            = avoidStruts $ smartBorders $ layoutHook xfceConfig
            , manageHook            = manageDocks <+> myManageHook <+> manageHook xfceConfig
            , normalBorderColor     = "#000000"
            , focusedBorderColor    = "#4878CC"
            , borderWidth           = 2
            , handleEventHook       = fullscreenEventHook `mappend` handleEventHook xfceConfig
            , startupHook = startup
--            , logHook = dynamicLogWithPP $ myPP { ppOutput = hPutStrLn h }
            } `additionalKeysP`
                [ ("M-z", spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
                , ("M-<F12>", spawn "~/bin/secondary.sh")
                , ("M-<F11>", spawn "~/bin/main.sh")
                --, ("M-S-q", spawn "gnome-session-save --shutdown-dialog")
                , ("M-S-q", spawn "xfce4-session-logout")
                , ("M-e", spawn "pcmanfm ~")
                ]

-- Log Hook PP
myPP = defaultPP  { ppCurrent = wrap "<fc=white,#4878CC> " " </fc>" 
                     , ppSep     = ""
                     , ppWsSep = ""
                     , ppVisible = wrap "<fc=black,DarkSlateGray4> " " </fc>" 
                     , ppLayout = \x -> "<fc=#4878CC,#000000>:: "
                                  ++ case x of
                                       "Mirror ResizableTall"   -> "MTiled"
                                       "ResizableTall"          -> "Tiled"
                                       "Tabbed Bottom Simplest" -> "Tabbed"
                                       "Tabbed Simplest"        -> "Tabbed"
                                       _                        -> x
                                  ++ "</fc> "
                     , ppTitle = \x -> if null x
                                         then ""
                                         else "<fc=#89A0C9,#000000>[" ++ shorten 83 x ++ "]</fc>"
                     , ppHidden = wrap "<fc=#aaa,#000000> " " </fc>"
                     }

-- Startup Script
startup :: X()
startup = do{
            spawn "~/.xmonadrc"
            }

-- Manage Hooks
myManageHook = composeAll
    [ isFullscreen --> doFullFloat
    , className =? "Xfce4-notifyd"      --> doF W.focusDown
    , className =? "Xfce4-notifyd"      --> doFloat
--    , className =? "Firefox"            --> doShift "1:main"
--    , className =? "Google-chrome"      --> doShift "1:main"
    , className =? "Gnome-terminal"     --> doShift "2:dev"
    , className =? "Terminal"           --> doShift "2:dev"
    , className =? "Pidgin"             --> doShift "3:im"
    , className =? "Empathy"             --> doShift "3:im"
    , className =? "empathy"             --> doShift "3:im"
    , className =? "empathy-chat"             --> doShift "3:im"
    , className =? "Lanikai"            --> doShift "3:im"
    , className =? "Wine"          --> doShift "4"
    , className =? "SC2.exe"            --> doShift "5"
    --, className =? "MPlayer"            --> doFullFloat
    --, className =? "Gnome-mplayer"      --> doFullFloat
    , className =? "trayer"             --> (doF W.swapDown)
    ]
