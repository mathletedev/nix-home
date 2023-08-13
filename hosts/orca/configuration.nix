{ config, pkgs, ... }:

{
  imports = [
    <nixos-hardware/microsoft/surface/common>
    ./hardware-configuration.nix
  ];

  microsoft-surface.kernelVersion = "6.1.18";

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  networking = {
    firewall.enable = true;
    hostName = "orca";
    networkmanager.enable = true;
    resolvconf.dnsExtensionMechanism = false;
  };

  time.timeZone = "America/Los_Angeles";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services = {
    blueman.enable = true;
    logind.lidSwitch = "suspend";
    udisks2.enable = true;
    upower.enable = true;
    xserver = {
      enable = true;
      libinput = {
        enable = true;
        touchpad = {
          middleEmulation = true;
          naturalScrolling = true;
          tapping = true;
        };
      };
      windowManager.xmonad.enable = true;
      xkbOptions = "caps:escape";
    };
  };

  sound.enable = true;

  hardware = {
    bluetooth.enable = true;
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

  environment.systemPackages = with pkgs; [ git neovim ];

  programs = {
    fish.enable = true;
    slock.enable = true;
  };

  system.stateVersion = "23.05";
}
