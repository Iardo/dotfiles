#!/bin/zsh

# VALUES
# --------------------
PATH_NIX=/home/$USER/.nix-profile

# SOURCE
# --------------------
if [ -e $PATH_NIX ]; then
  source $PATH_NIX/etc/profile.d/hm-session-vars.sh;
fi
