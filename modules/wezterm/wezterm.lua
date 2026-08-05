local wezterm = require 'wezterm';

return {
  enable_wayland = true,
  hide_tab_bar_if_only_one_tab = true,
  check_for_updates = false,
  initial_rows = 18,
  initial_cols = 70,
  color_scheme = 'Gruvbox dark, medium (base16)',

  font = wezterm.font("Input Mono", {weight="Medium"} ),
  font_size = 18,

  window_padding = {
      left = 20,
      right = 20,
      top = 20,
      bottom = 20,
  },
}
