{ config, lib, pkgs, ... }:

{
  program.gnome-disks.enable = true;

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
      gedit
      epiphany
      geary
      gnome-characters
      totem
      tali
      iagno
      hitori
      atomix;

      inherit (pkgs) gnome-tour;
}

  


}
