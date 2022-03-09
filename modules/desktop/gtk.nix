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
      package = pkgs.tela-icon-theme;
      name = "Tela";
    };

  };
}
