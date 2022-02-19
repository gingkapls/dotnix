{ config, pkgs, nix-colors, lib, ... }:

with config.colorscheme.colors; {
  services.dunst = {
    enable = true;

    settings = {
      global = {
        monitor = 0;
        width = 300;
        height = 300;

        origin = "top-right";
        offset = "25x30";
        notification_limit = 5;
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        indicate_hidden = "yes";
        transparency = 0;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        text_icon_padding = 8;
        frame_width = 4;
        frame_color = "#${base00}";
        separator_color = "frame";

        sort = "yes";
        font = "Inter Medium 12";
        line_height = 0;
        markup = "full";
        min_icon_size = "32";
        max_icon_size = "96";
        icon_position = "right";

        format = "<b>%s</b>\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = true;
        show_indicators = false;

        sticky_history = "yes";
        history_length = 20;
        title = "Dunst";
        class = "Dunst";
        corner_radius = 0;
        ignore_dbusclose = true;

        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "open_url, close_current";
        mouse_right_click = "context";
        timeout = 3;
      };

      urgency_low = {
        background = "#${base01}";
        foreground = "#${base03}";
        highlight = "#${base09}";
      };

      urgency_normal = {
        background = "#${base01}";
        foreground = "#${base05}";
        highlight = "#${base09}";
      };

      urgency_critical = {
        background = "#${base01}";
        foreground = "#${base08}";
        frame_color = "#${base08}";
        highlight = "#${base08}";
        timeout = 0;
      };

      fullscreen = {
        fullscreen = "pushback";
      };

      "appname=\"volume\"" = {
        history_ignore = true;
      };

      "appname=\"brightness\"" = {
        history_ignore = true;
      };

    };

  };

}
