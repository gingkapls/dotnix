{ config, ... }:

{
  imports = [
    ./dunst.nix
    ./gtk.nix
    ./i3status.nix
    ./mako.nix
    ./picom.nix
    ./swaylock.nix
    ./waybar.nix
    ./windowManagers
    ./xorg.nix
  ];

}
