{ config, pkgs, ... }:

{
  services.picom = {
    enable = true;
    backend = "glx";
    experimentalBackends = true;
    fade = true;
    fadeDelta = 4;
    shadow = true;
    shadowOffsets = [ (-10) (-5) ] ;
    shadowOpacity = "0.50";
    vSync = true;
  };

  
}
