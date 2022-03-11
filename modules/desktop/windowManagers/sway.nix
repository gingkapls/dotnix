{ config, pkgs, lib, nix-colors, ... }:

with config.colorscheme.colors;
with lib;
let cfg = config.modules.desktop.windowManager.sway;
in
  {
    options.modules.desktop.windowManager.sway = {
      enable = mkEnableOption "Enable Sway the i3-like wayland compositor";
    };

    config = mkIf cfg.enable {

      home.packages = with pkgs; [
        swaylock swayidle
        wl-clipboard
        mako
        bemenu
        slurp swappy grim
        wf-recorder 
      ];

      # services.swayidle = {
      #   enable = true;

      #   events = [
      #     { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock"; }
      #     { event = "lock"; command = "${pkgs.swaylock}/bin/swaylock"; }
      #   ];

      #   timeouts = [
      #     { timeout = 300; command = "${pkgs.swaylock}/bin/swaylock -fF"; }
      #     { timeout = 600; command = "${pkgs.systemd}/bin/systemctl suspend"; }
      #   ];
      #   
      # };

    wayland.windowManager.sway = { 
      enable = true;
      systemdIntegration = true;
      wrapperFeatures.gtk = true;

      extraSessionCommands = ''
        export XDG_SESSION_DESKTOP=sway
        export SDL_VIDEODRIVER=wayland
        export QT_QPA_PLATFORM=wayland-egl
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export MOZ_ENABLE_WAYLAND=1
        export CLUTTER_BACKEND=wayland
        export ECORE_EVAS_ENGINE=wayland-egl
        export ELM_ENGINE=wayland_egl
        export NO_AT_BRIDGE=1
        export _JAVA_AWT_WM_NONREPARENTING=1
        '';
  
      config = {
        workspaceAutoBackAndForth = true;
        window = {
          border = 4;
        };

        input = {
          "type:touchpad" = {
            "dwt" = "enabled";
            "tap" = "enabled";
            "natural_scroll" = "enabled";
            "middle_emulation" = "enabled";
          };

          "type:keyboard" = {
            "xkb_options" = "caps:swapescape,compose:ralt";
	          "repeat_rate" = "40";
          };
        };

        output."*".bg = "$HOME/.dotnix/assets/wallpaper.png fill #${base01}";


        # terminal = "${pkgs.alacritty}/bin/alacritty";
        terminal = "${pkgs.foot}/bin/footclient";
        modifier = "Mod4";
  
        defaultWorkspace = "1";
  
        startup = [
          { command = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator"; }
          { command = "${pkgs.autotiling}/bin/autotiling"; always = true; }
          # { command = "i3-floating-decor"; }
          # { command = "music-notifier"; }
          { command = "swayidle -w \\
          timeout 300 'swaylock -f' \\
          timeout 600 'swaymsg \"output * dpms off\"' resume 'swaymsg \"output * dpms on\"' \\
          timeout 900 'systemctl suspend' \\
          before-sleep 'swaylock -f' \\"; }
        ];
  
        fonts = {
          names = [ "Iosevka Slab" ];
          style = "Medium";
          size = 16.0;
        };
  
        colors = {
          background = "#${base02}";
          focused = {
            background = "#${base02}";
            border = "#${base02}";
            childBorder = "#${base02}";
            indicator = "#${base02}";
            text = "#${base02}";
          };
  
           focusedInactive = {
            background = "#${base01}";
            border = "#${base01}";
            childBorder = "#${base01}";
            indicator = "#${base01}";
            text = "#${base01}";
          };
  
           unfocused = {
            background = "#${base01}";
            border = "#${base01}";
            childBorder = "#${base01}";
            indicator = "#${base01}";
            text = "#${base01}";
          };
  
           urgent = {
            background = "#${base08}";
            border = "#${base08}";
            childBorder = "#${base08}";
            indicator = "#${base08}";
            text = "#${base08}";
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
          inner = 0;
          top = 0;
          bottom = 5;
          left = 5;
          right = 5;
          
          smartGaps = false;
          smartBorders = "on";
        };
  
        keybindings = 
          let
            modifier = config.wayland.windowManager.sway.config.modifier;
            terminal = config.wayland.windowManager.sway.config.terminal;
  
            left = "h";
            down = "j";
            up = "k";
            right = "l";
            runner = "${pkgs.bemenu}/bin/bemenu-run ${config.home.sessionVariables.BEMENU_OPTS}";
  
            volume = action: "exec set-volume ${action}";
            brightness = action: "exec set-brightness ${action}";
            player = action: "exec ${pkgs.playerctl}/bin/playerctl ${action}";
            screenshot = action: "exec wlshot ${action}";
            screenrecord = action: "exec wlrecord ${action}";
  
          in lib.mkOptionDefault {
            "${modifier}+Return" = "exec ${terminal}";
            "${modifier}+q" = "kill";
            "${modifier}+d" = "exec ${runner}";
            "${modifier}+m" = "exec meme-menu";
            "${modifier}+Shift+r" = "reload";
            "${modifier}+Shift+c" = "restart";
            "${modifier}+grave" = "exec ${pkgs.mako}/bin/makoctl restore";
  
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
  
            "${modifier}+button4 --whole-window"  = "workspace next";
            "${modifier}+button5 --whole-window"  = "workspace prev";
  
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
            "${modifier}+e" = "layout toggle tabbed split";
            "${modifier}+f" = "fullscreen";
            "${modifier}+s" = "floating toggle";
            "${modifier}+c" = "layout toggle stacking split";
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
            "Alt+button1" = screenshot "color-picker";
            "Ctrl+Shift+Print" = screenshot "select-window";
            "Ctrl+Alt+Print" = screenshot "ocr";

            # Screenrecords
            "${modifier}+Print" = screenrecord "screen";
            "${modifier}+Ctrl+Print" = screenrecord "select";
            "${modifier}+Shift+Print" = screenrecord "window";
  
            # Lock
            "${modifier}+Ctrl+l" = "exec ${pkgs.swaylock}/bin/swaylock";
  
            # Modes
            "${modifier}+r" = "mode resize";
            "${modifier}+g" = "mode gaps";
            "${modifier}+a" = "mode applications";
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
  
          applications = {
            "m" = "exec meme-menu, mode default";
            "g" = "exec google-chrome-stable, mode default";
            "f" = "exec nautilus, mode default";
            "Return" = "mode default";
            "Escape" = "mode default";
          };
        };

        bars = [];
  
      };
  
      extraConfig = ''
        title_align center
        titlebar_padding 10 2
        for_window [ app_id="firefox" title=".*Picture-in-Picture.*" ] floating enable, sticky enable resize set width 600 height 500
        for_window [ app_id="org.gnome.Nautilus" ] floating enable, resize set width 800 set height 600
        for_window [ app_id="gcolor3" ] floating enable, resize set width 800 set height 600
        for_window [ app_id="imv" ] floating enable, resize set width 800 set height 600
      '';
    };
  
  };

}
