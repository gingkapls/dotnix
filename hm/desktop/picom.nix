{ config, pkgs, lib, ...}:

with lib;
let
  cfg = config.modules.desktop.picom;
in {
  options.modules.desktop.picom = {
    enable = mkEnableOption "Enable Picom compositor";
  };

  config = mkIf cfg.enable {
    services.picom = {
      enable = false;
      backend = "glx";
      fade = true;
      fadeDelta = 4;
      shadow = true;
      shadowOffsets = [ (-10) (-5) ] ;
      shadowExclude = [
        "class_g = 'i3-frame'"
      ];
      shadowOpacity = "0.35";
      vSync = true;
    };
  
    
  };

}
