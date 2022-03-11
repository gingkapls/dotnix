{ config, pkgs, nix-colors, ... }:
# vim: set ft=nix:

with config.colorscheme.colors; {
  # Shell
  programs = {

    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = false;
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
      ];

      shellAliases = {
        ls = "ls --color=auto";
        la = "ls --all --color=auto";
        ll = "ls -l --color=auto";
        rm = "rm -i";
        cp = "cp -i --reflink=auto";
        ip = "ip -c";
        perl-rename = "perl-rename --interactive";
        gen-modules = "pushd $HOME/.dotnix/modules && printf \"%s\n\n%s\n  %s\n%s\n  %s\n%s\n\" \"{ config, ...}:\" \"{\" \"imports = [\" \"$(find ./*/* -type f -name \"*.nix\" -printf \"    %p\n\")\" \"];\" \"}\"  > ./module-list.nix && popd";
      };
    };
  };

}
