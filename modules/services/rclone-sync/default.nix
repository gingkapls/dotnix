{ config, pkgs, ... }:

{
  systemd.user = {
    services.rclone-sync = {
      Unit = {
        Description = "Automatically backup data to google drive.";
        Documentation = [ "man:rclone" ];
      };

      Service = {
        Restart = "on-abnormal";
        ExecStart = "${pkgs.rclone}/bin/rclone copy ${config.home.homeDirectory}/Documents gdrive:/Documents --create-empty-src-dirs --progress --copy-links";
        KillMode = "mixed";
        KillSignal = "SIGTERM";
        TimeoutStopSec = "5s";
      };

      Install = {
        WantedBy = [ "default.target" ] ;
      };
    };

    timers.rclone-sync = {
      Unit = {
        Description = "Perform an rclone sync to Google Drive periodically";
        Documentation = [ "man:rclone" ];
      };

      Timer = {
        OnBootSec = "30m";
        OnUnitActiveSec = "1h";
      };

      Install = {
        WantedBy = [ "timers.target" ];
      };

    };

  };


}
