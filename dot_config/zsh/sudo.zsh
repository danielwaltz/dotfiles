if (( ! ${+SUDO_PASS_HOSTS} )); then
  source "$HOME/.config/dotfiles/sudo.zsh" || return 1
fi

typeset -g DOTFILES_SUDO_ASKPASS_ENABLED=0
if _dotfiles_sudo_secret_uri >/dev/null; then
  DOTFILES_SUDO_ASKPASS_ENABLED=1
  export SUDO_ASKPASS="$HOME/.local/bin/sudo-askpass"
fi

function sudo() {
  emulate -L zsh
  local option flags flag
  local -i index=1 position

  if (( ! DOTFILES_SUDO_ASKPASS_ENABLED )); then
    command sudo "$@"
    return $?
  fi

  # Respect explicit authentication options. Stop at the command so its flags
  # are never interpreted as sudo options, and skip values of sudo options.
  while (( index <= $# )); do
    option="${argv[index]}"
    case "$option" in
      --askpass|--stdin|--non-interactive)
        command sudo "$@"
        return $?
        ;;
      --auth-type|--close-from|--login-class|--chdir|--group|--host|--prompt|--chroot|--role|--command-timeout|--type|--other-user|--user)
        (( index += 2 ))
        continue
        ;;
      --) break ;;
      --*) (( index++ )); continue ;;
      -?*)
        flags="${option#-}"
        for (( position = 1; position <= ${#flags}; position++ )); do
          flag="${flags[position]}"
          case "$flag" in
            A|S|n)
              command sudo "$@"
              return $?
              ;;
            a|C|c|D|g|h|p|R|r|T|t|U|u)
              # A value can follow the option directly or be the next argument.
              (( position < ${#flags} )) || (( index++ ))
              break
              ;;
          esac
        done
        ;;
      *) break ;;
    esac
    (( index++ ))
  done

  command sudo -A "$@"
}
