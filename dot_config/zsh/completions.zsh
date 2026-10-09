if (( $+commands[pnpm] )); then
  source <(pnpm completion zsh)
fi

if (( $+commands[bun] )); then
  source <(SHELL=zsh bun completions)
fi

_dotfiles_package_json() {
  local package_dir=$PWD
  while [[ ! -f "$package_dir/package.json" ]]; do
    [[ $package_dir == / ]] && return 1
    package_dir=${package_dir:h}
  done

  print -r -- "$package_dir/package.json"
}

_dotfiles_package_scripts() {
  local package_json=$(_dotfiles_package_json) || return 1
  local script_names
  script_names=$(jq -r '(.scripts // {}) | keys[]' "$package_json" 2>/dev/null) || return 1
  [[ -n $script_names ]] || return 1

  local -a scripts=( "${(@f)script_names}" )
  local -a expl
  _wanted scripts expl 'package scripts' compadd -a scripts
}

_dotfiles_package_dependencies() {
  local package_json=$(_dotfiles_package_json) || return 1
  local names
  names=$(jq -r '((.dependencies // {}) + (.devDependencies // {}) +
    (.optionalDependencies // {}) + (.peerDependencies // {})) | keys[]' \
    "$package_json" 2>/dev/null) || return 1
  [[ -n $names ]] || return 1
  local -a packages=( "${(@f)names}" ) expl
  _wanted dependencies expl 'project dependencies' compadd -a packages
}

_dotfiles_registry_packages() {
  (( ${#PREFIX} >= 2 )) || return 1
  [[ $PREFIX != (./*|../*|/*|*:*) && ${PREFIX#@} != *@* ]] || return 1

  local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/package-search/npm-v2"
  local cache_key
  cache_key=$(jq -rn --arg prefix "$PREFIX" '$prefix | @uri') || return 1
  local cache_file="$cache_dir/$cache_key"
  local -a fresh=( "$cache_file"(Nmh-1) )
  local names
  if (( $#fresh )); then
    names=$(<"$cache_file")
  else
    names=$(command curl -fsSG --connect-timeout 0.3 --max-time 0.7 \
      'https://registry.npmjs.org/-/v1/search' \
      --data-urlencode "text=$PREFIX" --data 'size=250' 2>/dev/null |
      jq -r --arg prefix "$PREFIX" '
        [.objects[]? | select(.package.name | startswith($prefix))]
        | sort_by(-(.downloads.weekly // 0), -(.searchScore // .score.final // 0), .package.name)
        | .[].package.name' 2>/dev/null)
    if [[ -n $names ]]; then
      mkdir -p "$cache_dir"
      print -r -- "$names" >| "$cache_file"
    elif [[ -r $cache_file ]]; then
      names=$(<"$cache_file")
    fi
  fi
  [[ -n $names ]] || return 1
  local -a packages=( "${(@f)names}" ) expl
  _wanted -V packages expl 'registry packages' compadd -a packages
}

_dotfiles_npm_completion() {
  local candidates
  candidates=$(COMP_CWORD=$((CURRENT-1)) COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" \
    npm completion -- "${words[@]}" 2>/dev/null) || return 1
  [[ -n $candidates ]] && compadd -- "${(@f)candidates}"
}

_dotfiles_package_completion() {
  if [[ ${words[2]} == (run|run-script) && CURRENT -eq 3 && $PREFIX != -* ]]; then
    _dotfiles_package_scripts
    return $?
  fi

  if [[ ${words[1]} == (yarn|pnpm|bun) && CURRENT -eq 2 && $PREFIX != -* ]]; then
    _dotfiles_package_scripts
  fi

  if (( CURRENT >= 3 )) && [[ $PREFIX != -* && ${words[CURRENT-1]} != \
    (--filter|--registry|--cwd|--dir|-C|--cache-folder) ]]; then
    case "${words[1]}:${words[2]}" in
      (npm|pnpm|bun):(install|i|add)|yarn:add)
        _dotfiles_package_dependencies
        _dotfiles_registry_packages
        _files -/
        return 0
        ;;
      (npm|pnpm|yarn):(remove|rm|uninstall|un|update|upgrade|up)|bun:(remove|rm|update))
        _dotfiles_package_dependencies
        return $?
        ;;
    esac
  fi

  case ${words[1]} in
    npm) _dotfiles_npm_completion ;;
    pnpm) (( $+functions[_pnpm_completion] )) && _pnpm_completion ;;
    yarn) autoload -Uz _yarn; _yarn ;;
    bun) autoload -Uz _bun; _bun ;;
  esac
}
compdef _dotfiles_package_completion npm yarn pnpm bun

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
zstyle ':completion:*:warnings' format ''
zstyle ':completion:*' list-colors ${(s.:.)${LS_COLORS:-'di=1;34:ln=1;36:ex=1;32:pi=33:so=35:bd=33:cd=33:or=1;31'}} 'no=38;5;8' 'fi=38;5;8' 'ma=1;37;44'
zstyle ':autocomplete:*:*' list-lines 8
