{ config, nix-colors, ... }:

with config.colorscheme.colors;
{
  xdg.configFile."wezterm/wezterm.lua".text = ''
    local wezterm = require 'wezterm';
    
    return {
      enable_wayland = true,
      hide_tab_bar_if_only_one_tab = true,
      check_for_updates = false,
    
      font = wezterm.font("Iosevka", {weight="Medium"} ),
      font_size = 18;

      window_padding = {
          left = 20,
          right = 20,
          top = 20,
          bottom = 20,
      },
    
      colors = {
          -- The default text color
          foreground = "#${base05}",
          -- The default background color
          background = "#${base00}",
    
          -- Overrides the cell background color when the current cell is occupied by the
          -- cursor and the cursor style is set to Block
          cursor_bg = "#${base05}",
          -- Overrides the text color when the current cell is occupied by the cursor
          cursor_fg = "#${base00}",
          -- Specifies the border color of the cursor when the cursor style is set to Block,
          -- or the color of the vertical or horizontal bar when the cursor style is set to
          -- Bar or Underline.
          cursor_border = "#${base05}",
    
          -- the foreground color of selected text
          selection_fg = "#${base05}",
          -- the background color of selected text
          selection_bg = "#${base02}",
    
          -- The color of the scrollbar "thumb"; the portion that represents the current viewport
          scrollbar_thumb = "#${base09}",
    
          -- The color of the split lines between panes
          split = "#${base00}",
    
          ansi = {
          "#${base00}", -- black
          "#${base08}", -- red
          "#${base0B}", -- green
          "#${base0A}", -- yellow
          "#${base0D}", -- blue
          "#${base0E}", -- magenta
          "#${base0C}", -- cyan
          "#${base05}"  -- white
          },

          brights = {
          "#${base03}", -- black
          "#${base09}", -- red
          "#${base01}", -- green
          "#${base02}", -- yellow
          "#${base04}", -- blue
          "#${base06}", -- magenta
          "#${base0F}", -- cyan
          "#${base07}"  -- white
          },
    
          -- Arbitrary colors of the palette in the range from 16 to 255
          indexed = {[136] = "#af8700"},
    
          -- Since: 20220319-142410-0fcdea07
          -- When the IME, a dead key or a leader key are being processed and are effectively
          -- holding input pending the result of input composition, change the cursor
          -- to this color to give a visual cue about the compose state.
          compose_cursor = "orange",
      }
    }
    '';


}
