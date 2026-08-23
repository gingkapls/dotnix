{ pkgs, config, lib, ... }: {
  hjem.users.gin = {
    user = "gin";
    directory = "/home/gin";
    clobberFiles = true;

    environment.sessionVariables = {
      EDITOR = lib.getExe pkgs.helix;
      VISUAL = lib.geteExe pkgs.helix;
      ZDOTDIR = "${config.hjem.users.gin.xdg.config.directory}/zsh";

      # FZF
      FZF_DEFAULT_OPTS = "--info inline --color=16 --preview '${pkgs.bat}/bin/bat {}'";
      FZF_DEFAULT_COMMAND = "${pkgs.fd}/bin/fd --type f --strip-cwd-prefix --hidden --follow --exclude '.git' --exclude '.wine' --exclude '.cache'";
      FZF_CTRL_T_COMMAND = "${config.hjem.users.gin.environment.sessionVariables.FZF_DEFAULT_COMMAND}";

      QT_SCALE_FACTOR = "1.2";

      # Wayland
      NIXOS_OZONE_WL = 1;
      ANKI_WAYLAND = 1;
    };
  };

  users.users.gin.packages = with pkgs; [
    # Utilities
    coreutils tree jq rename gh
    krita inkscape
    imagemagick imv amberol 
    playerctl
    aria2 rclone yt-dlp
    scrcpy
    inotify-tools rmlint lm_sensors p7zip comma
    glib gsettings-desktop-schemas
    hyperfine
    localsend
    pciutils usbutils
    helix

    # Shell utils
    zoxide
    direnv
    fzf

    # Applications
    google-chrome
    firefox
		qutebrowser
    qbittorrent
    telegram-desktop discord arrpc
		obsidian
    zathura foliate
    pear-desktop
    mangohud
    mpv
    styluslabs-write-bin
    xournalpp
    anki
    nautilus
    bottles
    faugus-launcher
    protontricks
    libreoffice
  ];
}
