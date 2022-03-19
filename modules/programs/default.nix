{ config, ... }:

{
  imports = [
    ./nvim
    ./alacritty.nix
    ./easyeffects.nix
    ./firefox.nix
    ./foot.nix
    ./mpv.nix
    ./readme.nix
    ./swappy.nix
    ./vscode.nix
    ./zathura.nix
  ];
}
