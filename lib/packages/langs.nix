with import <nixpkgs> { };

let
  pkgsUnstable = import <nixpkgs-unstable> { };
in
[
  air
  black
  pkgsUnstable.bun
  clang-tools
  cling
  cmake
  # dune_3
  elixir
  erlang
  eslint_d
  flutter
  gcc14
  gdb
  gdtoolkit_4
  ghc
  ghcid
  pkgsUnstable.gleam
  go
  godot_4
  haskell-language-server
  haskellPackages.cabal-gild
  haskellPackages.cabal-install
  jdk11
  lexical
  lua
  nixfmt-rfc-style
  nodejs
  nodePackages.prettier
  # ocaml
  # ocamlPackages.ocaml-lsp
  # ocamlPackages.ocamlformat
  # ocamlPackages.utop
  # opam
  ormolu
  # pkgsUnstable.oxlint
  prettierd
  python3
  python312Packages.pip
  rustup
  stylua
  stylish-haskell
  sumneko-lua-language-server
]
