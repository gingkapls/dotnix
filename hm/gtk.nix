{ config, pkgs, ... }:

{
  gtk = {
    enable = true;

    font = {
      name = "Inter";
      size = "12";
    };

    theme = {
      name = "Plano";
      package = "pkgs.plano";
    };

    iconTheme.package = "tela-icon-theme";

  };

}
