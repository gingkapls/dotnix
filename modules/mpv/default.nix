{ pkgs, ...}:

{
  hjem.users.gin.xdg.config.files = {
    "mpv/mpv.conf".source = ./mpv.conf;
    "mpv/input.conf".source = ./input.conf;
  };
}
