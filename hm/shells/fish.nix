{ config, pkgs, lib, nix-colors, ... }:

with lib;
let 
  cfg = config.modules.shells.fish;
in {

  options.modules.shells.fish = {
    enable = mkEnableOption "Enable Fish shell";
  };

  config = mkIf cfg.enable {
    programs = {
      fish = {
        enable = true;
        shellAliases = {
          rm = "rm -i";
          mv = "mv -i";
          cp = "cp -i";
          perl-rename = "perl-rename -i";
        };

        functions = {
          chrome = {
            body = ''explorer.exe $argv[1]'';
          };

          dls = {
            body = ''spotdl --max-retries 5 --output "$MUSIC_DIR/{artist}/{album}/{track-number} - {title}.{output-ext}" "$argv[1]"'';
          };
        };

        loginShellInit = "
          if test -e $HOME/.nix-profile/etc/profile.d/nix.sh;
            source $HOME/.nix-profile/etc/profile.d/nix.fish;
          end; 
        ";

        interactiveShellInit = with config.colorscheme.palette;"
        set -g fish_greeting
        fish_vi_key_bindings 

        # set fish_color_normal '#${base05}'
        # set fish_color_command '#${base0D}' --bold
        # set fish_color_quote '#${base0B}'
        # set fish_color_redirection '#${base0D}'
        # set fish_color_end '#${base05}'
        # set fish_color_error '#${base08}'
        # set fish_color_param '#${base0A}'
        # set fish_color_comment '#${base03}'
        # set fish_color_match '#${base05}'
        # set fish_color_selection '#${base03}'
        # set fish_color_search_match '#${base0A}' --bold
        # set fish_color_operator '#${base0B}'
        # set fish_color_escape '#${base0C}'
        # set fish_color_cwd '#${base0D}' --bold
        # set fish_color_autosuggestion '#${base03}'
        # set fish_color_user '#${base0E}'
        # set fish_color_host '#${base0D}'
        # set fish_color_host_remote '#${base0A}'
        # set fish_color_cancel '#${base08}'
        
        # Pager colors
        set fish_pager_color_background '#${base01}'
        set fish_pager_color_prefix '#${base0C}'
        set fish_pager_color_completion '#${base0D}'
        set fish_pager_color_description '#${base0E}'
        set fish_pager_color_selected_completion '#${base0A}' --bold
        set fish_pager_color_selected_background '#${base0A}' --bold
        set fish_pager_color_selected_description '#${base0A}' --bold
        set fish_pager_color_selected_prefix '#${base0A}' --bold
        set fish_color_valid_path

        direnv hook fish | source
        ";
      };

      fzf = {
        enableFishIntegration = true;
      };

      nix-index = { 
        enableFishIntegration = true;
      };

      starship = {
        enableFishIntegration = true;
      };

      zoxide = {
        enableFishIntegration = true;
      };

      # direnv = {
      #   enableFishIntegration = true;
      # };

    };

  };

}
