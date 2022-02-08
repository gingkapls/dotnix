{ config, pkgs, nixvim, ... }:

{
  # Neovim
  programs.nixvim = {
    enable = true;

    colorschemes.base16 = {
      enable = true;
      colorscheme = "horizon-dark";
    };

    plugins = {
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
      autoindent = true;
      clipboard = "unnamedplus";
    };

  };

}
