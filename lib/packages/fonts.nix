with import <nixpkgs> { };

let
  pkgsUnstable = import <nixpkgs-unstable> { };
in
[
  cascadia-code
  eb-garamond
  font-awesome
  lxgw-wenkai
  nerd-fonts.caskaydia-cove
  roboto
  ubuntu_font_family
  victor-mono
]
