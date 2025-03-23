#!/bin/bash
# ~/.bashrc

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# Completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# PATH
# /usr/local/bin need to be before /usr/bin if you want to use the Homebrew version over the default system version.
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/sbin"

# ---------------------------------------------------------------------------- #
# CONFIG
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

# ---------------------------------------------------------------------------- #
# INCLUDES
if [ -e ~/.bash_alias ]; then source ~/.bash_alias; fi
if [ -e ~/.bash_cfg ];   then source ~/.bash_cfg; fi
if [ -e ~/.bash_dev ];   then source ~/.bash_dev; fi
if [ -e ~/.bash_opt ];   then source ~/.bash_opt; fi
if [ -e ~/.bash_out ];   then source ~/.bash_out; fi
