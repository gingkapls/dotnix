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
        asvetliakov.vscode-neovim
        jnoortheen.nix-ide
        github.github-vscode-theme
        # ms-vscode.cpptools
        ms-vscode.live-server
        esbenp.prettier-vscode
        rust-lang.rust-analyzer
        mvllow.rose-pine
        wallabyjs.console-ninja
      ];

      # userSettings = {
        # "editor.fontLigatures" = false;
        # "editor.formatOnSave" = true;
        # "editor.defaultFormatter" = "esbenp.prettier-vscode";
        # "editor.fontFamily" = "${font-mono}";

        # "console-ninja.featureSet" = "Community";

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
