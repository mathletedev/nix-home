with import <nixpkgs> { };

let
  pkgsUnstable = import <nixpkgs-unstable> { };
in
[
  alsa-utils
  android-file-transfer
  appimage-run
  fswatch
  gnumake
  grim
  grimblast
  hunspell
  hunspellDicts.en_GB-ise
  inotify-tools
  libsecret
  # lxqt.lxqt-policykit
  networkmanagerapplet
  notify-desktop
  pavucontrol
  piper
  polkit_gnome
  slurp
  swww
  way-displays
  kdePackages.xwaylandvideobridge
]
