{ config, pkgs, ...}:
let 
  more = { pkgs, ...}: {
    # programs = {
    # };
  };
in   
{
  imports = [
    ./alacritty
    ./easyeffects
    ./dunst
    ./firefox
    ./foot
    ./helix
    ./mako
    ./mkreadme
    ./mpv
    # ./nvim
    ./obsidian
    ./swappy
    ./vscode
    ./wezterm
    ./waybar
    ./zathura
    # more
  ];
}
