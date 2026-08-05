{ lib, pkgs, ...}:

{
  users.users.gin.packages = lib.attrValues {
    inherit (pkgs)
    firefox;
  };

  hjem.users.gin.files = {
    ".mozilla/firefox/profiles.ini".source = ./profiles.ini;
    ".mozilla/firefox/gin/user.js".source = ./user.js;
  };
}
