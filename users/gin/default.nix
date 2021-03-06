{ config, inputs, pkgs, nix-colors, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  # colorscheme = nix-colors.colorSchemes.rose-pine-dawn;

  home = {
    username = "gin";
    homeDirectory = "/home/gin";

    packages = with pkgs; [ 
    google-chrome 
    gnome.nautilus
    coreutils tree jq
    pulseaudioLight
    blender darktable gimp krita inkscape imagemagick gcolor3 kdenlive shotcut audacity
    zathura mpv imv nitrogen
    gh git git-crypt gnupg openssl
    playerctl pamixer pavucontrol
    networkmanagerapplet
    picom slop maim xdotool tesseract
    dunst libnotify
    mangohud
    dconf
    yt-dlp spotdl rhythmbox lollypop cava
    qbittorrent
    ventoy-bin
    aria2 rclone
    # android-tools enable programs.adb instead
    android-udev-rules
    tdesktop
    obsidian logseq
    rmlint lm_sensors
    wezterm
  ];

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
  
    stateVersion = "21.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true; 

  nixpkgs.config.allowUnfree = true;

  modules = {

    desktop = {
      windowManager.i3.enable = true;
      windowManager.awesome.enable = true;
      windowManager.sway.enable = true;
      picom.enable = true;
      dunst.enable = false;
      mako.enable = true;
      waybar.enable = true;
      xidlehook.enable = false;
    };

    shell = {
      zsh.enable = true;
      fish.enable = false;
    };

    programs = {
      foot.enable = true;
      vscode.enable = true;
    };

  };

  services = {
    easyeffects = {
      enable = true;
      preset = "perfect-eq";
    };

  };

  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;

      defaultApplications = {
        "image/jpeg" = [ "imv.desktop" ];
        "image/png" = [ "imv.desktop" ];
        "image/gif" = [ "imv.desktop" ];
        "image/svg+xml" = [ "imv.desktop" ];
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "application/json" = [ "nvim.desktop" ];
        "application/x-yaml" = [ "nvim.desktop" ];
      };
    
    };

    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";

    userDirs = {
      enable = true;
      createDirectories = true;
    };

  };

  imports = [
    ../../modules
    nix-colors.homeManagerModule
  ];
}
