let
  apps = import ./apps.nix;
  cli = import ./cli.nix;
  dev = import ./dev.nix;
  fonts = import ./fonts.nix;
  fun = import ./fun.nix;
  langs = import ./langs.nix;
  system = import ./system.nix;
in
apps ++ cli ++ dev ++ fonts ++ fun ++ langs ++ system
