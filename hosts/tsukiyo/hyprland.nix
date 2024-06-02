{ config, pkgs, lib, nix-colors, ... }:

{
  config.programs.hyprland = {
    enable = false;
    xwayland.enable = true;
  };

}
