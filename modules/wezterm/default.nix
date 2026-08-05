{ pkgs, ...}:

{
  hjem.users.gin.xdg.config.files = {
    "wezterm/wezterm.lua".source = ./wezterm.lua;
  };
}
