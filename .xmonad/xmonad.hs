{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses, TypeSynonymInstances, FlexibleContexts, NoMonomorphismRestriction #-}

import XMonad
import XMonad.Config.Gnome
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Layout.Decoration
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Combo
import XMonad.Layout.Grid
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LayoutHints
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.TwoPane
import XMonad.Layout.WindowNavigation
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed


import XMonad.Util.WindowProperties

import qualified Data.Map as M
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops

import Control.Monad
import Data.Ratio

import System.IO

--import Monad
import Data.Monoid (All (All), mappend)

-- Pipe Stuff
import XMonad.Util.Run

import XMonad.Hooks.InsertPosition as H

import Dzen
import XMonad.Hooks.DynamicLog hiding (dzen)

main = do
        --h <- spawnPipe "xmobar"
        d <- spawnDzen myLeftBar
        spawnToDzen "~/bin/dzen/dzen2_right.sh" myRightBar
        xmonad $ ewmh gnomeConfig
            { terminal              = "gnome-terminal"
            , modMask               = mod4Mask
            , focusFollowsMouse     = False
            , workspaces            = ["1:main","2:dev","3:im","4","5","6","7","8","9","0"]
            , layoutHook            = myLayout --avoidStruts $ smartBorders $ onWorkspace "3-im" imLayout $ layoutHook gnomeConfig
            , manageHook            = manageDocks <+> myManageHook <+> manageHook gnomeConfig
            , normalBorderColor     = "#000000"
            , focusedBorderColor    = "#4878CC"
            , borderWidth           = 2
            , handleEventHook       = fullscreenEventHook `mappend` handleEventHook gnomeConfig
            , startupHook = startup
            --, logHook = dynamicLogWithPP $ myPP { ppOutput = hPutStrLn h }
            , logHook = dynamicLogWithPP $ myPP { ppOutput = hPutStrLn d }
            } `additionalKeysP`
                [ ("M-z", spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
                , ("M-<F10>", spawn "~/bin/display.sh main")
                , ("M-<F11>", spawn "~/bin/display.sh secondary")
                , ("M-<F12>", spawn "~/bin/display.sh extend")
                , ("M-S-q", spawn "gnome-session-quit --power-off")
                , ("M-S-w", spawn "gnome-session-quit")
                , ("M-e", spawn "nautilus ~")
                , ("M-s", spawn "sleep 0.2; ~/bin/shot.sh")
                ]

-- Layouts

myLayout = avoidStruts $ smartBorders $ onWorkspace "1:main" mainLayout $ onWorkspace "2:dev" mainLayout $ onWorkspace "3:im" imLayout $ defaultLayout
    where
        -- list layouts
        mainLayout = tiled ||| tall ||| Grid ||| Full
        defaultLayout = tall ||| Grid ||| Full
        imLayout = reflectHoriz $ withIMs ratio rosters chatLayout where
            chatLayout      = tall ||| Grid ||| Full
            ratio           = 0.1
            rosters         = [skypeRoster, pidginRoster]
            pidginRoster    = And (ClassName "Pidgin") (Role "buddy_list")
            skypeRoster     = And (ClassName"Skype") (Title "fallstoofast - Skype™ (Beta)")

        -- define layouts types
        tall = Tall 1 0.02 0.50
        tiled   = layoutHints $ ResizableTall 1 0.02 0.54 []



-- Log Hook PP
{-myPP = defaultPP  { ppCurrent = wrap "<fc=white,#4878CC> " " </fc>" 
                     , ppSep     = ""
                     , ppWsSep = ""
                     , ppVisible = wrap "<fc=black,DarkSlateGray4> " " </fc>" 
                     , ppLayout = \x -> "<fc=#4878CC,#000000>:: "
                                  ++ case x of
                                       "Hinted ResizableTall"   -> "Main Tiled"
                                       "ResizableTall"          -> "Tiled"
                                       "Tabbed Bottom Simplest" -> "Tabbed"
                                       "Tabbed Simplest"        -> "Tabbed"
                                       _                        -> x
                                  ++ "</fc> "
                     , ppTitle = \x -> if null x
                                         then ""
                                         else "<fc=#89A0C9,#000000>[" ++ shorten 83 x ++ "]</fc>"
                     , ppHidden = wrap "<fc=#aaa,#000000> " " </fc>"
                     }-}

myPP = defaultPP
    {
        ppCurrent           =   dzenColor "#ebac54" "#161616" . pad
      , ppVisible           =   dzenColor "#FFE5C2" "#161616" . pad
      , ppHidden            =   dzenColor "white" "#161616" . pad
      , ppHiddenNoWindows   =   dzenColor "#444444" "#161616" . pad
      , ppUrgent            =   dzenColor "red" "#161616" . pad
      , ppWsSep             =   " "
      , ppSep               =   "  |  "
      , ppLayout            =   dzenColor "#ebac54" "#161616" .
                                (\x -> case x of
                                       "Hinted ResizableTall"   -> "Main Tiled"
                                       "ResizableTall"          -> "Tiled"
                                       "Tabbed Bottom Simplest" -> "Tabbed"
                                       "Tabbed Simplest"        -> "Tabbed"
                                       _                        -> x
                                )
      , ppTitle             =   (" " ++) . dzenColor "white" "#161616" . dzenEscape
    }

-- 
-- StatusBars
-- 
myLeftBar :: DzenConf
myLeftBar = defaultDzen
    -- use the default as a base and override width and
    -- colors
    { width     = Just $ Percent 46
    , height    = Just 21
    , fg_color  = Just "#ffffff"
    , bg_color  = Just "#161616"
    , screen    = Just 0
    , font      = Just "-*-UnDotum-bold-r-normal-*-11-*-*-*-*-*-*-*"  
    , alignment = Just LeftAlign
    }

myRightBar = myLeftBar
    -- use the default as a base and override width and
    -- colors
    { x_position= Just $ Percent 46
    , width     = Just $ Percent 54 
    , alignment = Just LeftAlign
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
    , className =? "Skype"             --> doShift "3:im"
    , className =? "Lanikai"            --> doShift "3:im"
    , className =? "Wine"          --> doShift "4"
    , className =? "SC2.exe"            --> doShift "5"
    --, className =? "MPlayer"            --> doFullFloat
    --, className =? "Gnome-mplayer"      --> doFullFloat
    , className =? "trayer"             --> (doF W.swapDown)
    , className =? "VirtualBox"         --> (doShift "5")
    , className =? "Eclipse"         --> (doShift "2:dev")
    ]











data AddRosters a = AddRosters Rational [Property] deriving (Read, Show)
 
instance LayoutModifier AddRosters Window where
  modifyLayout (AddRosters ratio props) = applyIMs ratio props
  modifierDescription _                = "IMs"
 
-- | Modifier which converts given layout to IMs-layout (with dedicated
-- space for rosters and original layout for chat windows)
withIMs :: LayoutClass l a => Rational -> [Property] -> l a -> ModifiedLayout AddRosters l a
withIMs ratio props = ModifiedLayout $ AddRosters ratio props

gridIMs :: Rational -> [Property] -> ModifiedLayout AddRosters Grid a
gridIMs ratio props = withIMs ratio props Grid
 
hasAnyProperty :: [Property] -> Window -> X Bool
hasAnyProperty [] _ = return False
hasAnyProperty (p:ps) w = do
    b <- hasProperty p w
    if b then return True else hasAnyProperty ps w
 
-- | Internal function for placing the rosters specified by
-- -- the properties and running original layout for all chat windows

applyIMs :: (LayoutClass l Window) =>
               Rational
            -> [Property]
            -> W.Workspace WorkspaceId (l Window) Window
            -> Rectangle
            -> X ([(Window, Rectangle)], Maybe (l Window))
applyIMs ratio props wksp rect = do
    let stack = W.stack wksp
    let ws = W.integrate' $ stack
    rosters <- filterM (hasAnyProperty props) ws
    let n = fromIntegral $ length rosters
    let (rostersRect, chatsRect) = splitHorizontallyBy (n * ratio) rect
    let rosterRects = splitHorizontally n rostersRect
    let filteredStack = stack >>= W.filter (`notElem` rosters)
    (a,b) <- runLayout (wksp {W.stack = filteredStack}) chatsRect
    return (zip rosters rosterRects ++ a, b)
