{ pkgs, lib, ... }:

{
  hjem.users.gin.xdg.config.file = {
    "easyeffects/output/perfect-eq.json".source = ./perfect-eq.json;
    "easyeffects/output/bass-enhanced-perfect-eq.json".source = ./bass-enhanced-perfect-eq.json;
    "easyeffects/output/advanced-auto-gain.json".source = ./advanced-auto-gain.json;
  };

  users.users.gin.packages = lib.attrValues {
    inherit (pkgs)
      easyeffects;
  };
}
