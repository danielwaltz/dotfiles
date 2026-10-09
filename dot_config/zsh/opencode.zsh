# Inspired by andreacasarin/zsh-ask-opencode's Ctrl+O widget:
# https://github.com/andreacasarin/zsh-ask-opencode/blob/main/zsh-ask-opencode.plugin.zsh

source "$HOME/.config/dotfiles/spinner.zsh" || return 1

if (( ! ${+HOST_CONFIG} )); then
  source "$HOME/.config/dotfiles/profiles.zsh" || return 1
fi

function _dotfiles_opencode_model() {
  emulate -L zsh
  local machine_host model

  machine_host="$HOST"
  model="${HOST_CONFIG[${machine_host}.autocomplete_model]-}"
  [[ -n "$model" ]] || model="${HOST_CONFIG[${machine_host%%.*}.autocomplete_model]-}"
  if [[ -n "$model" ]]; then
    export ASK_OPENCODE_MODEL="$model"
  else
    unset ASK_OPENCODE_MODEL
  fi
}

_dotfiles_opencode_model

function ask_opencode() {
  emulate -L zsh
  setopt pipefail
  unsetopt monitor notify
  local user_prompt="$BUFFER" suggestion result_file worker_pid
  local -a model_args

  [[ -n "${user_prompt//[[:space:]]/}" ]] || return 0
  if ! command -v opencode >/dev/null || ! command -v jq >/dev/null; then
    zle -M 'Shell suggestions require opencode and jq.'
    return 1
  fi

  [[ -z "${ASK_OPENCODE_MODEL-}" ]] || model_args=(--model "$ASK_OPENCODE_MODEL")
  if ! result_file=$(command mktemp "${TMPDIR:-/tmp}/ask-opencode.XXXXXXXX"); then
    zle -M 'Could not create a temporary file for OpenCode.'
    return 1
  fi

  (
    command opencode run --format json "${model_args[@]}" \
      "Return exactly one shell command for zsh on $OSTYPE to: $user_prompt
Choose a simple, safe, reliable command. Output one line with no explanations,
code fences, or markdown. Do not execute commands or use tools." 2>&1 \
      | command jq -ersR '
        [split("\n")[] | fromjson? | select(type == "object")]
        | select(any(.[]; .type == "error") | not)
        | map(select(.type == "text") | .part.text | select(type == "string"))
        | join("")
        | gsub("\u001b\\[[0-?]*[ -/]*[@-~]"; "")
        | gsub("^\\s+|\\s+$"; "")
        | select(length > 0 and (test("[\u0000-\u001f\u007f]") | not)
                 and (startswith("```") | not))
      '
  ) >"$result_file" 2>/dev/null &
  worker_pid=$!

  _dotfiles_spinner 'Asking OpenCode...' "$worker_pid"

  if ! wait "$worker_pid" || ! suggestion=$(<"$result_file"); then
    command rm -f -- "$result_file"
    zle -M 'Could not generate a command. Your request is unchanged.'
    return 1
  fi
  command rm -f -- "$result_file"

  BUFFER="$suggestion"
  CURSOR=${#BUFFER}
  zle -M ''
  zle -R
}

zle -N ask_opencode
bindkey '^O' ask_opencode
