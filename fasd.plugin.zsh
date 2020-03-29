if (( ! $+commands[fasd] )); then
  source "${0:h}/ext/fasd/fasd" || return 1
fi

fasd_cache="${HOME}/.cache/.fasd-init-cache"
if [[ "$commands[fasd]" -nt "$fasd_cache" || ! -s "$fasd_cache" ]]; then
  fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install \
    zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

alias v='f -e "$EDITOR"'
alias o='a -e xdg-open'
alias j='zz'
