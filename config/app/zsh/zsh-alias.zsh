#!/bin/zsh

# ALIAS
# --------------------
# COMMANDS
alias df="df --human-readable --print-type"
alias hl="hyprctl"
alias ll="ls -lah"
alias ls="ls -lah"
alias lsblk="lsblk -o NAME,TYPE,SIZE,MODEL,MOUNTPOINTS"
# CONFIG
alias config-hyprland="$EDITOR ~/.config/hypr/hyprland.conf"
alias config-nix="sudo $EDITOR /etc/nixos/configuration.nix"
alias config-waybar-css="$EDITOR ~/.config/waybar/style.css"
alias config-waybar="$EDITOR ~/.config/waybar/config.jsonc"
# SYSTEM
alias update-udev="sudo udevadm control --reload-rules && sudo udevadm trigger"
# SERVICES
alias service-errors="journalctl -f"
alias service-status="systemctl status"
# NIX
alias nix-shell="nix-shell --command zsh"
# GTK
alias dbeaver="GTK_THEME=elementary:light dbeaver"
alias kompare="GTK_THEME=elementary:light kompare"
alias waybar-debug="GTK_DEBUG=interactive waybar"
