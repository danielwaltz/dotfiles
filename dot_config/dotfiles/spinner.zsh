typeset -ga DOTFILES_SPINNER_ICONS=("⣷" "⣯" "⣟" "⡿" "⢿" "⣻" "⣽" "⣾")
typeset -g DOTFILES_SPINNER_INTERVAL=0.08
typeset -g DOTFILES_SPINNER_COLOR=yellow

_dotfiles_spinner() {
  emulate -L zsh
  local label="$1" process_id="$2" index=1 spinner_start
  local saved_postdisplay="${POSTDISPLAY-}"
  local -i in_line_editor=0 cursor_hidden=0
  zle && in_line_editor=1

  {
    while kill -0 "$process_id" 2>/dev/null; do
      if [[ -t 1 ]] && (( ! cursor_hidden )); then
        print -n -r -- $'\e[?25l'
        cursor_hidden=1
      fi
      if (( in_line_editor )); then
        POSTDISPLAY=$'\n'"${DOTFILES_SPINNER_ICONS[index]} $label"
        spinner_start=$(( ${#BUFFER} + 1 ))
        region_highlight=( "${(@)region_highlight:#*memo=dotfiles-spinner}" \
          "$spinner_start $(( spinner_start + 1 )) fg=$DOTFILES_SPINNER_COLOR memo=dotfiles-spinner" )
        zle -R
        (( ! cursor_hidden )) || print -n -r -- $'\e[?25l'
      else
        print -n -P -r -- $'\r\e[2K'"%F{${DOTFILES_SPINNER_COLOR}}${DOTFILES_SPINNER_ICONS[index]}%f"
        print -n -r -- " $label"
      fi
      (( index = index % ${#DOTFILES_SPINNER_ICONS} + 1 ))
      sleep "$DOTFILES_SPINNER_INTERVAL"
    done

  } always {
    if (( in_line_editor )); then
      POSTDISPLAY="$saved_postdisplay"
      region_highlight=( "${(@)region_highlight:#*memo=dotfiles-spinner}" )
      zle -R
    else
      print -n -r -- $'\r\e[2K'
    fi
    (( ! cursor_hidden )) || print -n -r -- $'\e[?25h'
  }
}
