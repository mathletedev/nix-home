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
      extraGroups = [ "wheel" "networkmanager" "audio" "adbusers" ];
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
    logind.lidSwitch = "suspend";
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
    udev.packages = with pkgs; [ android-udev-rules ];
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
      gdk-pixbuf.modulePackages = with pkgs; [ librsvg ];
      wacom.enable = true;
      windowManager.xmonad.enable = true;
      xkbOptions = "caps:escape";
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    opengl.driSupport32Bit = true;
    pulseaudio.enable = true;
  };

  sound.enable = true;

  environment.systemPackages = with pkgs; [ git ];

  programs = {
    adb.enable = true;
    dconf.enable = true;
    fish.enable = true;
  };

  gtk.iconCache.enable = true;

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ libpinyin ];
    };
  };
}
