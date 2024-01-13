{ pkgs, ... }:

{
  home = {
    file = {
      ".npmrc".text = "prefix=~/.npm-packages";
      ".config/nvim" = {
        source = ./src/nvim;
        recursive = true;
      };
    };
    homeDirectory = "/home/neo";
    keyboard.options = [ "caps:escape" ];
    packages = with pkgs; [
      android-file-transfer
      appimage-run
      arduino-cli
      asciiquarium
      audacity
      bat
      betterdiscordctl
      black
      cascadia-code
      cava
      clang-tools
      cling
      cmatrix
      discord
      eb-garamond
      eza
      firefox-devedition-bin
      font-awesome
      gcc
      gimp
      go
      godot_4
      haskellPackages.xmobar
      heroic
      hunspell
      hunspellDicts.en_GB-ise
      jdk11
      kdenlive
      krita
      libqalculate
      libreoffice-qt
      lua
      lxappearance
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
      obs-studio
      obsidian
      oneko
      openssl
      p7zip
      pavucontrol
      pfetch
      pipes
      prettierd
      python311
      ripgrep
      roboto
      rustup
      screenkey
      spotify
      steam
      stylua
      stylish-haskell
      sumneko-lua-language-server
      taffybar
      tty-clock
      unzip
      vlc
      vscode-extensions.ms-vscode.cpptools
      xclip
      xdotool
      xfce.thunar
      zip
    ];
    pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 16;
      x11.enable = true;
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
      extraConfig.credential.helper = "store";
      userName = "Neal Wang";
      userEmail = "nealwang.sh@protonmail.com";
    };
    home-manager.enable = true;
    htop.enable = true;
    kitty = {
      enable = true;
      extraConfig = builtins.readFile ./src/kitty.conf;
    };
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
      theme = ~/.config/home-manager/assets/catppuccin.rasi;
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = false;
        line_break = { disabled = true; };
      };
    };
  };

  services = {
    dunst = {
      enable = true;
      settings = {
        global = {
          background = "#1e1e2e";
          corner_radius = 10;
          font = "CaskaydiaCove Nerd Font 10";
          foreground = "#cdd6f4";
          frame_color = "#89b4fa";
          frame_width = 4;
          offset = "16x50";
          width = 400;
        };
        urgency_critical = { frame_color = "#f38ba8"; };
        urgency_low = { frame_color = "#a6e3a1"; };
      };
    };
    flameshot.enable = true;
    picom = {
      enable = true;
      settings = {
        active-opacity = 1;
        backend = "glx";
        blur-method = "dual_kawase";
        blur-strength = 4;
        corner-radius = 10;
        fading = true;
        focus-exclude = [ "class_i = 'rofi'" "x = 0 && y = 0 && override_redirect = true" ];
        inactive-opacity = 0.6;
        opacity-rule = [
          "100:window_type = 'dock'"
          "100:class_i = 'screenkey'"
          "100:fullscreen"
          "100:name *= 'ibus'"
          "100:name *= 'Discord'"
        ];
        round-borders = 1;
        rounded-corners-exclude = [ "window_type = 'dock'" "class_i = 'screenkey'" ];
        shadow = true;
        vSync = true;
      };
    };
    status-notifier-watcher.enable = true;
    udiskie.enable = true;
    xscreensaver.enable = true;
  };

  xsession = {
    enable = true;
    profileExtra = "nitrogen --set-tiled --random ~/Pictures/wallpapers --save";
    windowManager.xmonad = {
      enable = true;
      config = ./src/xmonad.hs;
      enableContribAndExtras = true;
      extraPackages = hp: [ hp.alsa-core hp.alsa-mixer hp.taffybar ];
    };
  };

  systemd.user = {
    services.wallpaper = {
      Unit.Description = "nitrogen random wallpaper";
      Service = {
        ExecStart = toString (
          pkgs.writeShellScript "wallpaper.sh" "${pkgs.nitrogen}/bin/nitrogen --set-tiled --random ~/Pictures/wallpapers --save"
        );
        Type = "oneshot";
      };
      Install.WantedBy = [ "default.target" ];
    };
    timers.wallpaper = {
      Unit.Description = "timer for wallpaper service";
      Timer = {
        OnCalendar = "*:0/10";
        Unit = "wallpaper";
      };
      Install.WantedBy = [ "timers.target" ];
    };
  };

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
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

  xdg.configFile = {
    "taffybar/taffybar.hs".source = ./src/taffybar.hs;
    "taffybar/taffybar.css".source = ./assets/taffybar.css;
  };
}
