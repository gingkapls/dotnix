{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "gin";
  home.homeDirectory = "/home/gin";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true; 

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./shell.nix 
    ./nvim.nix
  ];


  # Configs

  home.file = {
     ".config/awesome".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotnix/config/awesome";
  };

  home.packages = with pkgs; [ 
    alacritty
    google-chrome
    firefox 
    tree
    wine
    lutris
    blender
    gimp
    imv
    krita
    zathura
    mpv
    gh
    git
    git-crypt
    gnupg
    lolcat
  ];
}
