{ config, osConfig, pkgs, lib, ... }:

let
  font-sans = builtins.head osConfig.fonts.fontconfig.defaultFonts.sansSerif;
  font-serif = builtins.head osConfig.fonts.fontconfig.defaultFonts.serif;
  font-mono = builtins.head osConfig.fonts.fontconfig.defaultFonts.monospace;
in rec {
  home.packages = lib.attrValues {
    inherit (pkgs.gnomeExtensions)
    # bluetooth-quick-connect
    blur-my-shell
    caffeine
    dash-to-dock
    dash-to-panel
    night-theme-switcher
    focus-changer
    paperwm
    just-perfection
    # rounded-window-corners
    steal-my-focus-window
    luminus-shell
    # search-light
    # gsconnect
    useless-gaps
    user-themes;
  };

  dconf.settings = {
    "org/gnome/shell".enabled-extensions = (map (extension: extension.extensionUuid) home.packages)
    ++
    [
      "caffeine@patapon.info"
      "places-menu@gnome-shell-extensions.gcampax.github.com"
      "nightthemeswitcher@romainvigier.fr"
      "steal-my-focus-window@steal-my-focus-window"
      "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
      "paperwm@paperwm.github.com"
      "light-style@gnome-shell-extensions.gcampax.github.com"
    ];
     
    "org/gnome/shell".disabled-extensions = 
    [
      "dash-to-panel@jderose9.github.com"
      "dash-to-dock@micxgx.gmail.com"
      "native-window-placement@gnome-shell-extensions.gcampax.github.com"
      "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
      "window-list@gnome-shell-extensions.gcampax.github.com"
      "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
      "apps-menu@gnome-shell-extensions.gcampax.github.com"
      "user-theme@gnome-shell-extensions.gcampax.github.com"
      "useless-gaps@pimsnel.com"
      "focus-changer@heartmire"
    ];

    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "firefox.desktop:1"
        "org.gnome.evince.desktop:2"
      ];
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

    "org/gnome/shell/extensions/paperwm" = {
      horizontal-margin = 10;
      minimap-scale = 0.0;
      disable-top-bar-styling = true;
      open-window-position = 0;
      gesture-workspace-fingers=0;
      restore-attach-modal-dialogs= "";
      restore-edge-tiling = "";
      restore-keybinds = "{}";
      restore-workspaces-only-on-primary= " ";
      show-workspace-indicator = false; # The values are reversed upstream for some reason
      use-default-background = true;
      vertical-margin = 10;
      vertical-margin-bottom = 10;
      window-gap = 20;
      window-switcher-preview-scale = 0.15;
      winprops = [ 
        "{\"wm_class\":\"mpv\",\"scratch_layer\":true}"
        "{\"wm_class\":\"gcolor3\",\"scratch_layer\":true}"
        "{\"wm_class\":\"firefox\",\"title\": \"Picture-in-Picture\", \"scratch_layer\":true}"
      ];
    };

   "org/gnome/shell/extensions/paperwm/keybindings" = {
      close-window                 = ["<Super>BackSpace" "<Super>q"];
      move-down                    = ["<Shift><Super>j"];
      move-left                    = ["<Shift><Super>h"];
      move-right                   = ["<Shift><Super>l"];
      move-up                      = ["<Shift><Super>k"];
      new-window                   = ["<Super>n"];
      switch-down                  = ["<Super>Down" "<Super>j"];
      switch-left                  = ["<Super>Left" "<Super>h"];
      switch-next-loop             = lib.hm.gvariant.mkEmptyArray lib.hm.gvariant.type.string;
      switch-right                 = ["<Super>Right" "<Super>l"];
      switch-up                    = ["<Super>Up" "<Super>k"];
      toggle-maximize-width        = ["<Super>f" "<Super>w"];
      toggle-scratch               = ["<Super>a"];
      switch-up-workspace          = ["<Super>bracketleft"];
      switch-down-workspace        = ["<Super>bracketright"];
      previous-workspace           = ["<Super>Tab"];
      previous-workspace-backward  = ["<Shift><Super>Tab"];
      live-alt-tab                 = ["<Alt>Tab"];
      live-alt-tab-backward        = ["<Shift><Alt>Tab"];
    };

    "org/gnome/desktop/interface" = {
      document-font-name = "${font-sans} 13";
      monospace-font-name = "${font-mono} 13";
      text-scaling-factor = 1.10;
      clock-show-weekday = true;
      clock-show-date = true;
    };

    "org/gnome/desktop/wm/preferences" = {
      resize-with-right-button = true;
      button-layout = "icon:minimize,maximize,close";
      titlebar-font = "${font-serif} Bold 13";
    };

    "org/gnome/desktop/wm/keybindings" = {
      resize-with-right-button        = true;
      titlebar-font                   = "${font-serif} 13";
      move-to-workspace-1             = ["<Shift><Super>1"];
      move-to-workspace-2             = ["<Shift><Super>2"];
      move-to-workspace-3             = ["<Shift><Super>3"];
      move-to-workspace-4             = ["<Shift><Super>4"];
      # switch-applications           = ["<Super>Tab"];
      switch-applications-backward    = lib.hm.gvariant.mkEmptyArray lib.hm.gvariant.type.string;
      switch-to-workspace-1           = ["<Super>1"];
      switch-to-workspace-2           = ["<Super>2"];
      switch-to-workspace-3           = ["<Super>3"];
      switch-to-workspace-4           = ["<Super>4"];
      switch-windows                  = ["<Super>Tab"];
      switch-windows-backward         = ["<Shift><Super>Tab"];
      toggle-fullscreen               = lib.hm.gvariant.mkEmptyArray lib.hm.gvariant.type.string;
      toggle-maximized                = lib.hm.gvariant.mkEmptyArray lib.hm.gvariant.type.string;
      close                           = ["<Super>q"];
      unmaximize                      = lib.hm.gvariant.mkEmptyArray lib.hm.gvariant.type.string;
      maximize                        = lib.hm.gvariant.mkEmptyArray lib.hm.gvariant.type.string;
      minimize                        = lib.hm.gvariant.mkEmptyArray lib.hm.gvariant.type.string;
    };

    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left               = ["<Shift><Super>h"];
      toggle-tiled-right              = ["<Shift><Super>l"];
    };

    "org/gnome/shell/keybindings" = {
      toggle-overview         = ["<Super>s"];
      toggle-quick-settings   = lib.hm.gvariant.mkEmptyArray lib.hm.gvariant.type.string;
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
      # xkb-options = ["caps:swapescape" "compose:ralt"];
      xkb-options = ["compose:ralt"];
    };    

    # Media Keys
    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = ["<Control><Super>l"];
    };

    # Custom Keybindings
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "blackbox";
      name = "Launch Terminal";
    };

    # Wallpaper
    "org/gnome/desktop/background" = {
      # picture-uri = "file:///" + ../../assets/light.png;
      # picture-uri-dark = "file:///" + ../../assets/dark.png;
      picture-uri = "file:///" + config.home.homeDirectory + "/Pictures/Wallpapers/light.png";
      picture-uri-dark = "file:///" + config.home.homeDirectory + "/Pictures/Wallpapers/dark.png";
    };

    # Screensaver
    "org/gnome/desktop/screensaver" = {
      # picture-uri = "file:///" + ../../assets/light.png;
      picture-uri = "file:///" + config.home.homeDirectory + "/Pictures/Wallpapers/light.png";
    };

    # "org/gnome/shell/extensions/app-menu" = { enabled = false; };
  };
}
