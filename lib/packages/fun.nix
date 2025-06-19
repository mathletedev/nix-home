{ pkgs, pkgsUnstable }:

with pkgs;
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
