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
          margin-top = 10;
          margin-left = 360;
          margin-right = 360;
          margin-bottom = 5;
          modules-left = [ "sway/workspaces" "custom/playerctl" "sway/mode" ];
          modules-right = [ "idle_inhibitor"  "battery" "tray" "clock" ];

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
             	max-length = 30;
             	format-icons = {
                Playing = "";
                Paused = "";
             	};
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
    	      padding: 2px 10px;
    	      /* margin: 1.8px 8px 1.8px 8px; */
          }
 
          window#waybar {
            border-radius: 0px;
            background-color: #${base00};
            transition-property: background-color;
            transition-duration: .5s;
    	      padding: 2px 10px;
            border-bottom: 4px solid transparent;
            /* border-top: 4px solid transparent; */
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
          color: #${base00};
        }
  
        #workspaces button {
          padding: 1px 10px;
  	      margin: 1px 3px;
          border-color: alpha (#${base00}, 0.7);
          color: #${base05};
          background: #${base00};
        }
  
        #workspaces button:hover {
        background: #${base01};
        border-color: #${base00};
  	    color: #${base05};
        }
  
        #workspaces button.focused {
        	border-color: #${base00};
          background-color: #${base01};
        }
  
        #workspaces button.urgent {
          background-color: #${base09};
        }
  
        #clock,
        #battery,
        #pulseaudio,
        #custom-weather,
        #custom-theme-toggle,
        #custom-wf-recorder {
        	color: #${base05};
        }
  
        #mode {
          background-color: #${base01};
          color: #${base05};
        }
  
        @keyframes blink {
            to {
                background-color: #${base00};
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
  
        #custom-playerctl {
        	color: #${base05};
        }
  
        #idle_inhibitor {
          color: #${base03};
        }
  
        #idle_inhibitor.activated {
            color: #${base0D};
        }
  
        #custom-wf-recorder {
          background: #${base00};
        	color: #${base0D};
        }
      '';
      
    };
  };
}
