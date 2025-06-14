with import <nixpkgs> {
  config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "beekeeper-studio-5.1.5"
    ];
  };
};

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
  wl-clipboard
]
