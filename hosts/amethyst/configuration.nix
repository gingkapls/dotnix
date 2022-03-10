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
    exec "$@"
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
    kernelParams = [
      "quiet"
      "loglevel=3"
      "systemd.show_status=0"
    ];

    tmpOnTmpfs = true;
    cleanTmpDir = true;
  };


  nixpkgs.config = {
    allowUnfree = true;

    permittedInsecurePackages = with pkgs; [ "electron-13.6.9" ]; ## cant download fix yet ;-;

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
      enable = false;
    };

  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

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
      xkbOptions = "caps:swapescape, compose:ralt";
    # Enable touchpad support (enabled default in most desktopManager).
      libinput = {
      enable = true;

      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
      };

      mouse = {
        middleEmulation = false;
      };

    };

      videoDrivers = [ "nvidia" ];

      windowManager = {
        fvwm = {
         enable = false; 
        };

        i3 = {
          enable = true; 
        };
      };
     
    };

    greetd = {
      enable = true;

      settings = {
        default_session.command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'sway --my-next-gpu-wont-be-nvidia'";

        initial_session = {
          command = "sway";
          user = "gin";
        };
      };
    };
 
    undervolt = {
      enable = true;
      coreOffset = -150;
      gpuOffset = -95;
    };

    logind.lidSwitch = "suspend";
    gvfs.enable = true;
    auto-cpufreq.enable = true;

  };

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Sound
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

#    wireplumber.enable = false;
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
      brightnessctl
      xclip
      dash
      nvidia-offload mesa vulkan-loader vulkan-tools
      wineWowPackages.staging lutris winetricks
      python3
      easyeffects
      ffmpeg nv-codec-headers
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

  programs = {
    zsh.enable = true;
    dconf.enable = true;
    gnome-disks.enable = true;
    sway.enable = true;
  };

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

