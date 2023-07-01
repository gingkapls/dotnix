{ config, lib, pkgs, nixvim, nix-colors, ... }:

with config.colorscheme.colors;

{
  programs.nixvim = {
    enable = true;

    globals = {
      limelight_conceal_ctermfg = "#${base03}";
      limelight_conceal_guifg = "#${base03}";
    };

    plugins = {

      nix.enable = true;
      nvim-autopairs.enable = true;

      lualine = {
        enable = false;

        sectionSeparators = {
          left = "" ;
          right = "" ;
        };

        componentSeparators = {
          left = "" ;
          right = "" ;
        };

        theme = "base16";
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

      luasnip = {
        enable = true;
      };

    };

    maps = {
      # For luasnips
      insert."<Tab>" = {
        silent = true;
        expr = true;
        action = "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'";
      };

      insert."<S-Tab>" = {
        silent = true;
        noremap = true;
        action = "<cmd>lua require'luasnip'.jump(-1)<Cr>";
      };

      select."<Tab>" = {
        silent = true;
        noremap = true;
        action = "<cmd>lua require('luasnip').jump(1)<Cr>";
      };

      select."<S-Tab>" = {
        silent = true;
        noremap = true;
        action = "<cmd>lua require('luasnip').jump(-1)<Cr>";
      };

    };

    extraPlugins = with pkgs.vimPlugins; [ 
      limelight-vim
      vimtex
      # (import ./rose-pine.nix { inherit pkgs; })
      # (import ./melange.nix { inherit pkgs; })
    ];

    options = {
      # Indentation
      autoindent = true;
      tabstop = 8;
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
      spell = true;
      spelllang = "en_gb";
      conceallevel = 1;

      # Colors
      background = "${config.colorscheme.kind}";
      termguicolors = true;

    };

    colorscheme = "base16-${config.colorscheme.slug}";
    #colorscheme = "melange";

  };

  imports = [
    ./base16-vim.nix
  ];
}

