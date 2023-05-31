#!/bin/zsh

# HISTORY
# --------------------
# Atuin is the main history. Without it, failed commands stay in the session
# history (up arrow) but are not written to $HISTFILE.
autoload -U add-zsh-hook

last_command_line=""

history_hold_command() {
  last_command_line="${1%%$'\n'}"
  return 2
}

history_save_if_succeeded() {
  local exit_code=$?
  if (( exit_code == 0 )) && [[ -n $last_command_line ]]; then
    print -sr -- "$last_command_line"
  fi
  last_command_line=""
}

# https://github.com/atuinsh/atuin
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh)"
else
  add-zsh-hook zshaddhistory history_hold_command
  add-zsh-hook precmd history_save_if_succeeded
fi
