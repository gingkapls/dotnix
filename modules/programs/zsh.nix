{ config, pkgs, nix-colors, ... }:

with config.colorscheme.colors; {
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

  home.sessionVariables = {
    BEMENU_OPTS = "-H27 --fn 'Inter Medium 14' --nb '#${base00}' --nf '#${base03}' --fb '#${base00}' --ff '#${base08}' --hb '#${base00}' --hf '#${base08}' --tb '#${base00}' --tf '#${base05}' --scb '#${base00}' --scf '#${base05}'  --no-overlap --prompt= ";

    LS_COLORS = "rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"; # this is so ugly ;-;
  };

}
