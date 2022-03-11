{ config, ... }:

{
  imports = [
    ./alacritty.nix
    ./easyeffects.nix
    ./firefox.nix
    ./foot.nix
    ./mpv.nix
    ./nvim.nix
    ./swappy.nix
    ./zathura.nix
  ];
}
