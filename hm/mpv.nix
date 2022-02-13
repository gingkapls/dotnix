{ config, pkgs, ... }:

{
  # mpv config
  programs.mpv = {
    enable = true;
    bindings = {
      "l"          = "seek 1 exact";
      "h"          = "seek -1 exact";
      "j"          = "add volume -2";
      "k"          = "add volume 2";
      "Ctrl+l"     = "seek 1" ;
      "Ctrl+h"     = "seek -1";
      "WHEEL_UP"   = "ignore";
      "WHEEL_DOWN" = "ignore";
      "Q"          = "quit-watch-later";
      "z"          = "add sub-delay -0.1";
      "Z"          = "add sub-delay +0.1";
    };

    config = {
      geometry = "50%:50%";
      autofit-larger = "90%x90%";
      keep-open = "yes";
      ontop = "yes";
      hwdec = "auto";
      audio-device = "auto";
      audio-pitch-correction = "yes";
      audio-channels = "auto-safe";
      cache = "yes";
      alang = "jap";
      slang = "en";
      sub-auto = "fuzzy";
      yt-dl-raw-options = "sub-format=en,write-srt=";
    };

  };
}