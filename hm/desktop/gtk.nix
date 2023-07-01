{ config, lib, pkgs, nix-colors, ... }:

with config.colorscheme;
let 
  inherit (nix-colors.lib-contrib {inherit pkgs; }) gtkThemeFromScheme;
in {
  gtk = {
    enable = true;

    font = {
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
      #extraConfig = {
      #  "gtk-cursor-theme-size" = 32;
      #  "gtk-cursor-theme-name" = "capitaine-cursors";
      #};
    };

  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      package = pkgs.adwaita-qt;
      name = "${ if config.colorscheme.kind == "light" then "adwaita" else "adwaita-dark" }";
    };
  };

  home = {
    pointerCursor = {
      name = "${if config.colorscheme.kind == "dark" then "Capitaine-cursors-white" else "Capitaine-cursors"}";
      package = pkgs.capitaine-cursors;

      x11 = {
        defaultCursor = "capitaine-cursors";
        enable = false;
      };

    };

    # activation = {
    #   switchTheme = lib.hm.dag.entryAfter ["writeBoundary"] ''
    #     $DRY_RUN_CMD gsettings set org.gnome.desktop.interface color-scheme 'prefer-${config.colorscheme.kind}' && gsettings set org.gnome.desktop.interface gtk-key-theme '${config.colorscheme.name}'
    #   ''; # Switch pesky gtk4 themes (thanks gnome)
    # };
  };

  #home.file.".icons/default".source = "${
  #  if config.colorscheme.kind == "dark"
  #  then "${pkgs.capitaine-cursors}/share/icons/capitaine-cursors-white"
  #  else "${pkgs.capitaine-cursors}/share/icons/capitaine-cursors"
  #}";

}
