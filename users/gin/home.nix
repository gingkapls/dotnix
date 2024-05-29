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
    # ./nvim.nix
    # nix-colors.homeManagerModule
    ../../hm
  ];

  colorscheme = nix-colors.colorSchemes.horizon-dark;

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
    blender krita inkscape
    imagemagick imv gcolor3
    playerctl pamixer pavucontrol
    networkmanagerapplet
    ventoy aria2 rclone yt-dlp
    android-udev-rules scrcpy
    inotify-tools rmlint lm_sensors p7zip comma
    glib gsettings-desktop-schemas
    hyperfine
    gammastep
    ulauncher
    localsend
    pciutils usbutils

    # Applications
    google-chrome
    gnome-network-displays
    qbittorrent-qt5 transmission-gtk
    tdesktop obsidian
    zathura foliate calibre
    lutris mangohud
    mpv
    wezterm
    blackbox-terminal
    # yuzu
    write_stylus
    xournalpp
    anki
    android-studio
    bottles
    libreoffice;

    # LaTeX
    # pandoc; inherit (pkgs.texlive.combined) scheme-small;

    inherit (pkgs.wineWowPackages)
    waylandFull;
    
    # Dev stuff
    # oracle-instantclient;
    inherit (pkgs.jetbrains) idea-community;

    # LSPs
    inherit (pkgs)
    rust-analyzer
    clang clang-tools;

    inherit (pkgs.gnome)
    nautilus;
    };
  };

  fonts.fontconfig.enable = true;

  modules = {
    desktop = {
      windowManager.i3.enable = false;
      windowManager.sway.enable = true;
      picom.enable = false;
      dunst.enable = false;
      mako.enable = true;
      waybar.enable = true;
      xidlehook.enable = false;
    };

  	programs = {
      alacritty.enable = true;
      foot.enable = true;
      vscode.enable = true;
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

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userEmail = "73906888+gingkapls@users.noreply.github.com";
    userName = "gin";
  };

  services = {
    easyeffects = {
      enable = false;
      preset = "perfect-eq";
    };
  };

  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = let 
      # imgViewer = "imv.desktop";
      # docViewer = "org.pwmt.zathura.desktop";
      docViewer = "org.gnome.Evince.desktop";
      imgViewer = "org.gnome.Loupe.desktop";
      editor = "org.helix.desktop";
    in {
      enable = true;
      defaultApplications = {
        "image/jpeg"                 = [ imgViewer ];
        "image/png"                  = [ imgViewer ];
        "image/gif"                  = [ imgViewer ];
        "image/svg+xml"              = [ imgViewer ];
        "video/mp4"                  = [ "mpv.desktop" ];
        "video/x-matroska"           = [ "mpv.desktop" ];
        "image/vnd.djvu+multipage  " = [ docViewer ];
        "application/pdf"            = [ docViewer ];
        "application/epub+zip"       = [ "com.github.johnfactotum.Foliate.desktop" ];
        "application/json"           = [ editor ];
        "application/x-yaml"         = [ editor ];
        "text/html"                  = [ "firefox.desktop" ];
        "application/html+xml"       = [ "firefox.desktop" ];
        "inode/directory"            = [ "org.gnome.Nautilus.desktop" ];
      };

      associations = {
        added = {
          "inode/directory"          = [ "org.gnome.Nautilus.desktop" ];
          "image/jpeg"               = [ imgViewer ];
          "image/png"                = [ imgViewer ];
        };
        
        removed = {
          "inode/directory"          = [ "code.desktop" ];
          "image/jpeg"               = [ "wine-extension-jfif.desktop" ];
          "image/png"                = [ "wine-extension-png.desktop" ];
          "application/html+xml"     = [ "calibre-ebook-edit.desktop" ];
        };
      };
    
    };

    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";

    userDirs = {
      enable = true;
      createDirectories = true;
    };

  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
