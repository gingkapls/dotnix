{ config, pkgs, lib, ... }:

let
  cfg = config.modules.programs.helix;
in {
  options.modules.programs.helix = {
    enable = lib.mkEnableOption "Enable Helix the postmodern cli editor";
  };
 
  config = lib.mkIf cfg.enable {

    programs.helix = {
      enable = true;
      settings = {
        # General
        # theme = "base16_transparent";
        theme = "github_dark_tritanopia";

        # Editor
        editor = {
          auto-pairs = false;
          line-number = "relative";
          true-color = true;
          lsp.display-messages = true;
         
          soft-wrap = {
            enable = true;
          };

          indent-guides = {
            render = true;
            character = "┆";
            skip-levels = 1;
          };
        };

      };
    };
  };

}
