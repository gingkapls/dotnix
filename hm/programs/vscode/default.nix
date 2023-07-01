{ config, pkgs, lib, ... }:

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
      extensions = with pkgs.vscode-extensions; [
        asvetliakov.vscode-neovim
        jnoortheen.nix-ide
        ms-vscode.cpptools
        matklad.rust-analyzer
        mvllow.rose-pine
      ];

    };
  };


}
