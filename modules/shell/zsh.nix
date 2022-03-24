{ config, pkgs, lib, ... }:
# vim: set ft=nix:

with lib;
let
  cfg = config.modules.shell.zsh;
in {
  
  # Shell
  options.modules.shell.zsh = {
    enable = mkEnableOption "Enable zsh";
  };

  config = mkIf cfg.enable {
    programs = {
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };

      nix-index = { 
        enable = true;
        enableZshIntegration = true;
      };

      starship = {
        enable = true;
        enableZshIntegration = true;
      };

      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };

      zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        enableSyntaxHighlighting = false;
        enableVteIntegration = true;
        dotDir = "/.config/zsh";
        autocd = true;
  
        history = {
          save = 50000;
          share = false;
          ignoreSpace = true;
        };
  
        completionInit = ''
        autoload -Uz compinit 
        if [[ -n ${config.programs.zsh.dotDir}/.zcompdump(#qN.mh+24) ]]; then
        	compinit;
        else
        	compinit -C;
        fi;
        '';
  
        initExtraFirst = ''
          zmodload zsh/zprof
          setopt nocaseglob
        '';
  
        initExtra = ''
          zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
          # Enable vim mode
          bindkey -v
          # Fix backspace in insert mode
          bindkey "^?" backward-delete-char
          bindkey '^R' history-incremental-pattern-search-backward 
          bindkey -a '/' history-incremental-pattern-search-backward 
          bindkey "^[[A" history-beginning-search-backward
          bindkey "^[[B" history-beginning-search-forward
          bindkey -a "k" history-beginning-search-backward
          bindkey -a "j" history-beginning-search-forward
          bindkey '^F' autosuggest-accept
          export KEYTIMEOUT=1
          ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)
          eval "$(direnv hook zsh)"
          zprof
        '';
  
        plugins = [ 
          {
            # Source fzf-tab
            name = "fzf-tab";
            src = pkgs.fetchFromGitHub {
              owner = "Aloxaf";
              repo = "fzf-tab";
              rev = "e8145d541a35d8a03df49fbbeefa50c4a0076bbf";
              sha256 = "h/3XP/BiNnUgQI29gEBl6RFee77WDhFyvsnTi1eRbKg=";
            };
          }
  
          {
            name = "fast-syntax-highlighting";
            src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/";
          }
  
        ];
  
        shellAliases = {
          ls = "ls --color=auto";
          la = "ls --all --color=auto";
          ll = "ls -l --color=auto";
          rm = "rm -i";
          cp = "cp -i";
          ip = "ip -c";
          perl-rename = "perl-rename --interactive";
        };

      };

    };

  };
}
