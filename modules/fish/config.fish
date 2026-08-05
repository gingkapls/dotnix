status is-login; and begin
    # Login shell initialisation
    if test -e $HOME/.nix-profile/etc/profile.d/nix.sh
        source $HOME/.nix-profile/etc/profile.d/nix.fish
    end

end

status is-interactive; and begin
    # Abbreviations

    # Aliases
    alias cp 'cp -i'
    alias mv 'mv -i'
    alias perl-rename 'perl-rename -i'
    alias rm 'rm -i'

    # Interactive shell initialisation
    fzf --fish | source

    set -g fish_greeting
    fish_vi_key_bindings

    direnv hook fish | source
    zoxide init fish | source

    if test "$TERM" != dumb
        starship init fish | source
    end
end
