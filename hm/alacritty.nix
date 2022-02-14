{ pkgs, config, nix-colors, ... }: 

let
  koko = config.colorscheme.colors;
in

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        dimensions = {
          columns = 150;
          lines = 40;
        };

        padding = {
          x = 10;
          y = 10;
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
          text = "#${koko.base00}";
          cursor = "#${koko.base05}";
        };

        selection = {
          text = "#${koko.base00}";
          background = "#${koko.base05}";
        };

        primary = {
          background = "#${koko.base00}";
          foreground = "#${koko.base05}";
        };

        normal = {
          black = "#${koko.base00}";
          red = "#${koko.base08}";
          green = "#${koko.base0B}";
          yellow = "#${koko.base0A}";
          blue = "#${koko.base0D}";
          magenta = "#${koko.base0E}";
          cyan = "#${koko.base0C}";
          white = "#${koko.base05}";
        };

        bright = {
          black = "#${koko.base03}";
          red = "#${koko.base09}";
          green = "#${koko.base01}";
          yellow = "#${koko.base02}";
          blue = "#${koko.base04}";
          magenta = "#${koko.base06}";
          cyan = "#${koko.base0F}";
          white = "#${koko.base07}";
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
