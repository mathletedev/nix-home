import           System.IO

import qualified Data.Map                           as M

import           XMonad                             hiding ((|||))
import           XMonad.Actions.CopyWindow
import           XMonad.Actions.NoBorders
import           XMonad.Actions.SpawnOn
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Layout.GridVariants
import           XMonad.Layout.LayoutCombinators
import           XMonad.Layout.Renamed
import           XMonad.Layout.ResizableTile
import           XMonad.Layout.Spacing
import qualified XMonad.StackSet                    as W
import           XMonad.Util.EZConfig
import           XMonad.Util.Run

import           System.Taffybar.Support.PagerHints (pagerHints)

import           Graphics.X11.ExtraTypes.XF86

myTerminal = "kitty"
myBrowser = "firefox-developer-edition"
myFM = "thunar"
myModMask = mod4Mask
myBorderWidth = 0
myWorkspaces = map show [1..9]

mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

myManageHook = composeAll
  [ title =? "kitty" --> doRectFloat (W.RationalRect 0.375 0.375 0.25 0.25)
  ] <+> manageDocks <+> manageSpawn

icon x = "<span font_desc='Font Awesome 6 Free Solid' fgcolor='#74c7ec'>" ++ x ++ "</span>"

tall =
  renamed [Replace (icon "\xf338")]
  $ mySpacing 8
  $ ResizableTall 1 (3 / 100) (1 / 2) []
wide =
  renamed [Replace (icon "\xf337")]
  $ mySpacing 8
  $ Mirror (ResizableTall 1 (3 / 100) (1 / 2) [])
grid =
  renamed [Replace (icon "\xf047")]
  $ mySpacing 8
  $ Grid (16 / 10)
full =
  renamed [Replace (icon "\xf31e")]
  $ mySpacing 8
  $ Full

myLayoutHook = avoidStruts $ tall ||| wide ||| grid ||| full

myStartupHook = do
  spawn "taffybar"
  spawn "nm-applet --indicator"
  spawn "ibus start"

toggleFloat w = windows (\s ->
  if M.member w (W.floating s) then W.sink w s
  else (W.float w (W.RationalRect (1 / 3) (1 / 4) (1 / 2) (1 / 2)) s)
  )

myKeys =
  [ ("M-p",                    spawn "rofi -show drun")
  , ("M-r",                    spawn "rofi -show run")
  , ("M-c",                    kill1)
  , ("M-<Tab>",                sendMessage NextLayout)
  , ("M-<Up>",                 sendMessage MirrorExpand)
  , ("M-<Down>",               sendMessage MirrorShrink)
  , ("M-<Left>",               sendMessage Shrink)
  , ("M-<Right>",              sendMessage Expand)
  , ("M-<Return>",             spawn myTerminal)
  , ("M-b",                    spawn myBrowser)
  , ("M-m",                    spawn myFM)
  , ("M-d",                    spawn "arandr")
  , ("M-<Space>",              sendMessage $ JumpToLayout (icon "\xf31e"))
  , ("M-g",                    sendMessage $ JumpToLayout (icon "\xf047"))
  , ("M-f",                    withFocused toggleFloat)
  , ("M-t",                    withFocused $ windows . (flip W.float $ W.RationalRect 0 0 1 1))
  , ("M-n",                    spawn "nitrogen --set-tiled --random ~/Pictures/wallpapers --save")
  , ("M-l",                    spawn "xscreensaver-command -lock")
  , ("<Print>",                spawn "flameshot screen")
  , ("S-<Print>",              spawn "flameshot gui")
  , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute")
  , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute")
  , ("<XF86AudioMute>",        spawn "amixer set Master toggle")
  , ("<XF86AudioMicMute>",     spawn "amixer set Capture toggle")
  , ("<XF86Calculator>",       spawn (myTerminal ++ " -e qalc"))
  , ("<XF86HomePage>",         spawn (myBrowser ++ " https://todoist.com"))
  , ("<XF86Mail>",             spawn (myBrowser ++ " https://mail.proton.me/u/0/inbox"))
  ]

main = do
  xmonad $ ewmh $ ewmhFullscreen $ pagerHints $ docks $ def
    { terminal    = myTerminal
    , modMask     = myModMask
    , borderWidth = myBorderWidth
    , workspaces  = myWorkspaces
    , manageHook  = myManageHook
    , layoutHook  = myLayoutHook
    , startupHook = myStartupHook
    } `additionalKeysP` myKeys
