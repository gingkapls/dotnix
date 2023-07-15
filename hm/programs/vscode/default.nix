{ config, pkgs, lib, nix-vscode-extensions, ... }:

with lib;
let 
  cfg = config.modules.programs.vscode;
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
        ms-vscode.cpptools
        rust-lang.rust-analyzer
        mvllow.rose-pine
        wallabyjs.console-ninja
      ];

    };
  };


}
