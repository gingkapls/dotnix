{ config, pkgs, nix-colors, lib, ... }:

with config.colorscheme.colors; {
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
        { command = "${pkgs.networkmanagerapplet}/bin/nm-applet"; notification = false; }
        { command = "xss-lock --transfer-sleep-lock -- ${pkgs.i3lock-color}/bin/i3lock-color --nofork"; notification = false; }
        { command = "${pkgs.picom}/bin/picom"; notification = false; }
        { command = "${pkgs.autotiling}/bin/autotiling"; notification = false; }
        { command = "${pkgs.playerctl}/bin/playerctld"; notification = false; }
        { command = "i3-floating-decor"; notification = false; }
      ];

      fonts = {
        names = [ "Iosevka Slab" ];
        style = "Medium";
        size = 12.0;
      };

      colors = {
        background = "#${base09}";
        focused = {
          background = "#${base09}";
          border = "#${base09}";
          childBorder = "#${base09}";
          indicator = "#${base09}";
          text = "#${base00}";
        };

         focusedInactive = {
          background = "#${base01}";
          border = "#${base01}";
          childBorder = "#${base01}";
          indicator = "#${base01}";
          text = "#${base03}";
        };

         unfocused = {
          background = "#${base01}";
          border = "#${base01}";
          childBorder = "#${base01}";
          indicator = "#${base01}";
          text = "#${base03}";
        };

         urgent = {
          background = "#${base08}";
          border = "#${base08}";
          childBorder = "#${base08}";
          indicator = "#${base08}";
          text = "#${base00}";
        };

         placeholder = {
          background = "#${base00}";
          border = "#${base01}";
          childBorder = "#${base01}";
          indicator = "#${base01}";
          text = "#${base05}";
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
          runner = "${pkgs.dmenu}/bin/dmenu_run -i -fn 'Inter Medium 12' -nb '#${base00}' -nf '#${base05}' -sb '#${base09}' -sf '#${base00}'";

          volume = action: "exec set-volume ${action}";
          brightness = action: "exec set-brightness ${action}";
          player = action: "exec ${pkgs.playerctl}/bin/playerctl ${action}";
          screenshot = action: "exec screenshot ${action}";

        in lib.mkOptionDefault {
          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+q" = "kill";
          "${modifier}+d" = "exec ${runner}";
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

          # Screenshots
          "Print" = screenshot "screen";
          "Ctrl+Print" = screenshot "select";
          "Shift+Print" = screenshot "window";
          "Alt+Print" = screenshot "color-picker";
          "Ctrl+Shift+Print" = screenshot "select-window";
          "Ctrl+Alt+Print" = screenshot "ocr";

          # "XF86AudioMicMute" = "${pkgs.pactl}/bin/pactl set-source @DEFAULT_SOURCE@ toggle";

          # Lock
          "${modifier}+Ctrl+l" = "exec ${pkgs.i3lock-color}/bin/i3lock-color";

      };

      modes = {
        resize = { 
          "h"      = "resize shrink width 5 px or 5 ppt";
          "j"      = "resize grow height 5 px or 5 ppt";
          "k"      = "resize shrink height 5 px or 5 ppt";
          "l"      = "resize grow width 5 px or 5 ppt";

          "i"      = "resize grow width 5px, resize grow height 5px";
          "o"      = "resize shrink width 5px, resize shrink height 5px";
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
        fonts = {
          names = [ "Inter" "Material Icons" ];
          style = "Medium";
          size = 12.0;
        };
        workspaceNumbers = true;
         colors = {
   
           # The background color of the bar.
           background = "#${base00}";
           separator = "#${base00}";
   
           # The colors for binding mode indicators.
           bindingMode = {
             background = "#${base00}";
             border = "#${base01}";
             text = "#${base07}";
           };
   
           # The colors for focused workspaces.
           focusedWorkspace = {
             background = "#${base09}";
             border = "#${base01}";
             text = "#${base00}";
           };

           # The colors for the workspace button for an active workspace.
            activeWorkspace = {
             background = "#${base00}";
             border = "#${base00}";
             text = "#${base03}";
           };
  
           # The colors for inactive workspaces.
           inactiveWorkspace = {
             background = "#${base01}";
             border = "#${base01}";
             text = "#${base03}";
           };
         };
 
       }
       ];
    };

    extraConfig = ''
      title_align center
    '';

  };

}
