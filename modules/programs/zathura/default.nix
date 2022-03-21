{ config, pkgs, nix-colors, ... }: 

with config.colorscheme.colors; {
  programs.zathura = {
    enable = true;
    options = {
      default-bg = "#${base00}";
      default-fg = "#${base05}";

      statusbar-bg = "#${base01}";
      statusbar-fg = "#${base05}";

      inputbar-bg = "#${base01}";
      inputbar-fg = "#${base05}";

      notification-bg = "#${base00}";
      notification-fg = "#${base05}";

      notification-error-bg = "#${base00}";
      notification-error-fg = "#${base08}";

      notification-warning-bg = "#${base09}";
      notification-warning-fg = "#${base09}";

      highlight-color = "#${base0A}";
      highlight-active-color = "#${base0D}";

      completion-bg = "#${base01}";
      completion-fg = "#${base0D}";

      completion-highlight-bg = "#${base05}";
      completion-highlight-fg = "#${base00}";

      recolor-lightcolor = "#${base00}";
      recolor-darkcolor = "#${base05}";

      index-active-bg = "#${base00}";
      index-active-fg = "#${base05}";

      render-loading-bg = "#${base00}";
      render-loading-fg = "#${base05}";

      recolor = true;
      recolor-keephue = true;
    };
    extraConfig = ''
      map '*' feedkeys ":set recolor true<Return>"

      ## sepia
      map 'S' feedkeys ":set recolor-lightcolor '#DFC7A7'<Return>("
      map '(' feedkeys ":set statusbar-fg '#${base05}'<Return>)"
      map ')' feedkeys ":set recolor-darkcolor '#000000'<Return>*"
      
      ## transparent dark
      map 'D' feedkeys ":set recolor-lightcolor 'rgba(${base00}, ${base00}, ${base00}, 0.85)'<Return>{"
      map '{' feedkeys ":set statusbar-fg '#${base05}'<Return>}"
      map '}' feedkeys ":set recolor-darkcolor '#${base05}'<Return>*"
      
      ## transparent light
      map 'A' feedkeys ":set recolor-lightcolor 'rgba(${base05}, ${base05}, ${base05}, 0.95)'<Return>)"
      map ')' feedkeys ":set statusbar-fg '#${base00}'<Return>("
      map '(' feedkeys ":set recolor-darkcolor '#${base00}'<Return>*"
    '';

  };

}
