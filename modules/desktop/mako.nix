{ config, pkgs, lib, nix-colors, ... }:

with config.colorscheme.colors;
with lib;

let cfg = config.modules.desktop.mako;
in {
  options.modules.desktop.mako = {
    enable = mkEnableOption "Enable mako the lightweight notification daemon for Wayland";
  };

  config = mkIf cfg.enable {
    programs.mako = {
      enable = true;

      anchor = "top-right";
      backgroundColor = "#${base00}";
      borderColor = "#${base00}";
      progressColor = "#${base03}";
      textColor = "#${base05}";

      height = 150;
      width = 300;
      borderRadius = 4;
      borderSize = 4;
      defaultTimeout = 5000;

      font = "Inter Medium 14";
      format = "<b>%s</b>\\n%b";
      icons = true;
      maxIconSize = 96;
      layer = "top";
      margin = "12";
      maxVisible = 5;
      padding = "10";
      groupBy = "app-name";

      extraConfig = ''
        [grouped]
        format=<b>%s (%g)</b>\n%b
        
        [app-name="music-notifier"]
        format=<b>%s</b>\n%b
        
        [app-name="progress"]
        format=<b>%s</b>\n%b
        padding=0, 2, 1
        
        [app-name="colorpicker"]
        max-icon-size=256
        width=256
        padding=16
        
        [app-name="brightness"]
        format=<b>%s</b>\n%b
        history=0
        padding=4, 4, 4
        
        [app-name="volume"]
        format=<b>%s</b>\n%b
        history=0
        padding=4, 4, 4
      '';
    };
  };

}
