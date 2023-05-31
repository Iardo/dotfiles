#!/bin/bash
# ~/.bash_logout

# Clears duplicates from ~/.bash_history
bash_history_file=$(mktemp "$USER"_bash_historyXXXXXX)
tac "$HOME/.bash_history" | awk '!x[$0]++' | tac >"$bash_history_file"
mv "$bash_history_file" "$HOME/.bash_history"
unset bash_history_file
