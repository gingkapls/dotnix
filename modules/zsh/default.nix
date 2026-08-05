{ pkgs, ...}:

{
  hjem.users.gin.xdg.config.files = {
    "zsh/.zshrc".source = ./.zshrc;
  };
}
