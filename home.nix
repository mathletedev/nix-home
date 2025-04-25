{ pkgs, ... }:

let
  pkgsUnstable = import <nixpkgs-unstable> { };
in
# nix-gaming = import (builtins.fetchTarball "https://github.com/fufexan/nix-gaming/archive/master.tar.gz");
{
  home = {
    file = {
      ".config/bat" = {
        source = ./src/bat;
        recursive = true;
      };
      ".config/helix" = {
        source = ./src/helix;
        recursive = true;
      };
      ".config/neovide" = {
        source = ./src/neovide;
        recursive = true;
      };
      ".config/nvim" = {
        source = ./src/nvim;
        recursive = true;
      };
      ".config/yazi" = {
        source = ./src/yazi;
        recursive = true;
      };
      ".ghc" = {
        source = ./src/.ghc;
        recursive = true;
      };
      ".npmrc".source = ./src/.npmrc;
      # ".config/xilinx/nix.sh".text = ''
      #   INSTALL_DIR=$HOME/tools/Xilinx
      #   VERSION=2024.1
      # '';
    };
    homeDirectory = "/home/neo";
    keyboard.options = [ "caps:escape" ];
    packages = with pkgs; [
      air
      arduino-ide
      pkgsUnstable.airshipper
      alsa-utils
      android-file-transfer
      appimage-run
      asciiquarium
      audacity
      bat
      betterdiscordctl
      black
      blanket
      busybox
      pkgsUnstable.bun
      cascadia-code
      # cava
      clang-tools
      cling
      cmake
      cmatrix
      discord
      # dune_3
      eb-garamond
      pkgsUnstable.electron-mail
      elixir
      erlang
      eslint_d
      evince
      eza
      firefox-devedition-bin
      flutter
      foliate
      font-awesome
      fswatch
      gcc14
      gdb
      gdtoolkit_4
      ghc
      ghcid
      pkgsUnstable.gimp3
      pkgsUnstable.gleam
      gnumake
      go
      godot_4
      grim
      grimblast
      haskell-language-server
      haskellPackages.cabal-gild
      haskellPackages.cabal-install
      heroic
      hunspell
      hunspellDicts.en_GB-ise
      inkscape
      inotify-tools
      jdk11
      jetbrains.clion
      kdenlive
      krita
      lexical
      libqalculate
      libreoffice-qt
      libresprite
      lua
      lxgw-wenkai
      lxqt.lxqt-policykit
      minetest
      musescore
      neovide
      pkgsUnstable.neovim
      (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
      networkmanagerapplet
      nitrogen
      # nix-gaming.packages.${pkgs.hostPlatform.system}.wine-ge
      nix-output-monitor
      nixfmt-rfc-style
      nmap
      nodejs
      nodePackages.prettier
      notify-desktop
      obsidian
      # ocaml
      # ocamlPackages.ocaml-lsp
      # ocamlPackages.ocamlformat
      # ocamlPackages.utop
      oneko
      opam
      openssl
      ormolu
      # pkgsUnstable.oxlint
      p7zip
      pavucontrol
      pfetch
      piper
      pipes
      prettierd
      protonvpn-gui
      python3
      python312Packages.pip
      qalculate-gtk
      ripgrep
      roboto
      rustup
      scrcpy
      showmethekey
      slurp
      spotify
      steam
      stylua
      stylish-haskell
      sumneko-lua-language-server
      swww
      tree-sitter
      tty-clock
      ubuntu_font_family
      ungoogled-chromium
      usbutils
      unzip
      uxplay
      ventoy
      victor-mono
      vlc
      way-displays
      wl-clipboard
      (xfce.thunar.override {
        thunarPlugins = [
          file-roller
          xfce.thunar-archive-plugin
          xfce.tumbler
        ];
      })
      xournalpp
      xwaylandvideobridge
      xz
      yazi
      zip
    ];
    pointerCursor = {
      gtk.enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
      x11.enable = true;
    };
    sessionPath = [
      "$HOME/.bun/bin"
      "$HOME/.config/home-manager/bin"
      "$HOME/.npm-packages/bin"
      "$HOME/bin"
    ];
    sessionVariables = {
      BAT_THEME = "Catppuccin Mocha";
      EDITOR = "nvim";
      MOZ_USE_XINPUT2 = "1";
      NIXOS_OZONE_WL = "1";
      PF_INFO = "ascii title os uptime pkgs wm shell editor";
      PROTON_VERSION = "Proton Experimental";
      QT_STYLE_OVERRIDE = "kvantum";
    };
    shellAliases = {
      home = "vi ~/.config/home-manager";
      ls = "eza --all --long --git";
      nix-xilinx = "nix run gitlab:doronbehar/nix-xilinx#xilinx-shell";
      vi = "nvim";
      # vi = "neovide --fork";
      vim = "vi";
      vivado = "nix run gitlab:doronbehar/nix-xilinx#vivado";
    };
    stateVersion = "24.05";
    username = "neo";
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fish = {
      enable = true;
      functions = {
        fish_user_key_bindings = "fish_vi_key_bindings";
        fish_greeting = ''
          echo
          pfetch
        '';
        y = ''
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          yazi $argv --cwd-file="$tmp"
          if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"
        '';
      };
      shellAbbrs = {
        "-" = "cd -";
        n = "kitty &";
      };
      shellInit = "direnv hook fish | source";
    };
    git = {
      enable = true;
      extraConfig = {
        credential.helper = "store";
        init.defaultBranch = "main";
      };
      userName = "Neal Wang";
      userEmail = "nealwang.sh@protonmail.com";
    };
    helix.enable = true;
    home-manager.enable = true;
    htop.enable = true;
    hyprlock = {
      enable = true;
      settings = {
        background = [
          {
            path = "/home/neo/Pictures/wallpapers/Inception.jpg";
            color = "#1e1e2e";
          }
        ];
      };
    };
    kitty = {
      enable = true;
      extraConfig = builtins.readFile ./src/kitty.conf;
      package = pkgsUnstable.kitty;
    };
    obs-studio.enable = true;
    rofi = {
      enable = true;
      extraConfig = {
        disable-history = false;
        display-drun = "   Apps ";
        display-run = "   Run ";
        hide-scrollbar = true;
        icon-theme = "Papirus";
        location = 0;
        modi = "run,drun";
        show-icons = true;
        sidebar-mode = true;
      };
      package = pkgs.rofi-wayland;
      theme = ./src/rofi.rasi;
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = false;
        line_break = {
          disabled = true;
        };
      };
    };
    waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          modules-left = [
            "custom/nixos"
            "hyprland/workspaces"
          ];
          modules-center = [ "clock" ];
          modules-right = [
            "battery"
            "pulseaudio"
            "tray"
          ];
          "custom/nixos" = {
            format = "<span size='x-large'></span> ";
            on-click = ''
              BG="$(find ~/Pictures/wallpapers -name '*.*' | shuf -n 1)" && swww img "$BG" --transition-type any
            '';
          };
          "hyprland/workspaces" = {
            format = "{icon}";
          };
          clock = {
            interval = 1;
            format = "{:%A • %Y-%m-%d • %H:%M:%S}";
          };
          battery = {
            interval = 1;
            format = " <span size='x-large'>{icon}</span> <span size='small' rise='4000'>{capacity} </span>";
            format-charging = " <span size='x-large'>󱐋</span> <span size='small' rise='4000'>{capacity} </span>";
            format-plugged = " <span size='x-large'></span> <span size='small' rise='4000'>{capacity} </span>";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
            states = {
              warning = 30;
              critical = 15;
            };
          };
          pulseaudio = {
            format = " <span size='x-large'>{icon}</span> <span size='small' rise='4000'>{volume}</span>";
            format-muted = "󰖁";
            format-icons = {
              default = [
                ""
                ""
                ""
                ""
              ];
            };
            on-click = "pavucontrol &";
          };
          tray = {
            icon-size = 20;
            spacing = 6;
          };
        };
      };
      style = ./src/waybar.css;
    };
    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
  };

  services = {
    dunst = {
      enable = true;
      settings = {
        global = {
          background = "#1e1e2e";
          corner_radius = 10;
          font = "Ubuntu 12";
          foreground = "#cdd6f4";
          frame_color = "#89b4fa";
          frame_width = 2;
          offset = "8x8";
          width = 400;
        };
        urgency_critical = {
          frame_color = "#f38ba8";
        };
        urgency_low = {
          frame_color = "#a6e3a1";
        };
      };
    };
    udiskie.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./src/hyprland.conf;
    xwayland.enable = true;
  };

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    font = {
      name = "Ubuntu";
      size = 11;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "blue";
      };
    };
    theme = {
      name = "Colloid-Dark-Catppuccin";
      package = pkgs.colloid-gtk-theme.override {
        tweaks = [
          "catppuccin"
          "black"
          "rimless"
        ];
      };
    };
  };

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/pdf" = [ "org.gnome.Evince.desktop" ];
    };
    defaultApplications = {
      "text/html" = [ "firefox-developer-edition.desktop" ];
      "x-scheme-handler/http" = [ "firefox-developer-edition.desktop" ];
      "x-scheme-handler/https" = [ "firefox-developer-edition.desktop" ];
      "x-scheme-handler/about" = [ "firefox-developer-edition.desktop" ];
      "x-scheme-handler/unknown" = [ "firefox-developer-edition.desktop" ];
      "application/pdf" = [ "org.gnome.Evince.desktop" ];
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-gtk
      libpinyin
    ];
  };
}
