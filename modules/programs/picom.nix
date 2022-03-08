{ config, pkgs, lib, ...}:

with lib;
let
  cfg = config.modules.programs.picom;
in {
  options.modules.programs.picom = {
    enable = mkEnableOption "Enable Picom compositor";
  };

  config = mkIf cfg.enable {
    services.picom = {
      enable = true;
      backend = "glx";
      experimentalBackends = true;
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
