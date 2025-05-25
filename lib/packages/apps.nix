with import <nixpkgs> { };

let
  pkgsUnstable = import <nixpkgs-unstable> { };
in
[
  audacity
  brave
  pkgsUnstable.electron-mail
  evince
  firefox-devedition-bin
  foliate
  gimp3
  inkscape
  kdePackages.kdenlive
  krita
  pkgsUnstable.legcord
  libqalculate
  libreoffice-qt
  libresprite
  musescore
  obsidian
  qalculate-gtk
  seahorse
  steam
  vlc
  (xfce.thunar.override {
    thunarPlugins = [
      file-roller
      xfce.thunar-archive-plugin
      xfce.tumbler
    ];
  })
  yazi
]
