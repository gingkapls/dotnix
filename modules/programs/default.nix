{ config, ... }:

{
  imports = [
    ./alacritty.nix
    ./easyeffects.nix
    ./firefox.nix
    ./foot.nix
    ./mpv.nix
    ./nvim.nix
    ./readme.nix
    ./swappy.nix
    ./vscode.nix
    ./zathura.nix
  ];
}
