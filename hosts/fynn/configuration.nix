{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "24.11";

  nixpkgs.config.allowUnfree = true;

  nix.settings.auto-optimise-store = true;

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        useOSProber = true;
      };
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
    udev = {
      extraRules = ''
        SUBSYSTEM=="usb", ATTRS{idVendor}=="0d28", ATTRS{idProduct}=="0204", MODE="0666"
      '';
      packages = with pkgs; [
        android-udev-rules
        libwacom
        (writeTextFile {
          name = "52-xilinx-digilent-usb.rules";
          text = ''
            ATTR{idVendor}=="1443", MODE:="666"
            ACTION=="add", ATTR{idVendor}=="0403", ATTR{manufacturer}=="Digilent", MODE:="666"
          '';

          destination = "/etc/udev/rules.d/52-xilinx-digilent-usb.rules";
        })
        (writeTextFile {
          name = "52-xilinx-ftdi-usb.rules";
          text = ''
            ACTION=="add", ATTR{idVendor}=="0403", ATTR{manufacturer}=="Xilinx", MODE:="666"
          '';

          destination = "/etc/udev/rules.d/52-xilinx-ftdi-usb.rules";
        })
        (writeTextFile {
          name = "52-xilinx-pcusb.rules";
          text = ''
            ATTR{idVendor}=="03fd", ATTR{idProduct}=="0008", MODE="666"
            ATTR{idVendor}=="03fd", ATTR{idProduct}=="0007", MODE="666"
            ATTR{idVendor}=="03fd", ATTR{idProduct}=="0009", MODE="666"
            ATTR{idVendor}=="03fd", ATTR{idProduct}=="000d", MODE="666"
            ATTR{idVendor}=="03fd", ATTR{idProduct}=="000f", MODE="666"
            ATTR{idVendor}=="03fd", ATTR{idProduct}=="0013", MODE="666"
            ATTR{idVendor}=="03fd", ATTR{idProduct}=="0015", MODE="666"
          '';

          destination = "/etc/udev/rules.d/52-xilinx-pcusb.rules";
        })
      ];
    };
    udisks2.enable = true;
    upower.enable = true;
    xserver = {
      displayManager.startx.enable = true;
      enable = true;
    };
  };

  security = {
    pam.services.hyprlock = { };
    polkit.enable = true;
    rtkit.enable = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics.enable32Bit = true;
    opentabletdriver.enable = true;
  };

  environment.systemPackages = with pkgs; [ git ];

  programs = {
    adb.enable = true;
    dconf.enable = true;
    fish.enable = true;
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
