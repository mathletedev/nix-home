{ pkgs, ... }:

let
  myConfig = pkgs.vimUtils.buildVimPlugin {
    name = "fynn";
    src = ./src/nvim;
  };
  myNeovim = pkgs.neovim.override {
    configure = {
      customRC = "lua require \"init\"";
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [ myConfig packer-nvim ];
        opt = [ ];
      };
    };
  };
in
{
  home = {
    homeDirectory = "/home/neo";
    keyboard.options = [ "caps:swapescape" ];
    packages = with pkgs; [
      asciiquarium
      betterdiscordctl
      brave
      cascadia-code
      discord
      dolphin
      font-awesome
      gcc
      gimp
      go
      haskellPackages.xmobar
      libqalculate
      libsForQt5.qtstyleplugin-kvantum
      lua
      lxappearance
      myNeovim
      (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
      nitrogen
      nmap
      nodejs
      nodePackages.eslint_d
      nodePackages.prettier
      notify-desktop
      obs-studio
      obsidian
      onlyoffice-bin
      papirus-icon-theme
      pipes
      pfetch
      rustup
      rust-analyzer
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
    ];
    pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 16;
      x11.enable = true;
    };
    sessionPath = [ "$HOME/.config/nixpkgs/bin" "$HOME/.bun/bin" ];
    sessionVariables = {
      BAT_THEME = "catppuccin";
      EDITOR = "nvim";
      PF_INFO = "ascii title os uptime pkgs de shell editor";
      QT_STYLE_OVERRIDE = "kvantum";
    };
    shellAliases = { ls = "exa --all --long --git"; };
    stateVersion = "22.11";
    username = "neo";
  };

  fonts.fontconfig.enable = true;

  programs = {
    bat.enable = true;
    exa.enable = true;
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
      shellAliases = { home = "nvim ~/.config/nixpkgs"; };
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
      theme = ~/.config/nixpkgs/assets/catppuccin.rasi;
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
        opacity-rule = [ "100:window_type = 'dock'" "100:class_i = 'screenkey'" "100:name *= 'Discord'" ];
        round-borders = 1;
        rounded-corners-exclude = [ "window_type = 'dock'" "class_i = 'screenkey'" ];
        shadow = true;
        vSync = true;
      };
    };
    status-notifier-watcher.enable = true;
  };

  xsession = {
    enable = true;
    profileExtra = "xrandr --output DP-1 --left-of VGA-1\nnitrogen --restore";
    windowManager.xmonad = {
      enable = true;
      config = ./src/xmonad.hs;
      enableContribAndExtras = true;
      extraPackages = hp: [ hp.alsa-core hp.alsa-mixer hp.taffybar ];
    };
  };

  xdg.configFile = {
    "taffybar/taffybar.hs".source = ./src/taffybar.hs;
    "taffybar/taffybar.css".source = ./assets/taffybar.css;
  };
}
