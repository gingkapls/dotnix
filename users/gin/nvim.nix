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

      lsp = {
        enable = true;
	      servers = {
	        rust-analyzer.enable = true;
	        rnix-lsp.enable = true;
	      };
      };

    };

    extraPlugins = with pkgs.vimPlugins; [
      auto-pairs
    ];

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
      statusline = "%#StatuslineNC#\ %n\ %#Statusline#\ %#LineNr#\ %f\ %m\ %r\ %=\ %y\ %#StatuslineNC#\ %l:%c\ %p%%";
      # statusline = "%#StatuslineNC#\ %n\ %#Statusline#\ %#LineNr#\ %f\ %m\ %r\ %=\ %y\ %#StatuslineNC#\ %l:%c\ %p%%\";
    };

  };

}
