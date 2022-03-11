{ config, pkgs, nix-colors, ... }:

with config.colorscheme.colors; 
{
    programs.i3status = {
      enable = true; 
      enableDefault = false;
  
      general = {
        colors = true;
        color_good = "#${base09}";
        color_degraded = "#${base08}";
        color_bad = "#${base0A}";
        separator = " ";
        interval = 1;
      };
  
      modules = {
        "wireless wlan0" = {
          enable = false;
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
            format = "%status %percentage   ";
            integer_battery_capacity = true;
            format_down = "";
            status_chr = "";
            status_bat = "";
            status_unk = "";
            status_full = "";
            path = "/sys/class/power_supply/BAT1/uevent";
            low_threshold = 30;
          };
        };
        
        "tztime local" = {
          position = 2;
          enable = true;
          settings = {
            format = "%a %m/%d       %H:%M  ";
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
