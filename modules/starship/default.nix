{ lib, pkgs, ...}:

{
  hjem.users.gin.xdg.config.files = {
    "starship.toml".source = ./starship.toml;
  };

  users.users.gin.packages = lib.attrValues {
    inherit (pkgs)
    starship;
  };
}
