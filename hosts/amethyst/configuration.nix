# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "btrfs" "ntfs" ];

    cleanTmpDir = true;
  };


  nixpkgs.config = {
    allowUnfree = true;

    packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    };

  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
    experimental-features = nix-command flakes 
  '';

    allowedUsers = [ "gin" ];
    autoOptimiseStore = true;
    checkConfig = true;

    gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    optimise.automatic = true;
  };

  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
 
  networking = {
    hostName = "amethyst"; # Define your hostname.
    useDHCP = false;
    dhcpcd.enable = false;

    interfaces = { 
      enp6s0f1.useDHCP = true;
      wlan0.useDHCP = true;
    };

    networkmanager = {
      enable = true;
#      dns = "none";
      wifi.backend = "iwd";
    };
    
    wireless.iwd = {
      enable = true;
      settings.Settings.Autoconnect = true;
    };

    firewall = {
      enable = true;
    };

  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };
 
  fileSystems."/home" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };
 
  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
 
  fileSystems."/mnt/data/files" =
    { device = "/dev/disk/by-label/data";
      fsType = "btrfs";
      options = [ "subvol=files" ];
    };
 
  fileSystems."/mnt/data/games" =
    { device = "/dev/disk/by-label/data";
      fsType = "btrfs";
      options = [ "subvol=games" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/13caff81-4afe-4038-9fb8-e3fa40fc3198"; }
    ];

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  # networking.useDHCP = false;
  # networking.interfaces.enp1s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbOptions = "caps:swapescape";
    # Enable touchpad support (enabled default in most desktopManager).
    libinput = {
      enable = true;

      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
      };

    };

      videoDrivers = [ "nvidia" ];


      displayManager = {
        lightdm.enable = true;
        defaultSession = "none+i3";
      };
      
      windowManager = {
        fvwm = {
         enable = false; 
        };

        i3 = {
          enable = true; 
          package = pkgs.i3-gaps;
          extraPackages = with pkgs; [
            i3status
            dmenu
            i3lock-color
            autotiling
            python39Packages.i3ipc
          ];
        };
      
      };
     
    };
 
    undervolt = {
      enable = true;
      coreOffset = -150;
      gpuOffset = -95;
    };

    logind.lidSwitch = "suspend";

  };

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true;

#    lowLatency = {
#      enable = true;
#      quantum = 32;
#      rate = 48000;
#    };

#    wireplumber.enable = true;
    media-session.enable = true;

  };

  security.rtkit.enable = true;

  hardware = {
    enableAllFirmware = true;
    pulseaudio.enable = false;

    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
      driSupport32Bit = true;
    };

    nvidia.prime = {
      offload.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };

  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ]; # Enable ‘sudo’ for the user.
    initialPassword = "123456";
    shell = pkgs.zsh;
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = { 
    systemPackages = with pkgs; [
      wget # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      nano
      kitty
      networkmanager
      xclip
      dash
      nvidia-offload
      mesa
      vulkan-loader
      vulkan-tools
      wineWowPackages.staging
      lutris
      winetricks
      brightnessctl
      python3
      #  wineWowPackages.stable
    ];

    binsh = "${pkgs.dash}/bin/dash";

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      FVWM_USERDIR = "$HOME/.config/fvwm";    
    };

  };

  fonts = {
    fonts = with pkgs; [ 
      inter
      iosevka
      fira-code
      scientifica
      twemoji-color-font
      paratype-pt-serif
      material-icons
      font-awesome
    ];

    fontconfig = {
      enable = true;

      defaultFonts = {
        serif = [ "Paratype Pt Serif" ];
        sansSerif = [ "Inter" ];
        monospace = [ "Iosevka Slab" ];

        emoji = [ "Twitter Color Emoji" ];
      };
    };


  };

  programs.zsh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

