{ config, ...}:

{
  imports = [
    ./desktop/windowManagers/i3.nix
    ./desktop/windowManagers/sway.nix
    ./desktop/xorg.nix
    ./programs/alacritty.nix
    ./programs/dunst.nix
    ./programs/easyeffects.nix
    ./programs/firefox.nix
    ./programs/foot.nix
    ./programs/gtk.nix
    ./programs/i3status.nix
    ./programs/mako.nix
    ./programs/mpv.nix
    ./programs/nvim.nix
    ./programs/picom.nix
    ./programs/shell-scripts.nix
    ./programs/waybar.nix
    ./programs/zathura.nix
    ./programs/zsh.nix
  ];
}
