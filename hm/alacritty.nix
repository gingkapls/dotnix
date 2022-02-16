{ config, pkgs, nix-colors, ... }: 

with config.colorscheme.colors; {

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        dimensions = {
          columns = 60;
          lines = 15;
        };

        padding = {
          x = 20;
          y = 20;
        };
      };

      dynamic_padding = false;
      decorations = "none";

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      font = {
        normal = {
          family = "Iosevka";
          style = "Medium";
        };

        bold = {
          family = "Iosevka";
          style = "Heavy";
        };
       
        italic = {
          family = "Iosevka";
          style = "Medium Oblique";
        };

        bold_italic = {
          family = "Iosevka";
          style = "Heavy Oblique";
        };

        size = 12.0;

        use_think_strokes = false;
      };

      colors = {
        cursor = {
          text = "0x${base00}";
          cursor = "0x${base05}";
        };

        selection = {
          text = "0x${base00}";
          background = "0x${base05}";
        };

        primary = {
          background = "0x${base00}";
          foreground = "0x${base05}";
        };

        normal = {
          black = "0x${base00}";
          red = "0x${base08}";
          green = "0x${base0B}";
          yellow = "0x${base0A}";
          blue = "0x${base0D}";
          magenta = "0x${base0E}";
          cyan = "0x${base0C}";
          white = "0x${base05}";
        };

        bright = {
          black = "0x${base03}";
          red = "0x${base09}";
          green = "0x${base01}";
          yellow = "0x${base02}";
          blue = "0x${base04}";
          magenta = "0x${base06}";
          cyan = "0x${base0F}";
          white = "0x${base07}";
        };
        
      };

      cursor = {
        style = "Block";
        unfocused_hollow = true;
        live_config_reload = true;
      };

      dynamic_title = true;
      save_to_clipboard = true;

      mouse.hide_when_typing = true;
    };

  };

}
