if (( ! ${+PROFILE_CONFIG} )); then
  source "$HOME/.config/dotfiles/profiles.zsh" || return 1
fi

function _dotfiles_opencode_model() {
  emulate -L zsh
  local profile="$DEFAULT_PROFILE" key candidate directory
  local current_directory="${PWD:A}" matched_length=0

  for key in "${(@k)PROFILE_CONFIG}"; do
    [[ "$key" == *.directory ]] || continue
    candidate="${key%.directory}"
    directory="${PROFILE_CONFIG[$key]}"
    directory="${directory:A}"
    if [[ "$current_directory" == "$directory" ||
          "$current_directory" == "${directory%/}/"* ]]; then
      if (( ${#directory} > matched_length )); then
        profile="$candidate"
        matched_length=${#directory}
      fi
    fi
  done

  export ASK_OPENCODE_MODEL="${PROFILE_CONFIG[${profile}.autocomplete_model]}"
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _dotfiles_opencode_model
_dotfiles_opencode_model
