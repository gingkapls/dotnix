{ inputs, config, pkgs, lib, ... }:
# vim: set ft=nix:

with lib;
let
  cfg = config.modules.shells.zsh;
in {
  
  # Shell
  options.modules.shells.zsh = {
    enable = mkEnableOption "Enable zsh";
  };

  config = mkIf cfg.enable {
    programs = {
      zsh = {
        enable = true;
        autosuggestion.enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = false;
        enableVteIntegration = true;
        dotDir = ".config/zsh";
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

  
        ## this causes ridiculously long load times for some reason
        # initExtraFirst = ''
        #   # zmodload zsh/zprof
        #   setopt nocaseglob
        #   setopt PROMPT_SUBST
        # '';
  
        initExtra = ''
          setopt nocaseglob
          setopt PROMPT_SUBST
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
          
          # Zsh run-help function
          autoload -Uz run-help
          (( ''${+aliases[run-help]} )) && unalias run-help
          alias help=run-help

          eval "$(direnv hook zsh)"
          PROMPT='
          ''${PWD/\/home\/gin/~}
          ; '
          # zprof
        '';
  
        plugins = [ 
          {
            name = "fzf-tab";
            src = inputs.fzf-tab.outPath;
            file = "fzf-tab.plugin.zsh";
          }
  
          {
            name = "fast-syntax-highlighting";
            src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
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

      starship = {
        enableZshIntegration = false;
      };

    };

  };
}
