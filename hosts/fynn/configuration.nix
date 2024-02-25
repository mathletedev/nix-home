{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  nix.settings.auto-optimise-store = true;

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  networking = {
    firewall.enable = true;
    hostName = "fynn";
    networkmanager.enable = true;
    resolvconf.dnsExtensionMechanism = false;
  };

  time.timeZone = "America/Los_Angeles";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  users = {
    defaultUserShell = pkgs.fish;
    users.neo = {
      extraGroups = [ "wheel" "networkmanager" "audio" "adbusers" "dialout" ];
      isNormalUser = true;
    };
  };

  services = {
    blueman.enable = true;
    fprintd = {
      enable = true;
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-goodix;
      };
    };
    illum.enable = true;
    input-remapper.enable = true;
    logind.lidSwitch = "suspend";
    pipewire = {
      alsa = {
        enable = true;
        support32Bit = true;
      };
      enable = true;
      pulse.enable = true;
    };
    postgresql = {
      enable = true;
      authentication = lib.mkForce ''
        # Generated file; do not edit!
        # TYPE  DATABASE        USER            ADDRESS                 METHOD
        local   all             all                                     trust
        host    all             all             127.0.0.1/32            trust
        host    all             all             ::1/128                 trust
      '';
    };
    ratbagd.enable = true;
    udev.packages = with pkgs; [ android-udev-rules libwacom ];
    udisks2.enable = true;
    upower.enable = true;
    xserver = {
      displayManager.startx.enable = true;
      enable = true;
    };
  };

  security = {
    pam.services.swaylock = { };
    rtkit.enable = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    opengl.driSupport32Bit = true;
    opentabletdriver.enable = true;
  };

  environment.systemPackages = with pkgs; [ git ];

  programs = {
    adb.enable = true;
    dconf.enable = true;
    fish.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  gtk.iconCache.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
  };

  i18n.defaultLocale = "en_GB.UTF-8";
}
