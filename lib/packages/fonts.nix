with import <nixpkgs> { };

let
  pkgsUnstable = import <nixpkgs-unstable> { };
in
[
  cascadia-code
  eb-garamond
  font-awesome
  lxgw-wenkai
  (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
  roboto
  ubuntu_font_family
  victor-mono
]
