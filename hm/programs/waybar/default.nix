{ config, pkgs, lib, nix-colors, ... }:

with config.colorscheme.colors;
with lib;

let 
  cfg = config.modules.desktop.waybar;
#  mono-font = "${builtins.toString osConfig.fonts.fontconfig.defaultFonts.monospace}";
in {
  options.modules.desktop.waybar = {
    enable = mkEnableOption "Enable waybar";
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      systemd = {
        enable = false;
        # target = "sway-session.target";
      };

      settings = [ {
          layer = "top";
          position = "top";
          width = 1920;
          height = 40;
          margin-top = 0;
          margin-left = 0;
          margin-right = 0;
          margin-bottom = 0;
          modules-left = [ "sway/workspaces" "custom/playerctl" "sway/mode" ];
          # modules-center = [  ];
          modules-right = [ "custom/recorder" "idle_inhibitor" "battery" "custom/wifi" "clock" ];

          modules = {
            "sway/workspaces" = {
              # format =  "";
              format =  "";
              format-icons = {
                "1" = "";
                "2" = "";
                "3" = "";
                "4" = "";
                "5" = "";
                "6" = "";
                "7" = " ";
                "8" = " ";
                "9" = " ";
                "10" = " ";
              };

              persistent_workspaces = {
                "1" = [];
                "2" = [];
                "3" = [];
                "4" = [];
                "5" = [];
              };
            };

            "wlr/taskbar" = {
                format = "{icon}";
                icon-size = 32;
                on-click = "minimize-raise";
                ignore-list = [
                    "Alacritty"
                ];
            };
  
            "sway/mode" = {
            	format = "{}";
            };
  
            "custom/playerctl" = {
             	format = "{icon} {}";
             	return-type = "json";
             	on-click = "${pkgs.playerctl}/bin/playerctl -sp playerctld play-pause";
             	on-click-middle = "${pkgs.playerctl}/bin/playerctl -sp playerctld previous";
             	on-click-right = "${pkgs.playerctl}/bin/playerctl -sp playerctld next";
                exec = "music-notifier";
             	max-length = 30;
             	format-icons = {
                Playing = "";
                Paused = "";
             	};
            };         

            "custom/recorder" = {
            	format = "{}";
            	interval = "once";
            	exec = "printf ''";
            	tooltip = false;
            	exec-if = "pgrep 'wf-recorder'";
            	on-click = "wlrecord";
            	signal = 8;
            	};


            "custom/wifi" = {
              format = "";
              max-length = 30;
              on-click = "foot -e sh -c 'sleep .1 && nmtui'";
            };

            # "custom/switch-theme" = {
            # 	format = "{}";
            #     interval = "once";
            #     exec = "switch-theme true";
            # 	on-click = "switch-theme";
            #     signal = 14;
            # 	};

            idle_inhibitor = {
              format = "{icon}";
              format-icons = {
                activated = "";
                deactivated = "";
              };
            };
  
            tray = {
              # This does nothing
              spacing = 12;
            };
  
           clock = {
              format = "{:%a, %d %R}";
              format-alt = " {: %b %Y-%m-%d}";
              tooltip-format = "<big>{: %Y %B}</big>\n<tt><big>{calendar}</big></tt>";
              today-format = "<b><i><u>{}</u></i></b>";
            };
  
            battery = {
              states = {
                warning = 30;
                critical = 20;
              };
            format = "{icon}";
            format-charging = " {capacity}%";
            format-plugged = "";
            tooltip = true;
            tooltip-format = "{timeTo} ({capacity}%)";
            # "format-good" = "";
            # "format-full" = "";
            format-icons = ["" "" "" "" ""];
            };
        };
      } ];

      # Follows GTK Theme
      style = ''
        * {
          font-family: "Inter", "Font Awesome 6 Free Solid"; 
          font-size: 17px;
          min-height: 0;
          font-weight: 700;
          padding: 0px 2px;
          /* margin: 1.8px 8px 1.8px 8px; */
        }
                                                                           
        window#waybar {
          background-color: transparent;
          border-radius: 0px;
          transition-property: background-color;
          transition-duration: .5s;
          padding: 0px 0px;
        }

                                                                         
        window#waybar.hidden {
            opacity: 5;
        }
                                                                         
        window#waybar.empty {
          background-color: #${base00};
        }
                                                                         
        window#waybar.solo {
          background-color: #${base00};
        }
        
        tooltip, tooltip label {
          background-color: #${base00};
          color: #${base05};
          font-size: 17px;
          font-weight: 700;
        }

                                                                                   
        #clock,
        #battery,
        #pulseaudio,
        #custom-weather,
        #custom-playerctl,
        #mode,
        #idle_inhibitor,
        #tray,
        #custom-recorder,
        #custom-wifi,
        #custom-switch-theme {
            /* all: initial; */
            min-width: 0; 
            color: #${base05};
            background: #${base00};
            border-top: 2px;
            border-bottom: 2px;
            border-radius: 2px;
            border-style: inset;
            border-color: #${base03};
            padding: 1px 10px;
            margin: 5px 0px;
        }

        #custom-playerctl {
          color: #${base00};
          background: #${base0E};
          border: 2px;
          border-radius: 2px;
          border-style: inset;
          margin-left: 15px;
          padding: 1px 15px;
        }

        #clock {
          background: #${base00};
          border-right: 2px;
          border-left: 2px;
          border-color: #${base03};
          margin-right: 10px;
          padding: 1px 8px;
        }

        #idle_inhibitor {
          border-left: 2px;
          border-style: inset;
          border-color: #${base03};
        }


        #idle_inhibitor.activated {
            color: #${base0B};
        }


        #workspaces button {
          all: initial; /* Remove GTK theme values (waybar #1351) */
          background-color: #${base03};
          color: #${base03};
          border: 2px;
          border-style: inset;
          border-color: #${base01};
          padding: 0px 0px;
          margin: 10px 5px;
          min-width: 0; /* Fix weird spacing in materia (waybar #450) */
        }


        #workspaces button.persistent {
          color: #${base01};
          background-color: #${base01};
        }
        
         #workspaces button.focused {
          color: #${base09};
          background-color: #${base09};
        }
                                                                           
        #workspaces button.urgent {
          background-color: #${base08};
          color: #${base08};
        }
        
        #workspaces button:hover {
            color: #${base0D};
            background-color: #${base0D};
        }

        
        #tray {
          margin: 0px 0px;
        }
        
        
        @keyframes blink {
            to {
                background-color: #${base00};
                color: #${base05};
            }
        }
        
        #battery.critical:not(.charging) {
          color: #${base08};
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }
                                                                           
        #pulseaudio.muted {
            color: #${base03};
        }
                                                                           
        '';
    };
  };
}
