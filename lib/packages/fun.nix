with import <nixpkgs> { };

let
  pkgsUnstable = import <nixpkgs-unstable> { };
in
[
  pkgsUnstable.airshipper
  asciiquarium
  blanket
  cmatrix
  heroic
  minetest
  # nix-gaming.packages.${pkgs.hostPlatform.system}.wine-ge
  oneko
  pfetch
  pipes
  tty-clock
]
