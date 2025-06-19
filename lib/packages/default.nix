{ pkgs, pkgsUnstable }:

let
  apps = import ./apps.nix { inherit pkgs pkgsUnstable; };
  cli = import ./cli.nix { inherit pkgs pkgsUnstable; };
  dev = import ./dev.nix { inherit pkgs pkgsUnstable; };
  fonts = import ./fonts.nix { inherit pkgs pkgsUnstable; };
  fun = import ./fun.nix { inherit pkgs pkgsUnstable; };
  langs = import ./langs.nix { inherit pkgs pkgsUnstable; };
  system = import ./system.nix { inherit pkgs pkgsUnstable; };
in
apps ++ cli ++ dev ++ fonts ++ fun ++ langs ++ system
