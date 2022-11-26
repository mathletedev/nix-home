{ pkgs, ... }:

{
	home = {
		homeDirectory = "/home/neo";
		keyboard.options = [ "caps:swapescape" ];
		packages = with pkgs; [
			betterdiscordctl
			brave
			discord
			dolphin
			font-awesome
			haskellPackages.xmobar
			(nerdfonts.override { fonts = [ "CascadiaCode" ]; })
			nitrogen
			notify-desktop
			pfetch
			rustup
			rust-analyzer
			screenkey
			spotify
			xdotool
		];
		sessionVariables = {
			BAT_THEME = "catppuccin";
			EDITOR = "nvim";
			NIXPKGS_ALLOW_UNFREE = 1;
			PF_INFO = "ascii title os uptime pkgs de shell editor";
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
				__fish_user_key_bindings_handler = {
					body = "fish_vi_key_bindings";
					onEvent = "fish_user_key_bindings";
				};
			};
			shellAbbrs = {
				"-" = "cd -";
				n = "kitty &";
			};
		};
		git = {
			enable = true;
			userName = "Neal Wang";
			userEmail = "nealwang.sh@protonmail.com";
		};
		home-manager.enable = true;
		htop.enable = true;
		kitty = {
			enable = true;
			extraConfig = builtins.readFile ./src/kitty.conf;
		};
		neovim.enable = true;
		rofi.enable = true;
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
		profileExtra = "xrandr --output DP-1 --left-of VGA-1";
		windowManager.xmonad = {
			enable = true;
			config = ~/.config/nixpkgs/src/xmonad.hs;
			enableContribAndExtras = true;
			extraPackages = hp: [ hp.alsa-core hp.alsa-mixer hp.xmobar ];
		};
	};
}
