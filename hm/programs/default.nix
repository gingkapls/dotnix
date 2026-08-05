{ config, pkgs, ...}:
let 
  more = { pkgs, ...}: {
    # programs = {
    # };
  };
in   
{
  imports = [
    ./easyeffects
    ./firefox
    ./mako
    ./vscode
  ];
}
