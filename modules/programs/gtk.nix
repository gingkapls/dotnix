{ config, pkgs, ... }:

{
  gtk = {
    enable = true;

    font = {
      name = "Inter";
      size = 12;
    };

    theme = {
      name = "Plano";
      package = pkgs.plano-theme;
    };

    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela";
    };

  };

}
