{ config, pkgs, nix-colors, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  colorscheme = nix-colors.colorSchemes.material;

  home = {
    username = "gin";
    homeDirectory = "/home/gin";

    packages = with pkgs; [ 
    google-chrome firefox 
    gnome.nautilus
    coreutils tree jq
    blender
    gimp krita inkscape imagemagick
    zathura
    mpv imv nitrogen
    gh git git-crypt gnupg
    playerctl pamixer pavucontrol
    picom
    networkmanagerapplet
    slop maim xdotool tesseract
    dunst libnotify
    qbittorrent
    mangohud
    dconf
    spotdl
    ventoy-bin
    aria2
    android-tools
    tdesktop
  ];

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
  
    stateVersion = "21.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true; 

  nixpkgs.config.allowUnfree = true;

  modules = {

    desktop = {
      windowManager.i3.enable = true;
      windowManager.sway.enable = true;
    };

    programs = {
      picom.enable = true;
      dunst.enable = false;
      mako.enable = true;
      foot.enable = true;
      waybar.enable = true;
    };
  
  };

  services = {
    easyeffects = {
      enable = true;
      preset = "perfect-eq";
    };

  };

  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps.enable = true;

    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";

    configHome = "${config.home.homeDirectory}/.config";
#    configFile."easyeffects/output/perfect-eq.json".text = import ./easyeffects.nix;

    userDirs = {
      enable = true;
      createDirectories = true;
    };

  };

  imports = [
    ../../modules/module-list.nix 
    nix-colors.homeManagerModule
  ];
}
