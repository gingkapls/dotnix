{ config, lib, pkgs, ... }:

{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  
  programs.gnome-disks.enable = true;

  services.gvfs.enable = true;
  services.gnome = {
    gnome-initial-setup.enable = false;
    gnome-keyring.enable = true;
    core-apps.enable = true;
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

    inherit (pkgs.gnomeExtensions)
      appindicator
      blur-my-shell
      caffeine
      dash-to-dock
      dash-to-panel
      dynamic-music-pill
      night-theme-switcher
      focus-changer
      paperwm
      just-perfection
      light-style
      steal-my-focus-window
      user-themes;
  };
}
