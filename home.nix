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
        start = [ myConfig ];
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
      libsForQt5.qtstyleplugin-kvantum
      lua
      lxappearance
      myNeovim
      (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
      nitrogen
      nodejs
      nodePackages.eslint_d
      nodePackages.prettier_d_slim
      notify-desktop
      obsidian
      papirus-icon-theme
      pfetch
      rustup
      rust-analyzer
      screenkey
      spotify
      stylua
      sumneko-lua-language-server
      unzip
      xclip
      xdotool
    ];
    pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 16;
      x11.enable = true;
    };
    sessionPath = [ "$HOME/.config/nixpkgs/bin" ];
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
        opacity-rule = [ "100:class_i = 'screenkey'" ];
        round-borders = 1;
        rounded-corners-exclude = [ "class_i = 'screenkey'" ];
        shadow = true;
      };
    };
  };

  xsession = {
    enable = true;
    profileExtra = "xrandr --output DP-1 --left-of VGA-1\nnitrogen --restore";
    windowManager.xmonad = {
      enable = true;
      config = ~/.config/nixpkgs/src/xmonad.hs;
      enableContribAndExtras = true;
      extraPackages = hp: [ hp.alsa-core hp.alsa-mixer hp.xmobar ];
    };
  };
}
