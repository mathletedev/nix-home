with import <nixpkgs> { };

let
  pkgsUnstable = import <nixpkgs-unstable> { };
in
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
  gopls
  haskell-language-server
  haskellPackages.cabal-gild
  haskellPackages.cabal-install
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
  pyright
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
