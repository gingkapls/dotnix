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
        theme = "everblush";

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

      extraPackages = with pkgs.nodePackages; [
        typescript-language-server
        vscode-langservers-extracted
      ];

      languages = {
        language-server = {
          typescript-language-server = with pkgs.nodePackages; {
             command = "${typescript-language-server}/bin/typescript-language-server";
             args = [ "--stdio" ];
            config.tsserver.path = "${typescript}/bin/tsserver";
          };


          eslint = {
            command = "vscode-eslint-language-server";
            args = [ "--stdio" ];
            config = {
              format = false;
              packageManages = "npm";
              nodePath = "";
              workingDirectory.mode = "auto";
              onIgnoredFiles = "off";
              run = "onType";
              validate = "on";
              useESLintClass = false;
              experimental = { };
              codeAction = {
                disableRuleComment = {
                  enable = true;
                  location = "separateLine";
                };
                showDocumentation.enable = true;
              };
            };
          };
          vscode-css-language-server.config.provideFormatter = false;
          vscode-html-language-server.config.provideFormatter = false;
        };


        language = [
          {
            name = "javascript";
            auto-format = false;
            language-servers = [
              "efm-prettier"
              { name = "typescript-language-server"; except-features = [ "format" ]; }
              { name = "eslint"; except-features = [ "format" ]; }
            ];
          }
          {
            name = "html";
            language-servers = [ "vscode-html-language-server" "efm-prettier" ];
          }
          {
            name = "css";
            language-servers = [ "vscode-css-language-server" "efm-prettier" ];
          }
        ];

      };

    };
  };

}
