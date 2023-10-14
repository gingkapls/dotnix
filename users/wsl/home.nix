# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, nix-colors, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    ../../hm/programs/helix
    ../../hm/programs/nvim
    ../../hm/shells
  ];

  colorScheme = nix-colors.colorSchemes.horizon-dark;

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    package = pkgs.nix;

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };

  };

  nixpkgs = {
    # You can add overlays here
    # overlays = [
    #   # Add overlays your own flake exports (from overlays and pkgs dir):
    #   outputs.overlays.additions
    #   outputs.overlays.modifications
    #   outputs.overlays.unstable-packages

    #   # You can also add overlays exported from other flakes:
    #   # neovim-nightly-overlay.overlays.default

    #   # Or define it inline, for example:
    #   # (final: prev: {
    #   #   hi = final.hello.overrideAttrs (oldAttrs: {
    #   #     patches = [ ./change-hello-to-hi.patch ];
    #   #   });
    #   # })
    # ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  # TODO: Set your username
  home = {
    username = "gin";
    homeDirectory = "/home/gin";

    packages = lib.attrValues {
    inherit (pkgs)

    # Utilities
    coreutils tree jq rename gh
    ventoy aria2 rclone yt-dlp
    inotify-tools rmlint lm_sensors p7zip comma
    pandoc;

    # LSPs
    inherit (pkgs)
    rust-analyzer
    clang clang-tools;
    };
  };


  modules = {
  	programs = {
  	  helix.enable = true;
    };

  	shells = {
      zsh.enable = true;
      fish.enable = true;
    };
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  programs = {
    home-manager.enable = true;
    ssh = {
      enable = true;
      package = pkgs.openssh;
    };

    git = {
      enable = true;
      userEmail = "73906888+gingkapls@users.noreply.github.com";
      userName = "gin";
      extraConfig = {
        init.defaultBranch = "master";
      };
    };
  };

  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = let
      # imgViewer = "imv.desktop";
      # docViewer = "org.pwmt.zathura.desktop";
      # docViewer = "org.gnome.Evince.desktop";
        imgViewer = "org.gnome.eog.desktop";
        docViewer = "org.pwmt.zathura.desktop";
        editor = "org.helix.desktop";

      in {
        "image/jpeg"               = [ imgViewer ];
        "image/png"                = [ imgViewer ];
        "image/gif"                = [ imgViewer ];
        "image/svg+xml"            = [ imgViewer ];
        # "video/mp4"                = [ "mpv.desktop" ];
        # "video/x-matroska"         = [ "mpv.desktop" ];
        "image/vnd.djvu+multipage" = [ docViewer ];
        "application/pdf"          = [ docViewer ];
        "application/epub+zip"     = [ docViewer ];
        "application/json"         = [ editor ];
        "application/x-yaml"       = [ editor ];
        # "text/html"                = [ "firefox.desktop" ];
        # "inode/directory"          = [ "org.gnome.Nautilus.desktop" ];
      };

      # associations = {
      #   added = {
      #   "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
      #   };
        
      #   removed = {
      #     "inode/directory" = [ "code.desktop" ];
      #   };
      # };
    
    };

    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";

    userDirs = {
      enable = true;
      createDirectories = false;
    };

  };

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
