#!/bin/zsh

# PLUGINS
# --------------------
PATH_PLUGINS=$PATH_CONFIG/plugins
plugins=(
  davidde/git
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-syntax-highlighting
)

for plugin in $plugins; do
  if [[ ! -d $PATH_PLUGINS/$plugin ]]; then
    mkdir -p $PATH_PLUGINS/${plugin%/*}
    git clone --depth 1 --recursive https://github.com/$plugin.git $PATH_PLUGINS/$plugin
  fi
  for initscript in ${plugin#*/}.zsh ${plugin#*/}.plugin.zsh ${plugin#*/}.sh; do
    if [[ -f $PATH_PLUGINS/$plugin/$initscript ]]; then
      source $PATH_PLUGINS/$plugin/$initscript
      break
    fi
  done
done

# CLEANUP
# --------------------
unset plugins
unset plugin
unset initscript

# CONFIGS
# --------------------
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_HIGHLIGHT_HIGHLIGHTERS+=()
