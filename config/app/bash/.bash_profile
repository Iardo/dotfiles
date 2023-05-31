#!/bin/bash
# ~/.bash_opt

# Sources ~/.profile to get its settings,
# because it isn't invoked if this files exists
if [ -r ~/.profile ]
then 
  source ~/.profile
fi

# Sources ~/.bashrc in the interactive login case,
# because it isn't sourced for interactive login shells
case $- in
  *i*)
    if [ -r ~/.bashrc ]
    then
      source ~/.bashrc
    fi;;
    *) return;;
esac
