{ config, pkgs, ... }: 

with config.colorscheme;
let 
  inherit (nix-colors.lib-contrib {inherit pkgs; }) gtkThemeFromScheme;
in {
  imports = [
    ./gnome.nix
    ./i3.nix
    ./i3status.nix
    ./picom.nix
    ./sway.nix
    ./swaylock.nix
    ./xorg.nix
  ];

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

}
