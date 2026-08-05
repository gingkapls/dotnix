{ pkgs, config, lib, ... }: {
  hjem.users.gin = {
    user = "gin";
    directory = "/home/gin";
    clobberFiles = true;

    environment.sessionVariables = {
      EDITOR = lib.getExe pkgs.helix;
      VISUAL = lib.geteExe pkgs.helix;
      ZDOTDIR = config.hjem.users.gin.xdg.config.directory + "./zsh";
    };
  };

  users.users.gin.packages = with pkgs; [
    # Utilities
    coreutils tree jq rename gh
    krita inkscape
    droidcam cheese guvcview
    imagemagick imv gcolor3 amberol 
    playerctl pamixer pavucontrol
    networkmanagerapplet
    aria2 rclone yt-dlp
    scrcpy
    inotify-tools rmlint lm_sensors p7zip comma
    glib gsettings-desktop-schemas
    hyperfine
    gammastep
    localsend
    pciutils usbutils
    helix

    # Shell utils
    zoxide
    direnv
    fzf
    starship

    # Applications
    google-chrome
    gnome-network-displays
    qbittorrent transmission_4-gtk
    telegram-desktop obsidian
    zathura foliate calibre
    pear-desktop
    lutris mangohud
    mpv
    kitty
    wezterm
    blackbox-terminal
    styluslabs-write-bin
    xournalpp
    anki
    nautilus
    bottles
    faugus-launcher
    protontricks
    libreoffice

    wl-clipboard
    fuzzel
    wf-recorder 
    xwayland-satellite
    noctalia
    firefox
  ];
}
