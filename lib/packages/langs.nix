{ pkgs, pkgsUnstable }:

with pkgs;
[
  air
  astro-language-server
  bash-language-server
  black
  pkgsUnstable.bun
  clang-tools
  cling
  cmake
  # dune_3
  elixir
  emmet-language-server
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
  gopls
  haskell-language-server
  haskellPackages.cabal-gild
  haskellPackages.cabal-install
  isort
  jdk11
  lexical
  lua
  nil
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
  pkgsUnstable.pyrefly
  python3
  python312Packages.pip
  rustup
  stylua
  stylish-haskell
  sumneko-lua-language-server
  svelte-language-server
  tailwindcss-language-server
  tinymist
  typescript-language-server
  vscode-langservers-extracted
  yaml-language-server
]
