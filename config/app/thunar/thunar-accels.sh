#!/usr/bin/env bash

# Thunar rewrites accels.scm every time it closes, so it cannot be a symlink to the repo.
# Run this with Thunar closed to bind Space to the Quick Look action.

PATH_ACCELS="$HOME/.config/Thunar/accels.scm"
PATH_ACTION='<Actions>/ThunarActions/uca-action-1790371186443457-2'

if pgrep -x thunar >/dev/null; then
  echo "Close Thunar first with: thunar -q" >&2
  exit 1
fi

mkdir -p "$(dirname "$PATH_ACCELS")"
touch "$PATH_ACCELS"
sed -i "\|gtk_accel_path \"$PATH_ACTION\"|d" "$PATH_ACCELS"
printf '(gtk_accel_path "%s" "space")\n' "$PATH_ACTION" >>"$PATH_ACCELS"
echo "Space is now bound to Quick Look in $PATH_ACCELS"
