{-# LANGUAGE OverloadedStrings #-}

import           Control.Monad.IO.Class

import           Data.Default                                (def)
import qualified Data.Text                                   as T

import           System.Taffybar
import           System.Taffybar.Information.CPU
import           System.Taffybar.Information.Memory
import           System.Taffybar.SimpleConfig
import           System.Taffybar.Widget
import           System.Taffybar.Widget.Generic.Graph
import           System.Taffybar.Widget.Generic.PollingGraph
import           System.Taffybar.Widget.Generic.PollingLabel
import           System.Taffybar.Widget.Layout

import           System.Process

import qualified GI.Gtk                                      as Gtk

parseRGB (r, g, b) = (r / 256, g / 256, b / 256, 1)
colours "red"    = parseRGB (243, 139, 168)
colours "mauve"  = parseRGB (203, 166, 247)
colours "sapphire" = parseRGB (116, 199, 236)

icon x = "<span font_desc='Font Awesome 6 Free Solid'>" ++ x ++ "</span>"
font x = "<span font_desc='CaskaydiaCove NF Bold 10'>" ++ x ++ "</span>"

myGraphConfig = defaultGraphConfig
  { graphPadding = 0
  , graphBorderWidth = 0
  , graphWidth = 75
  , graphBackgroundColor = (0.0, 0.0, 0.0, 0.0)
  }

textW x = do
  label <- liftIO $ Gtk.labelNew (Nothing :: Maybe T.Text)
  liftIO $ Gtk.labelSetMarkup label x
  l <- Gtk.toWidget label
  liftIO $ Gtk.widgetShowAll l
  return l

customW interval f = do
  l <- pollingLabelNew interval f
  liftIO $ Gtk.widgetShowAll l
  return l

volumeIcon x
  | T.isInfixOf "off" (T.pack x) = icon "\xf6a9" ++ " " ++ font "MUTE"
  | read num > 50                = icon "\xf028" ++ " " ++ font (num ++ "%")
  | read num > 0                 = icon "\xf027" ++ " " ++ font (num ++ "%")
  | otherwise                    = icon "\xf026" ++ " " ++ font (num ++ "%")
  where
    num  = takeWhile (/= '%') x
getVolume = do
  output1 <- readProcess "amixer" ["sget", "Master"] []
  output2 <- readProcess "egrep" ["-o", "[0-9]+%\\] \\[.*"] output1
  output3 <- readProcess "head" ["-n", "1"] output2
  let volume = colorize "#a6e3a1" "" . volumeIcon $ output3
  return . T.pack $ volume

cpuCallback = do
  (_, systemLoad, totalLoad) <- cpuLoad
  return [ totalLoad, systemLoad ]

memCallback = do
  memInfo <- parseMeminfo
  return [ memoryUsedRatio memInfo ]

main = do
  let workspaces = workspacesNew def
      layout     = layoutNew def
      clock      = textClockNew Nothing (font "%a %b %d %H:%M:%S") 1
      volume     = customW 1 getVolume
      battery    = textBatteryNew ("<span fgcolor='#f9e2af'>" ++ icon "\xe0b7" ++ " " ++ font "$percentage$%" ++ "</span>")
      cpu        = pollingGraphNew myGraphConfig { graphDataColors = [ colours "red" ], graphLabel = Just "CPU" } 0.5 cpuCallback
      memory     = pollingGraphNew myGraphConfig { graphDataColors = [ colours "mauve" ], graphLabel = Just "MEM" } 0.5 memCallback
      network    = networkGraphNew myGraphConfig { graphDataColors = [ colours "sapphire" ], graphLabel = Just "NET" } Nothing
      tray       = sniTrayNew

  simpleTaffybar def
    { widgetSpacing = 0
    , startWidgets  = [ workspaces, textW " ", layout ]
    , centerWidgets = [ clock ]
    , endWidgets    = [ tray, network, memory, cpu, textW "  ", battery, textW "  ", volume ]
    }
