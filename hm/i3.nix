{ config, pkgs, nix-colors, lib, ... }:

let 
  koko = config.colorscheme.colors;
in

{
  # Status bar
  imports = [ ./i3status.nix ];

  xsession.windowManager.i3 = { 
    enable = true;

    config = rec {
      workspaceAutoBackAndForth = true;
      window.border = 4;
      terminal = "${pkgs.alacritty}/bin/alacritty";
      modifier = "Mod4";

      defaultWorkspace = "1";

      startup = [
        { command = "nm-applet"; notification = false; }
        { command = "xss-lock --transfer-sleep-lock -- i3lock-color --nofork"; notification = false; }
        { command = "picom"; notification = false; }
      ];

      fonts = {
        names = [ "Iosevka Slab" ];
        style = "Heavy";
        size = 12.0;
      };

      colors = {
        background = "#${koko.base00}";
        focused = {
          background = "#${koko.base00}";
          border = "#${koko.base01}";
          childBorder = "#${koko.base01}";
          indicator = "#${koko.base02}";
          text = "#${koko.base05}";
        };

         placeholder = {
          background = "#${koko.base00}";
          border = "#${koko.base01}";
          childBorder = "#${koko.base01}";
          indicator = "#${koko.base02}";
          text = "#${koko.base05}";
        };
 
         focusedInactive = {
          background = "#${koko.base00}";
          border = "#${koko.base03}";
          childBorder = "#${koko.base03}";
          indicator = "#${koko.base03}";
          text = "#${koko.base03}";
        };

         unfocused = {
          background = "#${koko.base00}";
          border = "#${koko.base00}";
          childBorder = "#${koko.base00}";
          indicator = "#${koko.base00}";
          text = "#${koko.base00}";
        };

         urgent = {
          background = "#${koko.base00}";
          border = "#${koko.base08}";
          childBorder = "#${koko.base0A}";
          indicator = "#${koko.base08}";
          text = "#${koko.base05}";
        };
      };

      gaps = {
        inner = 10;
        outer = 5;
        smartGaps = true;
        smartBorders = "on";
      };

      keybindings = 
        let
          modifier = config.xsession.windowManager.i3.config.modifier;

          left = "h";
          down = "j";
          up = "k";
          right = "l";

          volume = action: "exec ${pkgs.pulseaudioLight}/bin/pactl set-sink-volume @DEFAULT_SINK@ ${if action == "up" then "+5%" else "-5%"}";
          brightness = action: "exec ${pkgs.brightnessctl}/bin/brightnessctl -q set ${if action == "up" then "5%+" else "5%-"}";
          player = action: "exec ${pkgs.playerctl}/bin/playerctl ${action}";

        in lib.mkOptionDefault {
          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+q" = "kill";
          "${modifier}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";
          "${modifier}+Shift+r" = "reload";
          "${modifier}+Shift+c" = "restart";

          ## Changing Focus
          "${modifier}+${left}" = "focus left";
          "${modifier}+${down}" = "focus down";
          "${modifier}+${up}" = "focus up";
          "${modifier}+${right}" = "focus right";

          ## Moving Focused Window
          "${modifier}+Shift+${left}"  = "move left";
          "${modifier}+Shift+${down}"  = "move down";
          "${modifier}+Shift+${up}"    = "move up";
          "${modifier}+Shift+${right}" = "move right";

          # Workspaces
          "${modifier}+Tab"  = "workspace back_and_forth";
          "${modifier}+bracketleft"  = "workspace prev";
          "${modifier}+bracketright"  = "workspace right";

          # Move Workspaces
          "${modifier}+Shift+1"  = "move container to workspace number 1, workspace number 1";
          "${modifier}+Shift+2"  = "move container to workspace number 2, workspace number 2";
          "${modifier}+Shift+3"  = "move container to workspace number 3, workspace number 3";
          "${modifier}+Shift+4"  = "move container to workspace number 4, workspace number 4";
          "${modifier}+Shift+5"  = "move container to workspace number 5, workspace number 5";
          "${modifier}+Shift+6"  = "move container to workspace number 6, workspace number 6";
          "${modifier}+Shift+7"  = "move container to workspace number 7, workspace number 7";
          "${modifier}+Shift+8"  = "move container to workspace number 8, workspace number 8";
          "${modifier}+Shift+9"  = "move container to workspace number 9, workspace number 9";
          "${modifier}+Shift+0"  = "move container to workspace number 10, workspace number 10";

          # Layout
          "${modifier}+a" = "split toggle";
          "${modifier}+e" = "layout toggle split | tabbed";
          "${modifier}+f" = "fullscreen";
          "${modifier}+s" = "floating toggle";
          "${modifier}+c" = "layout toggle stacking | split";
          "${modifier}+space" = "focus mode_toggle";

          # Scratchpad
          "${modifier}+Shift+o" = "move scratchpad";
          "${modifier}+Ctrl+o" = "sticky toggle";
          "${modifier}+o" = "scratchpad show";

          # Media
          "XF86AudioPlay" = player "play-pause";
          "XF86AudioStop" = player "stop";
          "XF86AudioPrev" = player "previous";
          "XF86AudioNext" = player "next";

          # Volume 
          "XF86AudioMute" = "exec ${pkgs.pulseaudioLight}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";

          "XF86AudioRaiseVolume" = volume "up";
          "XF86AudioLowerVolume" = volume "down";

          # Brightness
          "XF86MonBrightnessUp" = brightness "up";
          "XF86MonBrightnessDown" = brightness "down";

          # "XF86AudioMicMute" = "${pkgs.pactl}/bin/pactl set-source @DEFAULT_SOURCE@ toggle";

          # Lock
          "${modifier}+Ctrl+l" = "exec ${pkgs.i3lock-color}/bin/i3lock-color";

      };

      modes = {
        resize = { 
          "h"      = "resize shrink width 10 px or 10 ppt";
          "j"      = "resize grow height 10 px or 10 ppt";
          "k"      = "resize shrink height 10 px or 10 ppt";
          "l"      = "resize grow width 10 px or 10 ppt";

          "i"      = "resize grow width 10px, resize grow height 10px";
          "o"      = "resize shrink width 10px, resize shrink height 10px";
          "equal"  = "resize set width 50ppt height 50pp, mode default";
          "Return" = "mode default";
          "Escape" = "mode default";
        }; 

        gaps = {
          "KP_ADD" = "gaps outer current plus 1";
          "KP_SUBTRACT" = "gaps outer current minus 1";

          "Shift+KP_ADD" = "gaps inner current plus 1";
          "Shift+KP_SUBTRACT" = "gaps inner current minus 1";

          "Return" = "mode default";
          "Escape" = "mode default";

          "r" = "gaps outer current set 5, gaps inner current set 5, mode default";
        };
      };

      bars = [
        {
        command = "i3bar";
        mode = "hide";
        statusCommand = "${pkgs.i3status}/bin/i3status ";
        position = "bottom";
        workspaceNumbers = true;
         colors = {
           # The colors for the workspace button for an active workspace.
           activeWorkspace = {
             background = "#${koko.base00}";
             border = "#${koko.base00}";
             text = "#${koko.base00}";
           };
   
           # The background color of the bar.
           background = "#${koko.base00}";
   
           # The colors for binding mode indicators.
           bindingMode = {
             background = "#${koko.base00}";
             border = "#${koko.base01}";
             text = "#${koko.base08}";
           };
   
           # The colors for focused workspaces.
           focusedWorkspace = {
             background = "#${koko.base0A}";
             border = "#${koko.base01}";
             text = "#${koko.base05}";
           };
   
           # The colors for inactive workspaces.
           inactiveWorkspace = {
             background = "#${koko.base01}";
             border = "#${koko.base01}";
             text = "#${koko.base03}";
           };
         };
 
       }
       ];

    };

  };

}
