{ pkgs, ...}:

{
  hjem.users.gin.xdg.config.files = {
    "helix/config.toml".source = ./config.toml;
    "helix/languages.toml".source = ./languages.toml;
  };
}
