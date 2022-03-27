{ config, pkgs, nixvim, nix-colors, ... }:

let
  #rose-pine = pkgs.vimUtils.buildVimPluginFrom2Nix {
  #  pname = "rose-pine.nvim";
  #  version = "v1.0.0";
  #  src = pkgs.fetchFromGitHub {
  #    owner = "rose-pine";
  #    repo = "neovim";
  #    rev = "v1.0.0";
  #    sha256 = "m6l5yjQiX5kclw34xzGwbLmh10oL+4F0kKB/b+TOMQ4=";
  #  };
  #  meta.homepage = "https://github.com/rose-pine/neovim/";
  #};
  test = test;

in {
  # Neovim

  programs.nixvim = {
    enable = true;

    # Use default till we make our own colorscheme
     colorscheme = "base16-${config.colorscheme.slug}";

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

        theme = "auto";
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

    # extraPlugins = with pkgs.vimPlugins; [ rose-pine ];

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
      relativenumber = false;
      ttyfast = true;
      clipboard = "unnamedplus";
      # background = config.colorscheme.kind;
    };

  };

  programs.neovim.vimAlias = true;
  programs.neovim.viAlias = true;

}
