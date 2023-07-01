{ config, pkgs, ... }: 

{
  imports = [
    ./gtk.nix
    ./gnome.nix
    ./i3.nix
    ./i3status.nix
    ./picom.nix
    ./sway.nix
    ./swaylock.nix
    ./xorg.nix
  ];
}
