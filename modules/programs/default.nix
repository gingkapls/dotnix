{ config, ... }:

{
  imports = [
    ./nvim
    ./alacritty.nix
    ./easyeffects.nix
    ./firefox.nix
    ./foot.nix
    ./mpv.nix
    ./mkreadme.nix
    ./swappy.nix
    ./vscode.nix
    ./zathura.nix
  ];
}
