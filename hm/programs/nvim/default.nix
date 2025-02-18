{ config, lib, pkgs, nixvim, nix-colors, ... }:

with config.colorscheme.palette;

{
  programs.nixvim = {
    enable = false;

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
        settings = {
          linenr = false;
        };
      };

      lsp = {
        enable = true;
    	  servers = {
    	    rnix-lsp.enable = false;
    	    rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
    	  };
      };

      luasnip = {
        enable = true;
      };

    };

    # maps = {
    #   # For luasnips
    #   insert."<Tab>" = {
    #     silent = true;
    #     expr = true;
    #     action = "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'";
    #   };

    #   insert."<S-Tab>" = {
    #     silent = true;
    #     noremap = true;
    #     action = "<cmd>lua require'luasnip'.jump(-1)<Cr>";
    #   };

    #   select."<Tab>" = {
    #     silent = true;
    #     noremap = true;
    #     action = "<cmd>lua require('luasnip').jump(1)<Cr>";
    #   };

    #   select."<S-Tab>" = {
    #     silent = true;
    #     noremap = true;
    #     action = "<cmd>lua require('luasnip').jump(-1)<Cr>";
    #   };

    # };

    extraPlugins = with pkgs.vimPlugins; [ 
      limelight-vim
      vimtex
      # (import ./rose-pine.nix { inherit pkgs; })
      # (import ./melange.nix { inherit pkgs; })
    ];

    opts = {
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
      background = "${config.colorscheme.variant}";
      termguicolors = true;

    };

    colorscheme = "base16-${config.colorscheme.slug}";
    #colorscheme = "melange";

  };

  imports = [
    ./base16-vim.nix
  ];
}

