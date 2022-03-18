{ config, pkgs, lib, ... }:

with lib;
let 
  cfg = config.modules.programs.vscode;
in
{
  options = options.modules.programs.vscode {
    enable = true;
  };

  config = mkIf cfg.enable {

    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        asvetliakov.vscode-neovim
        jnoortheen.nix-ide
        cpptools
        matklad.rust-analyzer
      ];

    };
  };


}
