{ config, pkgs, ... }:

{
  # Shell
  programs = {

    nix-index = { 
      enable = true;
      enableZshIntegration = true;
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };
  
    bash.enable = true;
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      enableVteIntegration = true;
      dotDir = "/.config/zsh";
      autocd = true;

      history = {
        save = 50000;
        share = false;
        ignoreSpace = true;
      };

      completionInit = ''
        zstyle ':completion:*' menu select
        zstyle ':completion:*' rehash true
        zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
        zstyle ':completion:*' matcher-list "" \
         'm:{a-z\-}={A-Z\_}' \
          'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
          'r:|?=** m:{a-z\-}={A-Z\_}'
        autoload -U compinit && compinit
      '';

      initExtraFirst = ''
        setopt nocaseglob
      '';

      initExtra = ''
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
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
      '';

      shellAliases = {
        ls = "ls --color=auto";
        la = "ls --all --color=auto";
        ll = "ls -l --color=auto";
        rm = "rm -i";
        cp = "cp -i --reflink=auto";
        ip = "ip -c";
        perl-rename = "perl-rename --interactive";
      };

    };

  };
}
