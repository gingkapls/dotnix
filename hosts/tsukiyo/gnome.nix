{ config, lib, pkgs, ... }:

{
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  programs.gnome-disks.enable = true;

  services.gvfs.enable = true;
  services.gnome = {
    gnome-initial-setup.enable = false;
    gnome-keyring.enable = true;
    core-utilities.enable = true;
    games.enable = false;
    sushi.enable = true;
  };

  environment.gnome.excludePackages = lib.attrValues {
  inherit (pkgs.gnome)
      gnome-music
      gnome-terminal
      epiphany
      geary
      gnome-characters
      tali
      iagno
      hitori
      atomix;

      inherit (pkgs)
      gnome-tour
      gedit;
  };

}
