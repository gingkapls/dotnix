{ config, pkgs, lib, nix-colors, ... }:

with config.colorscheme.colors;
with lib;
let
  cfg = config.modules.programs.foot;
in {
  options.modules.programs.foot = {
    enable = mkEnableOption "Enable Foot, the lightweight terminal emulator for Wayland";
  };

  config = mkIf cfg.enable {

  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "Iosevka Medium:size=10";
        font-bold = "Iosevka Heavy:size=10";
        font-italic = "Iosevka Oblique:size=10";
        dpi-aware = "yes";
        locked-title = "no";
        pad = "40x40";
      };

      scrollback.lines = 10000;

      url = {
        launch = "xdg-open \${url}";
      };

      cursor = {
        style = "block";
        color = "${base00} ${base05}";
        blink = "no";
      };

      mouse = {
        hide-when-typing = "no";
      };

      colors = {
        alpha = 1.0;
        background = "${base00}";
        foreground = "${base05}";

        regular0 = "${base00}";
        regular1 = "${base08}";
        regular2 = "${base0B}";
        regular3 = "${base0A}";
        regular4 = "${base0D}";
        regular5 = "${base0E}";
        regular6 = "${base0C}";
        regular7 = "${base05}";

        bright0 = "${base03}";
        bright1 = "${base09}";
        bright2 = "${base01}";
        bright3 = "${base02}";
        bright4 = "${base04}";
        bright5 = "${base06}";
        bright6 = "${base0F}";
        bright7 = "${base07}";

        selection-foreground = "${base00}";
        selection-background = "${base05}";
        urls = "${base0D}";
        scrollback-indicator = "${base00} ${base0D}";
        };

        csd = {
          preferred = "server";
        };
      };
    };
  };

}
