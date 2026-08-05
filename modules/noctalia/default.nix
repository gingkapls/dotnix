{ pkgs, ...}:

{
  hjem.users.gin.xdg.config.files = {
    "noctalia/noctalia-full-config.toml".source = ./noctalia-full-config.toml;
  };
}
