{ config, pkgs, nixvim, ... }:

let
  rose-pine = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "rose-pine.nvim";
    version = "v1.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "rose-pine";
      repo = "neovim";
      rev = "v1.0.0";
      sha256 = "m6l5yjQiX5kclw34xzGwbLmh10oL+4F0kKB/b+TOMQ4=";
    };
    meta.homepage = "https://github.com/rose-pine/neovim/";
  };

in {
  # Neovim
  programs.nixvim = {
    enable = true;

    colorscheme = "rose-pine";

    plugins = {

      nix.enable = true;
      nvim-autopairs.enable = true;

      lualine = {
        enable = true;
        sectionSeparators = {
          left = "" ;
          right = "" ;
        };
        componentSeparators = {
          left = "" ;
          right = "" ;
        };
      };

      goyo = {
        enable = true;
        showLineNumbers = false;
      };

      lsp = {
        enable = true;
	      servers = {
	        rust-analyzer.enable = true;
	        rnix-lsp.enable = true;
	      };
      };

    };

    extraPlugins = with pkgs.vimPlugins; [ rose-pine ];

    options = {
      # Indentation
      autoindent = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      backspace = "indent,eol,start";

      # Text
      showmatch = true;
      mouse = "a";
      number = true;
      relativenumber = true;
      ttyfast = true;
      clipboard = "unnamedplus";
      background = config.colorscheme.kind;
    };

  };

  programs.neovim.vimAlias = true;
  programs.neovim.viAlias = true;


}
