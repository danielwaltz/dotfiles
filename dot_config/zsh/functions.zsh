function findpkg() {
  local dir
  dir=$(realpath "${2:-.}")
  grep -rn "\"$1\"" --include="package.json" \
    --exclude-dir=node_modules \
    --exclude-dir=dist \
    --exclude-dir=.next \
    --exclude-dir=.nuxt \
    --exclude-dir=.output \
    --exclude-dir=build \
    --exclude-dir=out \
    "$dir" \
    | sed -E 's|(.+):.*"([^"]+)": *"([^"]+)".*|\1\t\2\t\3|' \
    | sort \
    | while IFS=$'\t' read -r file_path pkg ver; do
      echo -e "\033[36m$file_path\033[0m → \033[32m$pkg\033[0m@\033[33m$ver\033[0m"
      done
}

function update() {
  echo '\e[32m\xee\x97\xbc chezmoi'
  chezmoi update --apply

  echo '\e[32m\xee\x9e\x95 antidote'
  antidote update

  if command -v apt &> /dev/null; then
    echo '\e[32m\xee\x9d\xbd apt'
    sudo apt update && sudo apt upgrade
  fi

  if command -v dnf &> /dev/null; then
    echo '\e[32m\xee\x9f\x99 dnf'
    sudo dnf upgrade
  fi

  if command -v pacman &> /dev/null; then
    if command -v paru &> /dev/null; then
      echo '\e[32m\xee\x9c\xb2 paru'
      paru -Syu
    else
      echo '\e[32m\xee\x9c\xb2 pacman'
      sudo pacman -Syu
    fi
  fi

  if command -v flatpak &> /dev/null; then
    echo '\e[32m\xef\x86\xb2 flatpak'
    sudo flatpak update --system -y && flatpak update --user -y
  fi

  if command -v mas &> /dev/null; then
    echo '\e[32m\xee\x9c\x91 mas'
    mas upgrade
  fi

  echo '\e[32m\xef\x83\xbc brew'
  brew update && brew upgrade -y && brew upgrade -y --cask

  echo '\e[32m\xef\x86\xb2 mise'
  mise upgrade && mise prune -y
}

function cleanup() {
  if command -v apt &> /dev/null; then
    echo '\e[32m\xee\x9d\xbd apt'
    sudo apt autoremove --purge
  fi

  if command -v dnf &> /dev/null; then
    echo '\e[32m\xee\x9f\x99 dnf'
    sudo dnf autoremove
  fi

  if command -v pacman &> /dev/null; then
    if command -v paru &> /dev/null; then
      echo '\e[32m\xee\x9c\xb2 paru'
      paru -Rsn $(paru -Qtdq)
    else
      echo '\e[32m\xef\x8c\x83 pacman'
      sudo pacman -Rns $(pacman -Qtdq)
    fi

    paccache -r
  fi

  if command -v flatpak &> /dev/null; then
    echo '\e[32m\xef\x86\xb2 flatpak'
    flatpak uninstall --unused -y
  fi

  if command -v docker &> /dev/null; then
    echo '\e[32m\xee\x9e\xb0 docker'
    docker system prune -f
  fi

  echo '\e[32m\xef\x83\xbc brew'
  brew cleanup

  echo '\e[32m\xef\x86\xb2 mise'
  mise prune -y
}
