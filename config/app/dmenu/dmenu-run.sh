#!/usr/bin/env bash

# dmenu has no config file, so its colors and font live here
exec dmenu_run \
  -fn 'Iosevka Custom:size=12' \
  -nb '#000000' \
  -nf '#FFFFFF' \
  -sb '#000000' \
  -sf '#b8ff3d'
