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

# Go
# --------------------
export GOPATH=$HOME/.config/go

# PHP
# --------------------
export COMPOSER_MEMORY_LIMIT=-1

# Python
# --------------------
# ensure brew to use the correct versions of python.
alias python=/usr/local/bin/python3
alias pip=/usr/local/bin/pip3
