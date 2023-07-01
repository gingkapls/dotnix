{ config, pkgs, lib, ... }:

let
#  font = builtins.toString osConfig.fonts.fontconfig.defaultFonts.sansSerif;
  font = "Iosevka";
in rec {
  home.packages = lib.attrValues {
    inherit (pkgs.gnomeExtensions)
    # bluetooth-quick-connect
    # blur-my-shell
    caffeine
    # dash-to-dock
    dash-to-panel
    night-theme-switcher
    focus-changer
    # just-perfection
    rounded-window-corners
    # search-light
    # gsconnect
    user-themes;
  };

  dconf.settings = {
    "org/gnome/shell".enabled-extensions = (map (extension: extension.extensionUuid) home.packages)
    ++
    [
      "native-window-placement@gnome-shell-extensions.gcampax.github.com"
      "places-menu@gnome-shell-extensions.gcampax.github.com"
      "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
    ];
     

    "org/gnome/shell".disabled-extensions = 
    [
      "dash-to-dock@micxgx.gmail.com"
      "window-list@gnome-shell-extensions.gcampax.github.com"
      "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
      "apps-menu@gnome-shell-extensions.gcampax.github.com"
      "user-theme@gnome-shell-extensions.gcampax.github.com"
    ];

    "org/gnome/shell/extensions/blur-my-shell" = {
      brightness = 0.80;
    };
    
    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      blur = false;
    };

    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "firefox.desktop:1"
        "org.gnome.evince.desktop:2"
      ];
    };

    # Configure Bluetooth Quick Connect
    "org/gnome/shell/extensions/bluetooth-quick-connect" = {
      keep-menu-on-toggle = true;
      refresh-button-on = true;
      show-batter-icon-on = true;
    };

    "org/gnome/shell/extensions/just-perfection" = {
      activities-button = false;
      activities-button-icon-monochrome = true;
      activities-button-label = true;
      animation = 6;
      app-menu = true;
      app-menu-icon = true;
      clock-menu-position = 1;
      clock-menu-position-offset = 9;
      dash = true;
      dash-icon-size = 48;
      dash-separator = true;
      notification-banner-position = 2;
      panel-icon-size = 0;
      panel-indicator-padding-size = 0;
      panel-notification-icon = true;
      power-icon = true;
      show-apps-button = true;
      startup-status = 0;
      theme = false;
      window-demands-attention-focus = true;
      workspace-switcher-should-show = false;
      workspace-wrap-around = false;
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      animate-appicon-hover = true;
      animate-appicon-hover-animation-type = "SIMPLE";
      panel-element-positions= "{\"0\":[{\"element\":\"showAppsButton\",\"visible\":false,\"position\":\"stackedTL\"},{\"element\":\"activitiesButton\",\"visible\":false,\"position\":\"stackedTL\"},{\"element\":\"leftBox\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"taskbar\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"centerBox\",\"visible\":true,\"position\":\"centered\"},{\"element\":\"rightBox\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"systemMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"dateMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"desktopButton\",\"visible\":true,\"position\":\"stackedBR\"}]}";
      appicon-margin = 8;
      appicon-padding = 8;
      dot-position = "TOP";
      dot-style-focused = "METRO";
      trans-use-custom-opacity = true;
      trans-panel-opacity = 0.25;
    };

    # "org/gnome/shell/extensions/dash-to-dock" = {
      # apply-custom-theme = false;
      # autohide = true;
      # autohide-in-fullscreen = false;
      # background-color = "rgb(255,255,255)";
      # background-opacity = 0.25;
      # click-action = "focus-minimize-or-previews";
      # custom-background-color = true;
      # custom-theme-shrink = true;
      # dash-max-icon-size = 48;
      # dock-fixed = true;
      # dock-position = "BOTTOM";
      # extend-height = false;
      # height-fraction = 1.0;
      # hide-delay = 0.5;
      # hot-keys = false;
      # hotkeys-overlay = false;
      # icon-size-fixed = false;
      # intellihide = true;
      # intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      # isolate-workspaces = false;
      # middle-click-action = "previews";
      # preferred-monitor = -2;
      # preferred-monitor-by-connector = "eDP-1";
      # preview-size-scale = 0.0;
      # require-pressure-to-show = true;
      # running-indicator-style = "DOTS";
      # scroll-action = "switch-workspace";
      # shift-click-action = "launch";
      # shift-middle-click-action = "launch";
      # show-apps-at-top = false;
      # show-mounts-network = false;
      # show-trash = true;
      # transparency-mode = "FIXED";
    # };
       

    # "org/gnome/shell/extensions/aylurs-widgets" = {
      # notification-indicator              = true;
      # notification-indicator-hide-counter = false;
      # notification-indicator-offset       = 7;
      # notification-indicator-position     = 2;
      # background-clock                    = false;
      # battery-bar                         = false;
      # battery-bar-width                   = 100;
      # dash-board                          = false;
      # date-menu-mod                       = false;
      # media-player                        = false;
      # media-player-controls-offset        = 0;
      # media-player-enable-controls        = true;
      # media-player-enable-track           = true;
      # media-player-layout                 = 0;
      # media-player-position               = 1;
      # power-menu                          = false;
      # quick-toggles                       = false;
      # quick-toggles-hide-system-levels    = true;
      # quick-toggles-style                 = 0;
      # workspace-indicator-show-names      = false;
    # };

    "org/gnome/desktop/interface" = {
      document-font-name = "${font} Regular 13";

      clock-show-weekday = true;
      clock-show-date = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      resize-with-right-button = true;
      titlebar-font = "${font} Bold 13";
      move-to-workspace-1          = ["<Shift><Super>1"];
      move-to-workspace-2          = ["<Shift><Super>2"];
      move-to-workspace-3          = ["<Shift><Super>3"];
      move-to-workspace-4          = ["<Shift><Super>4"];
      switch-applications          = ["<Super>Tab"];
      switch-applications-backward = lib.hm.gvariant.mkEmptyArray lib.hm.gvariant.type.string;
      switch-to-workspace-1        = ["<Super>1"];
      switch-to-workspace-2        = ["<Super>2"];
      switch-to-workspace-3        = ["<Super>3"];
      switch-to-workspace-4        = ["<Super>4"];
      switch-windows               = ["<Alt>Tab"];
      switch-windows-backward      = ["<Shift><Alt>Tab"];
      toggle-fullscreen            = ["<Shift><Super>f"];
      toggle-maximized             = ["<Super>f"];
      close                        = ["<Super>q"];
      unmaximize                   = ["<Shift><Super>j"];
      maximize                     = ["<Shift><Super>k"];
      minimize                     = lib.hm.gvariant.mkEmptyArray lib.hm.gvariant.type.string;
    };

    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left            = ["<Shift><Super>h"];
      toggle-tiled-right           = ["<Shift><Super>l"];
    };

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = lib.hm.gvariant.mkEmptyArray lib.hm.gvariant.type.string;
      switch-to-application-2 = lib.hm.gvariant.mkEmptyArray lib.hm.gvariant.type.string;
      switch-to-application-3 = lib.hm.gvariant.mkEmptyArray lib.hm.gvariant.type.string;
      switch-to-application-4 = lib.hm.gvariant.mkEmptyArray lib.hm.gvariant.type.string;
    };

    # Peripherals
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };
    
    # Keyboard Settings
    "org/gnome/desktop/peripherals/keyboard" = {
      delay = 500;
      repeat = true;
      repeat-interval = 18;
    };
    
    "org/gnome/desktop/input-sources" = {
      sources = lib.hm.gvariant.mkTuple ["xkb" "us"];
      xkb-options = ["caps:swapescape" "compose:ralt"];
    };    

    # Media Keys
    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = ["<Control><Super>l"];
    };

    # Custom Keybindings
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "alacritty";
      name = "Launch Terminal";
    };

    # Wallpaper
    "org/gnome/desktop/background" = {
      # picture-uri = "file:///" + ../../assets/light.png;
      # picture-uri-dark = "file:///" + ../../assets/dark.png;
      picture-uri = "file:///" + config.home.homeDirectory + "/dotfiles/assets/light.png";
      picture-uri-dark = "file:///" + config.home.homeDirectory + "/dotfiles/assets/dark.png";
    };

    # Screensaver
    "org/gnome/desktop/screensaver" = {
      # picture-uri = "file:///" + ../../assets/light.png;
      picture-uri = "file:///" + config.home.homeDirectory + "/dotfiles/assets/light.png";
    };

    # "org/gnome/shell/extensions/app-menu" = { enabled = false; };
  };
}
