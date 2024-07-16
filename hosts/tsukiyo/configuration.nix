{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix
    ./fonts.nix
    ./gnome.nix
    ./hardware-configuration.nix
    ./hyprland.nix
    ./sway.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-25.9.0" # For Obsidian
      ];
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;


    gc = { 
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  networking = {
    hostName = "tsukiyo";
    # useDHCP = true;
    interfaces = {
      enp6s0f1.useDHCP = true;
      wlan0.useDHCP = true;
    };

    wireless.iwd.enable = true;

    networkmanager = {
      enable = true;
      wifi = {
        powersave = false;
        backend = "iwd";
        scanRandMacAddress = false;
      };
    };

    firewall.enable = false;
  };

  boot = {
    loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };

    # Random kernel panics
    # crashDump.enable = true;

    kernelPackages = pkgs.linuxPackages_latest;

    supportedFilesystems = [ "btrfs" "ntfs" ];
    kernelParams = [
      # "quiet"
      # "loglevel=3"
      # "systemd.show_status=0"
    ];

    tmp = {
      useTmpfs = false;
      cleanOnBoot = true;
    };
  };

  # linux-firmware
  hardware.enableAllFirmware= true;

  # Packages
  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
    wget
    # home-manager
    nano
    neovim
    firefox
    git
    vulkan-loader vulkan-tools;
  };

  programs = {
    adb.enable = true;
    dconf.enable = true;
    steam.enable = true;
    xwayland.enable = true;
    zsh = {
      enable = true;
      enableCompletion = false;
    };
    fish.enable = true;
  };

  # Users
  users.users = {
    gin = {
      initialPassword = "123456";
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "networkmanager" "video" "adbusers" "docker"];
    };
  };

  # X Configuration
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      options = "compose:ralt";
    };
    # xkbOptions = "caps:swapescape, compose:ralt";
    windowManager.i3.enable = true;

  };

    services.libinput = {
      enable = true;
      mouse.middleEmulation = false;

      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
      };
    };


  # Plasma
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5 = {
    # enable = true;
    # useQtScaling = false;
  # };
  # programs.ssh.askPassword = lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";
  
  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    pulse.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Graphics
  hardware.opengl = {
    enable = true;
    extraPackages = lib.attrValues {
      inherit (pkgs)
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl;
    };
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };

    powerManagement = {
      enable = false;
      finegrained = false;
    };
  };

  # Drawing tablet
  hardware.opentabletdriver.enable = true;

  # Power Key
  services.logind = {
    lidSwitch = "suspend";
    extraConfig = "HandlePowerKey=ignore";
  };

  # Power Management
  services.power-profiles-daemon.enable = false;

  # System Services
  zramSwap.enable = true;
  services = {
    dbus.enable = true;
  };

  # Power Management
  services.auto-cpufreq.enable = true;
  services.undervolt = {
    enable = true;
    coreOffset = -150;
    gpuOffset = -95;
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  services.openssh = {
    enable = false;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  time.timeZone = "Asia/Kolkata";

  system.stateVersion = "23.05";
}
