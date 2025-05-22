with import <nixpkgs> { };

let
  pkgsUnstable = import <nixpkgs-unstable> { };
in
[
  bat
  # busybox
  # cava
  eza
  nix-output-monitor
  nmap
  openssl
  p7zip
  ripgrep
  unzip
  usbutils
  xz
  zip
]
