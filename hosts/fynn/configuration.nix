{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 3000 8080 8128 ];
    };
    hostName = "fynn";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Los_Angeles";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services = {
    openssh = {
      enable = true;
      ports = [ 8128 ];
    };
    udev.packages = [ pkgs.libwacom ];
    udisks2.enable = true;
    xserver = {
      enable = true;
      digimend.enable = true;
      displayManager = {
        autoLogin.enable = true;
        autoLogin.user = "neo";
        setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --left-of VGA-1";
      };
      wacom.enable = true;
      windowManager.xmonad.enable = true;
      xkbOptions = "caps:escape";
    };
  };

  sound.enable = true;

  hardware = {
    opengl.driSupport32Bit = true;
    pulseaudio.enable = true;
  };

  users = {
    defaultUserShell = pkgs.fish;
    users.neo = {
      extraGroups = [ "wheel" "networkmanager" "audio" ];
      isNormalUser = true;
    };
  };

  environment.systemPackages = with pkgs; [ neovim ];

  programs = {
    dconf.enable = true;
    slock.enable = true;
  };

  system.stateVersion = "22.11";
}
