with import <nixpkgs> { };

let
  pkgsUnstable = import <nixpkgs-unstable> { };
in
[
  arduino-ide
  beekeeper-studio
  godot
  neovide
  pkgsUnstable.neovim
  postman
  scrcpy
  showmethekey
  tree-sitter
  uxplay
  ventoy
  wl-clipboard
]
