{ config, pkgs, nixvim, nix-colors, ... }:

{
  # Neovim

  programs.nixvim = {
    enable = true;

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

    extraPlugins = with pkgs.vimPlugins; [ 
      # (import ./rose-pine.nix { inherit pkgs; })
      (import ./melange.nix { inherit pkgs; })
    ];

    options = {
      # Indentation
      autoindent = true;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      backspace = "indent,eol,start";

      # Text
      showmatch = true;
      mouse = "a";
      number = true;
      relativenumber = false;
      ttyfast = true;
      clipboard = "unnamedplus";

      # Colors
      background = "${config.colorscheme.kind}";
      termguicolors = true;

    };

    # colorscheme = "base16-${config.colorscheme.slug}";
    colorscheme = "melange";

  };

  programs.neovim.vimAlias = true;
  programs.neovim.viAlias = true;

}
