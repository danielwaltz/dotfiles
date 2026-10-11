[[ -n $GHOSTTY_RESOURCES_DIR ]] && source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"
