if (( $+commands[pnpm] )); then
  source <(pnpm completion zsh)
fi

_dotfiles_npm_completion() {
  if [[ ${words[2]} == (run|run-script) && CURRENT -eq 3 && $PREFIX != -* ]]; then
    local package_dir=$PWD
    while [[ ! -f "$package_dir/package.json" ]]; do
      [[ $package_dir == / ]] && return 1
      package_dir=${package_dir:h}
    done

    local script_names
    script_names=$(jq -r '(.scripts // {}) | keys[]' "$package_dir/package.json" 2>/dev/null) || return 1
    [[ -n $script_names ]] || return 1

    local -a scripts=( "${(@f)script_names}" )
    local -a expl
    _wanted scripts expl 'package scripts' compadd -a scripts
  else
    local candidates
    candidates=$(COMP_CWORD=$((CURRENT-1)) COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" \
      npm completion -- "${words[@]}" 2>/dev/null) || return 1
    [[ -n $candidates ]] && compadd -- "${(@f)candidates}"
  fi
}
compdef _dotfiles_npm_completion npm

#### autocomplete
add-zsh-hook -d precmd ensure-compinit-during-precmd
unfunction compinit_deferred queued_compcmd
unset __compcmd_queue
bindkey '^I' complete-word
bindkey '^[[Z' expand-word
bindkey '^[[A' up-line-or-search
bindkey '^[OA' up-line-or-search
bindkey '^[[B' down-line-or-select
bindkey '^[OB' down-line-or-select
bindkey -M menuselect '^M' .accept-line
bindkey -M menuselect '^J' .accept-line
zstyle ':completion:*:descriptions' format '%F{green}%B◆ %d%b%f'
zstyle ':completion:*:warnings' format '%F{yellow}%d%f'
zstyle ':completion:*' list-colors ${(s.:.)${LS_COLORS:-'di=1;34:ln=1;36:ex=1;32:pi=33:so=35:bd=33:cd=33:or=1;31'}} 'no=38;5;8' 'fi=38;5;8' 'ma=1;37;44'
zstyle ':autocomplete:*:*' list-lines 8
