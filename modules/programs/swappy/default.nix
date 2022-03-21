{ config, ... }:

{
  xdg.configFile."swappy/config".text = ''
    [Default]
    save_dir=${config.home.homeDirectory}/Pictures/Shots
    save_filename_format=%F_%T.png
    text_font=Inter Medium
    text_size=12
  '';
}
