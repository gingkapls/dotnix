{ config, pkgs, lib, nix-colors, ... }:

with config.colorscheme.colors;
with lib;

let 
  cfg = config.modules.programs.waybar;
in {
  options.modules.programs.waybar = {
    enable = mkEnableOption "Enable waybar";
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
        # target = "sway-session.target";
      };

      settings = [ {
          layer = "bottom";
          position = "top";
          width = 1200;
          margin-top = 5;
          margin-left = 0;
          margin-right = 0;
          margin-bottom = 0;
          modules-left = [ "sway/workspaces" "custom/playerctl" "sway/mode" ];
          modules-right = [ "custom/recorder" "idle_inhibitor"  "battery" "tray" "clock" ];

          modules = {
            "sway/workspaces" = {
              "format" =  "{name}";
            };
  
            "sway/mode" = {
            		format = "{}";
            };
  
            "custom/playerctl" = {
             	format = "{icon} {}";
             	return-type = "json";
             	on-click = "${pkgs.playerctl}/bin/playerctl -sp playerctld play-pause";
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
            	exec = "printf '\n'";
            	tooltip = false;
            	exec-if = "pgrep 'wf-recorder'";
            	on-click = "wlrecord";
            	signal = 8;
            	};

            idle_inhibitor = {
              format = "{icon}";
              format-icons = {
                activated = "";
                deactivated = "";
              };
            };
  
            tray = {
              spacing = 10;
            };
  
           clock = {
          	  format = "{: %a, %d  %R}";
              format-alt = " {: %b %Y-%m-%d}";
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

      style = ''
        * {
            border-radius: 10px;
            /* `otf-font-awesome` is required to be installed for icons */
            font-family: "Inter" , "Font Awesome 5 Free Solid";
            font-size: 16px;
            min-height: 0;
    	      font-weight: 700;
    	      padding: 2px 2px;
    	      /* margin: 1.8px 8px 1.8px 8px; */
          }
 
          window#waybar {
            border-radius: 0px;
            background-color: transparent;
            transition-property: background-color;
            transition-duration: .5s;
    	      padding: 0px 0px;
            /*
            border-bottom: 4px solid transparent;
            border-top: 4px solid transparent;
            */
          }
  
          window#waybar.hidden {
              opacity: 5;
          }
  
          window#waybar.empty {
            background-color: transparent;
          }

          window#waybar.solo {
            background-color: #FFFFFF;
          }
      
        label:focus {
          color: #${base02};
        }
  
        #workspaces button {
          padding: 4px 2px;
  	      margin: 2px 8px;
          border-color: #${base01};
          color: #${base05};
          background: #${base02};
        }
  
        #workspaces button.focused {
        	border-color: #${base02};
        	color: #${base02};
          background-color: #${base05};
        }
  
        #workspaces button.urgent {
          background-color: #${base09};
        }

        #workspaces button:hover {
        background: #${base03};
        border-color: #${base02};
  	    color: #${base05};
        }

  
        #clock,
        #battery,
        #pulseaudio,
        #custom-weather,
        #custom-theme-toggle,
        #custom-playerctl,
        #mode,
        #idle_inhibitor,
        #tray,
        #custom-recorder {
        	color: #${base05};
          background: #${base02};
          padding: 4px 12px;
          margin: 2px 8px;
        }
  
        @keyframes blink {
            to {
                background-color: #${base02};
                color: #${base07};
            }
        }
  
        #battery.critical:not(.charging) {
          color: #${base09};
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }
  
        #pulseaudio.muted {
            color: #${base03};
        }
  
        #idle_inhibitor.activated {
            color: #${base0D};
        }
      '';
      
    };
  };
}
