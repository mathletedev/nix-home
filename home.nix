{ pkgs, ... }:

let
  neovimConfig = pkgs.vimUtils.buildVimPlugin {
    name = "fynn";
    src = ./src/nvim;
  };
  neovim = pkgs.neovim.override {
    configure = {
      customRC = "lua require \"init\"";
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [ neovimConfig packer-nvim ];
        opt = [ ];
      };
    };
  };
in
{
  home = {
    homeDirectory = "/home/neo";
    keyboard.options = [ "caps:escape" ];
    packages = with pkgs; [
      android-file-transfer
      arduino-cli
      asciiquarium
      audacity
      bat
      betterdiscordctl
      black
      cascadia-code
      cava
      clang-tools
      cmatrix
      discord
      eza
      firefox-devedition-bin
      font-awesome
      gcc
      gimp
      go
      haskellPackages.xmobar
      jdk11
      kdenlive
      krita
      libqalculate
      libsForQt5.dolphin
      libsForQt5.dolphin-plugins
      libsForQt5.qtstyleplugin-kvantum
      lua
      lxappearance
      lxgw-wenkai
      musescore
      neovim
      (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
      nitrogen
      nmap
      nodejs
      nodePackages.eslint_d
      nodePackages.prettier
      notify-desktop
      obs-studio
      obsidian
      oneko
      onlyoffice-bin
      openssl
      papirus-icon-theme
      pavucontrol
      pfetch
      pipes
      prettierd
      python311
      redshift
      ripgrep
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
      xclip
      xdotool
      zip
    ];
    pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 16;
      x11.enable = true;
    };
    sessionPath = [ "$HOME/.config/home-manager/bin" "$HOME/.bun/bin" ];
    sessionVariables = {
      BAT_THEME = "catppuccin";
      EDITOR = "nvim";
      PF_INFO = "ascii title os uptime pkgs wm shell editor";
      QT_STYLE_OVERRIDE = "kvantum";
    };
    shellAliases = { ls = "eza --all --long --git"; };
    stateVersion = "23.11";
    username = "neo";
  };

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs = {
    fish = {
      enable = true;
      functions = {
        fish_user_key_bindings = "fish_vi_key_bindings";
        fish_greeting = "echo\npfetch";
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
        opacity-rule = [ "100:window_type = 'dock'" "100:class_i = 'screenkey'" "100:name *= 'Discord'" "100:name *= 'YouTube'" "100:name *= 'Bilibili'" "100:name *= 'Animefever'" "100:name *= 'Aniwatch.to'" ];
        round-borders = 1;
        rounded-corners-exclude = [ "window_type = 'dock'" "class_i = 'screenkey'" ];
        shadow = true;
        vSync = true;
      };
    };
    status-notifier-watcher.enable = true;
    udiskie.enable = true;
  };

  xsession = {
    enable = true;
    profileExtra = "nitrogen --restore";
    windowManager.xmonad = {
      enable = true;
      config = ./src/xmonad.hs;
      enableContribAndExtras = true;
      extraPackages = hp: [ hp.alsa-core hp.alsa-mixer hp.taffybar ];
    };
  };

  gtk = {
    enable = true;
    iconTheme.name = "Papirus";
  };

  xdg.configFile = {
    "taffybar/taffybar.hs".source = ./src/taffybar.hs;
    "taffybar/taffybar.css".source = ./assets/taffybar.css;
  };
}
