#!/bin/zsh

# PATH
# export PATH=$PATH:$HOME/scripts/iardo/
# export PATH=$PATH:$HOME/scripts/third-party/
# export S_BIN_PATH=$HOME/scripts/iardo/
# export MANPATH=$MANPATH:/usr/local/man

# CONFIG
# --------------------
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ALIAS
# --------------------
alias uuid='uuidgen | tr "[:upper:]" "[:lower:]"'
alias npml='npm list -g --depth=0'
alias phpm='php -m'
alias pipl='pip freeze'
alias rubl='gem query --local'

# Deno
# --------------------
if [ -e ~/.deno/env ]; then source ~/.deno/env; fi

# Go
# --------------------
export GOPATH=$HOME/.config/go

# PHP
# --------------------
export COMPOSER_MEMORY_LIMIT=-1

# Python
# --------------------
if [[ "$OSTYPE" == darwin* ]]; then
  alias python=/usr/local/bin/python3
  alias pip=/usr/local/bin/pip3
else
  alias python=python3
  alias pip=pip3
fi

# Zellij
# --------------------
dev() {
  local session_name="dev-${PWD:t}"
  if [[ -n "$ZELLIJ" ]]; then
    zellij action new-tab --layout dev --cwd "$PWD" --name main
  else
    zellij attach --create "$session_name" options --default-layout dev
  fi
}
