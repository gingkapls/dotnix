{ config, osConfig, pkgs, lib, nix-vscode-extensions, ... }:

with lib;
let 
  cfg = config.modules.programs.vscode;
  font-mono = builtins.head osConfig.fonts.fontconfig.defaultFonts.monospace;
in
{
  options.modules.programs.vscode = {
    enable = mkEnableOption "Enable Visual Studio Code";
  };

  config = mkIf cfg.enable {

    programs.vscode = {
      enable = true;
      extensions = with nix-vscode-extensions.extensions.x86_64-linux.vscode-marketplace; [
        # Util
        asvetliakov.vscode-neovim

        # LSPs
        jnoortheen.nix-ide
        ms-vscode.live-server
        rust-lang.rust-analyzer

        # Formatters and Linters
        esbenp.prettier-vscode
        dbaeumer.vscode-eslint

        # Themes
        antfu.theme-vitesse
        mvllow.rose-pine
        github.github-vscode-theme
      ];

      # userSettings = {
        # "editor.fontLigatures" = false;
        # "editor.formatOnSave" = true;
        # "editor.defaultFormatter" = "esbenp.prettier-vscode";
        # "editor.fontFamily" = "${font-mono}";

        # "window.titleBarStyle" = "custom";
        # "window.zoomLevel" = 1.5;
        # "terminal.integrated.env.linux" = {};

        # # Themeing
        # # "window.autoDetectColorScheme" = true;
        # "workbench.colorTheme" = "Rosé Pine Moon";
        # # "workbench.preferredLightColorTheme" = "Rosé Pine Dawn";
        # # "workbench.preferredDarkColorTheme" = "Rosé Pine Moon";


        # "extensions.experimental.affinity" = {
          # "asvetliakov.vscode-neovim" = 1;
        # };
      # };
    };
  };


}
