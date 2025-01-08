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

  environment.variables = {
    GTK_USE_PORTAL = 1;
  };

  environment.gnome.excludePackages = lib.attrValues {
  inherit (pkgs)
      gnome-music
      gnome-terminal
      epiphany
      geary
      gnome-characters
      tali
      iagno
      hitori
      atomix
      gnome-tour
      gedit;
  };

  environment.systemPackages = lib.attrValues {
    inherit (pkgs)
      gnome-tweaks;
  };
}
