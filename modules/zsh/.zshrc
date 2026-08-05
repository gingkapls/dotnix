typeset -U path cdpath fpath manpath
for profile in ${(z)NIX_PROFILES}; do
  fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
done

# Add plugin directories to PATH and fpath
plugin_dirs=(
  fzf-tab fast-syntax-highlighting
)
for plugin_dir in "${plugin_dirs[@]}"; do
  path+="/home/gin/.config/zsh/plugins/$plugin_dir"
  fpath+="/home/gin/.config/zsh/plugins/$plugin_dir"
  for plugin_fpath_dir in \
    "$plugin_dir/share/zsh/plugins/$plugin_dir" \
    "$plugin_dir/share/zsh/site-functions" \
    "$plugin_dir/share/zsh/vendor-completions"; do
    [[ -d "/home/gin/.config/zsh/plugins/$plugin_fpath_dir" ]] && fpath+="/home/gin/.config/zsh/plugins/$plugin_fpath_dir"
  done
done
unset plugin_dir plugin_dirs plugin_fpath_dir


autoload -Uz compinit 
if [[ -n /home/gin/.config/zsh/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

ZSH_AUTOSUGGEST_STRATEGY=(history)


eval "$(zoxide init zsh )"

# Source plugins
plugins=(
  fzf-tab/fzf-tab.plugin.zsh
  fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
)
for plugin in "${plugins[@]}"; do
  [[ -f "/home/gin/.config/zsh/plugins/$plugin" ]] && source "/home/gin/.config/zsh/plugins/$plugin"
done
unset plugin plugins

# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="50000"

HISTFILE="/home/gin/.config/zsh/zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

if [[ $options[zle] = on ]]; then
  source <(fzf --zsh)
fi

# Set shell options
set_opts=(
  HIST_FCNTL_LOCK HIST_IGNORE_DUPS HIST_IGNORE_SPACE autocd NO_APPEND_HISTORY
  NO_EXTENDED_HISTORY NO_HIST_EXPIRE_DUPS_FIRST NO_HIST_FIND_NO_DUPS
  NO_HIST_IGNORE_ALL_DUPS NO_HIST_SAVE_NO_DUPS NO_SHARE_HISTORY
)
for opt in "${set_opts[@]}"; do
  setopt "$opt"
done
unset opt set_opts

setopt nocaseglob
setopt PROMPT_SUBST
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
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
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help

PROMPT='
${PWD/\/home\/gin/~}
; '

eval "$(direnv hook zsh)"

alias -- cp='cp -i'
alias -- ip='ip -c'
alias -- la='ls --all --color=auto'
alias -- ll='ls -l --color=auto'
alias -- ls='ls --color=auto'
alias -- perl-rename='perl-rename --interactive'
alias -- rm='rm -i'
