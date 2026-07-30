{ config, pkgs, lib, nix-colors, ... }:

with config.colorscheme.palette;
with lib;
let cfg = config.modules.desktop.windowManager.niri;
in
  {
    options.modules.desktop.windowManager.niri = {
      enable = mkEnableOption "Enable Niri, the wayland compositor";
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        wl-clipboard
        mako
        fuzzel
        bemenu
        slurp swappy grim
        wf-recorder 
        xwayland-satellite
      ];

      programs.dank-material-shell = {
      	enable = true;
        systemd = {
          enable = true;             # Systemd service for auto-start
          restartIfChanged = true;   # Auto-restart dms.service when dank-material-shell changes
        };

        # Core features
        enableSystemMonitoring = true;     # System monitoring widgets (dgop)
        enableVPN = true;                  # VPN management widget
        enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
        enableAudioWavelength = true;      # Audio visualizer (cava)
        enableCalendarEvents = true;       # Calendar integration (khal)
      };
    };
}
