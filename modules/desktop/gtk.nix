{ config, pkgs, nix-colors, ... }:

with config.colorscheme;
let 
  inherit (nix-colors.lib {inherit pkgs; }) gtkThemeFromScheme;
in {
  gtk = {
    enable = true;

    font = {
      name = "Inter";
      size = 12;
    };

    theme = {
      name = "${slug}";
      package = gtkThemeFromScheme {
        scheme = config.colorscheme;
      };
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "${if config.colorscheme.kind == "dark" then "Papirus-Dark" else "Papirus-Light"}";
    };

    gtk2.extraConfig = "
      gtk-cursor-theme-name=\"capitaine-cursors\"
      gtk-cursor-theme-size=32
    ";

    gtk3 = {
      bookmarks = [ "file:///mnt/data/files/Anime" "file:////mnt/data/files" "file:////mnt/data/games" ];
      #extraConfig = {
      #  "gtk-cursor-theme-size" = 32;
      #  "gtk-cursor-theme-name" = "capitaine-cursors";
      #};
    };

  };

  xsession.pointerCursor = {
    package = pkgs.capitaine-cursors;
    defaultCursor = "capitaine-cursors";
    name = "${ if config.colorscheme.kind == "dark" then "capitaine-cursors-white" else "capitaine-cursors" }";
  };

  #home.file.".icons/default".source = "${
  #  if config.colorscheme.kind == "dark"
  #  then "${pkgs.capitaine-cursors}/share/icons/capitaine-cursors-white"
  #  else "${pkgs.capitaine-cursors}/share/icons/capitaine-cursors"
  #}";

}
