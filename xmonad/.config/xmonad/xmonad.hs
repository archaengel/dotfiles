import XMonad

import XMonad.Hooks.EwmhDesktops (ewmhFullscreen, ewmh)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.Loggers
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Actions.Navigation2D (navigation2DP, windowGo, windowSwap)
import XMonad.Layout.Spacing (spacingWithEdge)

main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
     $ navigation2DP def
        ("k", "h", "j", "l")
        [("M-", windowGo), ("M-S-", windowSwap)]
        False
     $ myConfig

myConfig = def
    { terminal              = "x-terminal-emulator"
    , borderWidth           = 3
    , focusedBorderColor    = "#f7768e"
    , layoutHook            = spacingWithEdge 3 $ myLayoutHook
    } `additionalKeysP` [
    ( "<Print>", spawn "flameshot gui -c -p ~/Pictures/Screenshots")
    , ("M-p", spawn "j4-dmenu-desktop --dmenu='dmenu -i'")
    , ("M-<Esc>", spawn "slock")
    , ("<XF86AudioLowerVolume>", spawn "amixer -q set Master 3%-")
    , ("<XF86AudioRaiseVolume>", spawn "amixer -q set Master 3%+")
    , ("<XF86AudioMute>", spawn "amixer -q set Master toggle")
    , ("<XF86AudioPlay>", spawn "playerctl play-pause")
    ]

myLayoutHook = tiled ||| Mirror tiled ||| Full
    where
        tiled = Tall nmaster delta ratio
        nmaster = 1
        ratio = 1/2
        delta = 3/100

myXmobarPP :: PP
myXmobarPP = def
    { ppSep = " • "
    , ppTitleSanitize = xmobarStrip
    , ppCurrent = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent = red . wrap (yellow "!") (yellow "!")
    , ppOrder = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras = [logTitles formatFocused formatUnfocused]
    }
        where
            formatFocused = wrap (white "[") (white "]") . magenta . ppWindow
            formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue . ppWindow

            ppWindow :: String -> String
            ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

            blue, lowWhite, magenta, red, white, yellow :: String -> String
            magenta  = xmobarColor "#ff79c6" ""
            blue     = xmobarColor "#bd93f9" ""
            white    = xmobarColor "#f8f8f2" ""
            yellow   = xmobarColor "#f1fa8c" ""
            red      = xmobarColor "#ff5555" ""
            lowWhite = xmobarColor "#bbbbbb" ""
