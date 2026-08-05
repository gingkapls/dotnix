{ ...}:

{
  imports = [
    ../starship
  ];

  hjem.users.gin.xdg.config.files = {
    "fish/config.fish".source = ./config.fish;
  };
}
