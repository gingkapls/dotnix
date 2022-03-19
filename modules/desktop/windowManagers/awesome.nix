{ config, pkgs, lib, ... }:

with lib;

let 
  cfg = config.modules.desktop.windowManager.awesome;
in {
  options.modules.desktop.windowManager.awesome = {
    enable = mkEnableOption "Enable the Awesome Window Manager";
  };

  config = mkIf cfg.enable {
    xsession.windowManager.awesome = {
      enable = true;
      noArgb = true;
    };
  };

}
