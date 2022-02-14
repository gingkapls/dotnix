{ config, pkgs, nix-colors, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  colorscheme = nix-colors.colorSchemes.eighties;

  home = {
    username = "gin";
    homeDirectory = "/home/gin";


    # sessionVariables = {
    #   FVWM_USERDIR = "$HOME/.config/fvwm";
    # };

    packages = with pkgs; [ 
    alacritty
    google-chrome
    firefox 
    gnome.nautilus
    tree
    blender
    gimp
    imv
    krita
    zathura
    mpv
    gh
    git
    git-crypt
    mangohud
    gnupg
    iosevka
    python39Packages.i3ipc
    playerctl
    dunst
    jq
    picom
    networkmanagerapplet
  ];

    # Configs

    #  home.file = {
    #     ".config/awesome".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotnix/config/awesome";
    #  };


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

  imports = [
    ./shell.nix 
    ./nvim.nix
    ./mpv.nix
    ./i3.nix
    ./alacritty.nix
    nix-colors.homeManagerModule
  ];

}
