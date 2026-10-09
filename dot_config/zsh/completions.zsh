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

  local -a match_options=( -M 'r:|=* l:|=*' )
  if (( $+commands[fzf] )); then
    script_names=$(print -r -- "$script_names" |
      FZF_DEFAULT_OPTS= FZF_DEFAULT_OPTS_FILE= command fzf --filter "$PREFIX$SUFFIX") || return 1
    match_options=( -U )
  fi

  local -a scripts=( "${(@f)script_names}" )
  local -A script_commands
  local script_name script_command
  while IFS=$'\t' read -r script_name script_command; do
    script_commands[$script_name]=$script_command
  done < <(jq -r '(.scripts // {}) | to_entries[] |
    "\(.key)\t\(.value | gsub("[\\r\\n\\t]"; " "))"' "$package_json")

  local -a entries
  for script_name in "${scripts[@]}"; do
    entries+=( "${${script_name//\\/\\\\}//:/\\:}:${script_commands[$script_name]}" )
  done
  _describe -V -t scripts 'package scripts' entries "${match_options[@]}"
}

_dotfiles_package_dependencies() {
  local package_json=$(_dotfiles_package_json) || return 1
  local names
  names=$(jq -r '((.dependencies // {}) + (.devDependencies // {}) +
    (.optionalDependencies // {}) + (.peerDependencies // {})) | keys[]' \
    "$package_json" 2>/dev/null) || return 1
  [[ -n $names ]] || return 1
  local -a packages=( "${(@f)names}" ) expl
  _wanted dependencies expl 'project dependencies' compadd -ld packages -a packages
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
  _wanted -V packages expl 'registry packages' compadd -ld packages -a packages
}

_dotfiles_npm_completion() {
  local candidates
  candidates=$(COMP_CWORD=$((CURRENT-1)) COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" \
    npm completion -- "${words[@]}" 2>/dev/null) || return 1
  [[ -n $candidates ]] || return 1
  local -a matches=( "${(@f)candidates}" )
  compadd -ld matches -a matches
}

_dotfiles_pnpm_completion() {
  local -a reply
  reply=( "${(@f)$(COMP_CWORD=$((CURRENT-1)) COMP_LINE="$BUFFER" \
    COMP_POINT="$CURSOR" SHELL=zsh pnpm completion-server -- "${words[@]}" 2>/dev/null)}" )
  compadd -ld reply -a reply
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
    pnpm) _dotfiles_pnpm_completion ;;
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
_dotfiles_dismiss_completions() {
  if (( $+functions[zasync] )); then
    zasync cancel wait
    zasync cancel complete
  fi
  _lastcomp[list]=''
  zle -Rc
}
zle -N dotfiles-dismiss-completions _dotfiles_dismiss_completions
bindkey '^[' dotfiles-dismiss-completions
bindkey -M menuselect '^[' dotfiles-dismiss-completions
zstyle ':autocomplete:dotfiles-dismiss-completions:*' ignore yes
_dotfiles_completion_or_history() {
  if [[ -n ${BUFFER//[[:space:]]/} && -n ${_lastcomp[list]} ]] &&
      (( ${_lastcomp[nmatches]:-0} > 0 )); then
    zle menu-select -w
  else
    _lastcomp[list]=''
    case $WIDGET in
      dotfiles-up) zle .up-line-or-history ;;
      dotfiles-down) zle .down-line-or-history ;;
    esac
  fi
}
zle -N dotfiles-up _dotfiles_completion_or_history
zle -N dotfiles-down _dotfiles_completion_or_history
bindkey '^[[A' dotfiles-up
bindkey '^[OA' dotfiles-up
bindkey '^[[B' dotfiles-down
bindkey '^[OB' dotfiles-down
bindkey -M menuselect '^[[A' up-line-or-history '^[OA' up-line-or-history
bindkey -M menuselect '^[[B' down-line-or-history '^[OB' down-line-or-history
bindkey '^[[D' backward-char '^[OD' backward-char
bindkey '^[[C' forward-char '^[OC' forward-char
bindkey -M menuselect '^[[D' .backward-char '^[OD' .backward-char
bindkey -M menuselect '^[[C' .forward-char '^[OC' .forward-char
bindkey -M menuselect '^M' .accept-line
bindkey -M menuselect '^J' .accept-line
zstyle ':completion:*' format ''
zstyle ':completion:(list-choices|complete-word):*:bun::descriptions' format ''
zstyle ':completion:(list-choices|complete-word):*:bun-grouped:*' format ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-grouped no
zstyle ':completion:*' list-separator '--'
zstyle ':completion:*:warnings' format ''
() {
  local dim_text='0;2'
  local script_name_gray='0;38;5;245'
  local default_text_gray=$script_name_gray
  local file_text=$dim_text
  local directory_blue='0;34'
  local symlink_cyan='0;36'
  local executable_green='0;32'
  local pipe_yellow='0;33'
  local socket_magenta='0;35'
  local device_yellow='0;33'
  local broken_symlink_red='0;31'

  local selection_text_dark_gray=236
  local selection_background_cyan=6
  local selection_style="0;38;5;${selection_text_dark_gray};48;5;${selection_background_cyan}"
  local footer_text_gray=245
  local footer_style="%k%F{${footer_text_gray}}"
  local more_prompt="${footer_style}(MORE)%f%k"
  local selection_footer_prompt="${footer_style}line %l %p%f%k"
  local reset_colors=$'\e[0m'

  zstyle ':completion:*' list-colors \
    "=(#b)([^[:space:]]##)[[:blank:]]##(--)[[:blank:]]##(*)=${dim_text}=${script_name_gray}=${dim_text}=${dim_text}" \
    "no=${default_text_gray}" \
    "fi=${file_text}" \
    "di=${directory_blue}" \
    "ln=${symlink_cyan}" \
    "ex=${executable_green}" \
    "pi=${pipe_yellow}" \
    "so=${socket_magenta}" \
    "bd=${device_yellow}" \
    "cd=${device_yellow}" \
    "or=${broken_symlink_red}" \
    "ma=${selection_style}" \
    "ec=${reset_colors}"

  zstyle ':completion:*:default' select-prompt "$selection_footer_prompt"

  local widget='.autocomplete:async:list-choices:completion-widget'
  local original='%F{0}%K{12}(MORE)%f%k'
  local previous='%F{236}%K{cyan}(MORE)%f%k'
  local previous_indexed='%F{236}%K{6}(MORE)%f%k'
  if (( $+functions[$widget] )); then
    functions[$widget]=${functions[$widget]//"$original"/"$more_prompt"}
    functions[$widget]=${functions[$widget]//"$previous"/"$more_prompt"}
    functions[$widget]=${functions[$widget]//"$previous_indexed"/"$more_prompt"}
  fi
}
zstyle ':autocomplete:*:*' list-lines 8
zstyle -e ':autocomplete:list-choices:*' ignored-input '
  if (( CURRENT == 1 )); then
    reply=( "*" )
  else
    reply=()
  fi
'
