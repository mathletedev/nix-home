{ pkgs, ... }:

{
  home = {
    file = {
      ".config/nvim" = {
        source = ./src/nvim;
        recursive = true;
      };
      ".npmrc".text = "prefix=~/.npm-packages";
    };
    homeDirectory = "/home/neo";
    keyboard.options = [ "caps:escape" ];
    packages = with pkgs; [
      alsa-utils
      android-file-transfer
      appimage-run
      asciiquarium
      audacity
      bat
      betterdiscordctl
      black
      # bun
      cascadia-code
      cava
      clang-tools
      cling
      cmake
      cmatrix
      discord
      eb-garamond
      eza
      firefox-devedition-bin
      font-awesome
      gcc
      gimp
      gnumake
      go
      godot_4
      grim
      grimblast
      heroic
      hunspell
      hunspellDicts.en_GB-ise
      jdk11
      jetbrains.clion
      jq # for swap-workspace, remove after Hyprland v0.35.0
      kdenlive
      krita
      libqalculate
      libreoffice-qt
      libresprite
      lua
      lxgw-wenkai
      minetest
      musescore
      neovim
      (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
      networkmanagerapplet
      nitrogen
      nmap
      nodejs
      nodePackages.eslint_d
      nodePackages.prettier
      notify-desktop
      obsidian
      oneko
      openssl
      p7zip
      pavucontrol
      pfetch
      piper
      pipes
      prettierd
      python311
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
      tradingview
      tty-clock
      ubuntu_font_family
      ungoogled-chromium
      unzip
      victor-mono
      vlc
      vscode-extensions.ms-vscode.cpptools
      way-displays
      wl-clipboard
      (xfce.thunar.override {
        thunarPlugins = [
          gnome.file-roller
          xfce.thunar-archive-plugin
          xfce.tumbler
        ];
      })
      xournal
      xwaylandvideobridge
      zip
    ];
    pointerCursor = {
      gtk.enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 16;
    };
    sessionPath = [
      "$HOME/.config/home-manager/bin"
      "$HOME/bin"
      "$HOME/.npm-packages/bin"
    ];
    sessionVariables = {
      BAT_THEME = "catppuccin";
      EDITOR = "nvim";
      MOZ_USE_XINPUT2 = "1";
      NIXOS_OZONE_WL = "1";
      PF_INFO = "ascii title os uptime pkgs wm shell editor";
      QT_STYLE_OVERRIDE = "kvantum";
    };
    shellAliases = {
      ls = "eza --all --long --git";
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
      shellAliases = {
        home = "nvim ~/.config/home-manager";
        vi = "nvim";
        vim = "nvim";
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
    home-manager.enable = true;
    htop.enable = true;
    kitty = {
      enable = true;
      extraConfig = builtins.readFile ./assets/kitty.conf;
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
      theme = ./assets/rofi.rasi;
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = false;
        line_break = { disabled = true; };
      };
    };
    swaylock = {
      settings.color = "000000";
      enable = true;
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
            format = " ";
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
            format = " {icon}";
            format-charging = " 󰚥";
            states = {
              warning = 30;
              critical = 15;
            };
            format-warning = " {icon}";
            format-critical = " {icon}";
            format-full = "  ";
            format-icons = [ " " " " " " " " " " ];
          };
          pulseaudio = {
            format = "{icon}";
            format-muted = "󰖁 ";
            format-icons = {
              default = [ " " " " " " ];
            };
            on-click = "pavucontrol &";
          };
          tray = {
            icon-size = 20;
            spacing = 6;
          };
        };
      };
      style = ./assets/waybar.css;
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
      name = "Catppuccin-Mocha-Compact-Lavender-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "mocha";
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
