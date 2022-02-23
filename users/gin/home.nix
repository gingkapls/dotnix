{ config, pkgs, nix-colors, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  colorscheme = nix-colors.colorSchemes.material;

  home = {
    username = "gin";
    homeDirectory = "/home/gin";

    sessionVariables = {
      LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"; # this is so ugly ;-;
    };

    # sessionVariables = {
    #   FVWM_USERDIR = "$HOME/.config/fvwm";
    # };

    packages = with pkgs; [ 
    alacritty
    google-chrome firefox 
    gnome.nautilus
    coreutils tree jq
    blender
    gimp krita inkscape imagemagick
    zathura
    mpv imv nitrogen
    gh git git-crypt gnupg
    playerctl pamixer
    picom
    networkmanagerapplet
    slop maim xdotool tesseract
    dunst libnotify
    qbittorrent
    mangohud
    dconf
    spotdl
    ventoy-bin
    aria2
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

  services = {
    easyeffects = {
      enable = true;
      preset = "perfect-eq";
    };

    xidlehook = {
      enable = true;
      not-when-audio = true;
      not-when-fullscreen = true;
      environment = {
        "primary-display" = "$(${pkgs.xorg.xrandr}/bin/xrandr | awk '/ primary/{print $1}')";
      };

      timers = [
        {
          delay = 60;
          command = "${pkgs.brightnessctl}/bin/brightnessctl --quiet set 10%-";
          canceller = "${pkgs.brightnessctl}/bin/brightnessctl --quiet set 10%+";
        }

        {
          delay = 300;
          command = "${pkgs.xorg.xrandr}/bin/xrandr --output \"$PRIMARY_DISPLAY\" --brightness .1";
          canceller = "${pkgs.xorg.xrandr}/bin/xrandr --output \"$PRIMARY_DISPLAY\" --brightness 1";
        }

        {
          delay = 600;
          command = "${pkgs.xorg.xrandr}/bin/xrandr --output \"$PRIMARY_DISPLAY\" --brightness 1; ${pkgs.i3lock-color}/bin/i3lock-color; sleep 1; ${pkgs.systemd}/bin/systemctl suspend";
          canceller = "";
        }
      ];

    };

  };

  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps.enable = true;

    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";

    configHome = "${config.home.homeDirectory}/.config";
#    configFile."easyeffects/output/perfect-eq.json".text = import ./easyeffects.nix;

    userDirs = {
      enable = true;
      createDirectories = true;
    };

  };

  imports = [
    ./zsh.nix 
    ./nvim.nix
    ./mpv.nix
    ./i3.nix
    ./alacritty.nix
    ./dunst.nix
    ./zathura.nix
    ./shell-scripts.nix
    ./firefox.nix
    ./gtk.nix
    ./picom.nix
    ./easyeffects.nix
    nix-colors.homeManagerModule
  ];

}
