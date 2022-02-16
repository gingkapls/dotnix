{ config, pkgs, nix-colors, ... }: 

with config.colorscheme.colors; {
  programs.zathura = {
    enable = true;
    options = {
      default-bg = "${base00}";
      default-fg = "${base05}";

      statusbar-bg = "${base01}";
      statusbar-fg = "${base05}";

      inputbar-bg = "${base01}";
      inputbar-fg = "${base05}";

      notification-bg = "${base00}";
      notification-fg = "${base05}";

      notification-error-bg = "${base00}";
      notification-error-fg = "${base08}";

      notification-warning-bg = "${base09}";
      notification-warning-fg = "${base09}";

      hightlight-color = "${base0A}";
      hightlight-active-color = "${base0D}";

      completion-bg = "${base01}";
      completion-fg = "${base0D}";

      completition-highlight-bg = "${base05}";
      completition-highlight-fg = "${base00}";

      recolor-lightcolor = "${base00}";
      recolor-darkcolor = "${base05}";

      index-active-bg = "${base00}";
      index-active-fg = "${base05}";

      render-loading-bg = "${base00}";
      render-loading-fg = "${base05}";

      recolor = true;
      recolor-keephue = true;
    };

  };

}
