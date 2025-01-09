{ pkgs, ... }:

let
  pkgsUnstable = import <nixpkgs-unstable> { };
  # nix-gaming = import (builtins.fetchTarball "https://github.com/fufexan/nix-gaming/archive/master.tar.gz");
in
{
  home = {
    file = {
      ".config/helix" = {
        source = ./src/helix;
        recursive = true;
      };
      ".config/nvim" = {
        source = ./src/nvim;
        recursive = true;
      };
      ".config/neovide/config.toml".text = ''
        [font]
        normal = [ "Cascadia Code" ]
        size = 12

        [font.features]
        "Cascadia Code" = [ "+ss01"  ]
      '';
      ".config/xilinx/nix.sh".text = ''
        INSTALL_DIR=$HOME/tools/Xilinx
        VERSION=2024.1
      '';
      ".npmrc".text = "prefix=~/.npm-packages";
    };
    homeDirectory = "/home/neo";
    keyboard.options = [ "caps:escape" ];
    packages = with pkgs; [
      air
      alsa-utils
      android-file-transfer
      appimage-run
      asciiquarium
      audacity
      bat
      betterdiscordctl
      black
      blanket
      pkgsUnstable.bun
      cascadia-code
      # cava
      clang-tools
      cling
      cmake
      cmatrix
      discord
      eb-garamond
      pkgsUnstable.electron-mail
      erlang
      eza
      firefox-devedition-bin
      flutter
      foliate
      font-awesome
      gcc14
      gdb
      gdtoolkit_4
      ghc
      gimp
      pkgsUnstable.gleam
      gnumake
      pkgsUnstable.go
      pkgsUnstable.godot_4
      grim
      grimblast
      haskell-language-server
      haskellPackages.cabal-install
      heroic
      hunspell
      hunspellDicts.en_GB-ise
      inkscape
      jdk11
      jetbrains.clion
      kdenlive
      krita
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
      nmap
      nodejs
      nodePackages.prettier
      notify-desktop
      obsidian
      oneko
      openssl
      ormolu
      pkgsUnstable.oxlint
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
      tty-clock
      ubuntu_font_family
      ungoogled-chromium
      usbutils
      unzip
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
      BAT_THEME = "catppuccin";
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
      vi = "neovide --fork";
      vim = "vi";
      vivado = "nix run gitlab:doronbehar/nix-xilinx#vivado";
    };
    stateVersion = "24.05";
    username = "neo";
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
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
            path = "/home/neo/Pictures/wallpapers/Countach.jpg";
            color = "#1e1e2e";
          }
        ];
      };
    };
    kitty = {
      enable = true;
      extraConfig = builtins.readFile ./src/kitty.conf;
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
        line_break = { disabled = true; };
      };
    };
    waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          modules-left = [ "custom/nixos" "hyprland/workspaces" ];
          modules-center = [ "clock" ];
          modules-right = [ "battery" "pulseaudio" "tray" ];
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
            format = " <span size='x-large'>{icon}</span> <span size='small' rise='4000'>{capacity}% </span>";
            format-charging = " <span size='x-large'>󱐋</span> <span size='small' rise='4000'>{capacity}% </span>";
            format-icons = [ "" "" "" "" "" ];
            states = {
              warning = 30;
              critical = 15;
            };
          };
          pulseaudio = {
            format = " <span size='x-large'>{icon}</span> <span size='small' rise='4000'>{volume}%</span>";
            format-muted = "󰖁";
            format-icons = {
              default = [ "" "" "" "" ];
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
        urgency_critical = { frame_color = "#f38ba8"; };
        urgency_low = { frame_color = "#a6e3a1"; };
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
        tweaks = [ "catppuccin" "black" "rimless" ];
      };
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
