{ config, pkgs, lib, ... }: 

with lib;
let
  cfg = config.modules.desktop.xidlehook;
in {

  options.modules.desktop.xidlehook = {
    enable = mkEnableOption "Enable xidlehook daemon";
  };

  config = mkIf cfg.enable {
    services.xidlehook = {
      enable = true;
      not-when-audio = true;
      not-when-fullscreen = true;
      environment = {
        "primary-display" = "$(${pkgs.xorg.xrandr}/bin/xrandr | awk '/ primary/{print $1}')";
      };

      timers = [
        {
          delay = 60;
          command = "${pkgs.brightnessctl}/bin/brightnessctl --quiet set 10%-";
          canceller = "${pkgs.brightnessctl}/bin/brightnessctl --quiet set 10%+";
        }

        {
          delay = 300;
          command = "${pkgs.xorg.xrandr}/bin/xrandr --output \"$PRIMARY_DISPLAY\" --brightness .1";
          canceller = "${pkgs.xorg.xrandr}/bin/xrandr --output \"$PRIMARY_DISPLAY\" --brightness 1";
        }

        {
          delay = 600;
          command = "${pkgs.xorg.xrandr}/bin/xrandr --output \"$PRIMARY_DISPLAY\" --brightness 1; ${pkgs.i3lock-color}/bin/i3lock-color; sleep 1; ${pkgs.systemd}/bin/systemctl suspend";
          canceller = "";
        }
      ];

    };

  };

}
