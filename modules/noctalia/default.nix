{ pkgs, ...}:

{
  hjem.users.gin.xdg.config.files = {
    "noctalia/noctalia-full-config.toml".source = ./noctalia-full-config.toml;

    # Zathura template
    "noctalia/templates/zathura/zathurarc".source = ./templates/zathura/zathurarc;
    "noctalia/templates/zathura/apply.sh".source = ./templates/zathura/apply.sh;
    "noctalia/templates.toml".source = ./templates.toml;
  };
}
