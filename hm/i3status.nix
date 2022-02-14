{ config, pkgs, lib, ... }:

{
  programs.i3status = {
    enable = true; 
    enableDefault = false;
    modules = {
      "wireless wlan0" = {
        enable = true;
        position = 0;
        settings = {
          format_up = "%essid";
          format_down = "down";
        };

      };
      
      "battery 0" = {
        enable = true;
        position = 1;
        settings = {
          format = "%status %percentage";
          integer_battery_capacity = true;
          format_down = "No battery";
          status_chr = "⚡";
          status_bat = "🔋 BAT";
          status_unk = "? UNK";
          status_full = "☻ ";
          path = "/sys/class/power_supply/BAT1/uevent";
          low_threshold = 30;
        };
      };
      
      "tztime local" = {
        position = 2;
        enable = true;
        settings = {
          format = "%H:%M ";
        };
      };
      
      
      "load" = {
        enable = false;
        settings = {
          format = "%5min";
        };
      };
      
      "disk /" = {
        enable = false;
        settings = {
          format = "%free";
        };
      };
      
      "read_file uptime" = {
        enable = false;
        settings = {
          path = "/proc/uptime";
       };   
      };
    };


  };

}
