{ config, lib, pkgs, ... }: 

with config.colorscheme;
let 
  inherit (nix-colors.lib-contrib {inherit pkgs; }) gtkThemeFromScheme;
in {
  imports = [
    ./gnome.nix
    ./hyprland.nix
    ./i3.nix
    ./i3status.nix
    ./picom.nix
    ./sway.nix
    ./swaylock.nix
    ./xorg.nix
  ];

  options.wallpapers = with lib.types; {
    light-url = {
      url = lib.mkOption { type = str; };
      sha256 = lib.mkOption { type = str; };
    };

    dark-url = {
      url = lib.mkOption { type = str; };
      sha256 = lib.mkOption { type = str; };
    };

    light = lib.mkOption {
      type = path;
      readOnly = true;
      default = (pkgs.fetchurl config.wallpapers.light-url).outPath;
    };

    dark = lib.mkOption {
      type = path;
      readOnly = true;
      default = (pkgs.fetchurl config.wallpapers.dark-url).outPath;
    };
  };



  config = {
    wallpapers = {
      light-url = {
	url = "https://w.wallhaven.cc/full/je/wallhaven-jexkwm.jpg";
	sha256 = "1gpjnnkvnmcg07aah0g4ixw90pcpq50abx5nrf0rhsdjbvzh1324";
      };

      dark-url = {
	url = "https://w.wallhaven.cc/full/zp/wallhaven-zp5z2w.png";
	sha256 = "1v45vgpdnsg0c6j552l3vgannyp1kw5w96f8zwv6gv3x570f185n";
      };
    };

    gtk = {
      enable = true;
  
      font = {
        # name = "SF Pro Text Regular";
        # package = pkgs.sf-pro-fonts;
        name = "Inter";
        package = pkgs.inter;
        size = 13;
      };
  
      theme = {
        name = "Adwaita";
      };
  
      iconTheme = {
        # name = "WhiteSur";
        name = "Adwaita";
        # package = pkgs.whitesur-icon-theme.override {
          # boldPanelIcons = true;
        # };
      };
  
      gtk2.extraConfig = "
        gtk-cursor-theme-name=\"capitaine-cursors\"
        gtk-cursor-theme-size=32
      ";
  
      gtk3 = {
        bookmarks = [ "file:///mnt/data/files/Anime" "file:///mnt/data/files" "file:///mnt/data/games" ];
        extraConfig = {
         "gtk-cursor-theme-size" = 16;
         "gtk-cursor-theme-name" = "capitaine-cursors";
        };
      };
  
    };
  
    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style = {
        package = pkgs.adwaita-qt;
        name = "adwaita";
        # name = "${ if config.colorscheme.variant == "light" then "adwaita" else "adwaita-dark" }";
      };
    };
  
    home = {
      pointerCursor = {
      name = "Capitaine-cursors";
        # name = "${if config.colorscheme.variant == "dark" then "Capitaine-cursors-white" else "Capitaine-cursors"}";
        package = pkgs.capitaine-cursors;
  
        x11 = {
          defaultCursor = "capitaine-cursors";
          enable = true;
        };
      };
    };
	};

}
