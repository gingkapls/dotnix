{ lib, pkgs, ... }:

{
  hjem.users.gin.xdg.config.files = {
    "kitty/kitty.conf".source = ./kitty.conf;
  };

  users.users.gin.packages = lib.attrValues {
    inherit (pkgs)
    kitty;
  };
}
