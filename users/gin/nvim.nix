{ config, pkgs, nixvim, ... }:

{
  # Neovim
  programs.nixvim = {
    enable = true;

    colorschemes.base16 = {
      enable = true;
      colorscheme = "material";
    };

    plugins = {

      nix.enable = true;
      nvim-autopairs.enable = true;

      lualine = {
        enable = true;
        theme = "material";
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
      ls = 0;
    };

  };

  programs.neovim.vimAlias = true;
  programs.neovim.viAlias = true;


}
