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
        font = "IBM Plex Mono:style=Medium:size=12";
        font-bold = "IBM Plex Mono:style=Bold:size=12";
        font-italic = "IBM Plex Mono:style=Italic:size=12";
        font-bold-italic = "IBM Plex Mono:style=Bold Italic:size=12";
        dpi-aware = "yes";
        locked-title = "no";
        pad = "20x20";
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

        regular0 = "${base00}"; # black/bg
        regular1 = "${base08}"; # red
        regular2 = "${base0B}"; # green
        regular3 = "${base0A}"; # yellow
        regular4 = "${base0D}"; # blue
        regular5 = "${base0E}"; # magenta
        regular6 = "${base0C}"; # cyan
        regular7 = "${base05}"; # white/fg

        bright0 = "${base03}"; # bright black
        bright1 = "${base09}"; # bright red
        bright2 = "${base01}"; # bright green/lbg
        bright3 = "${base02}"; # bright yellow
        bright4 = "${base04}"; # bright blue
        bright5 = "${base06}"; # bright magenta
        bright6 = "${base0F}"; # bright cyan
        bright7 = "${base07}"; # bright white

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
