# Configuration for zsh (not OH-My-ZSH)

# Enable Homebrew autocompletion
if type brew &>/dev/null; then
  # This must be done before loading ZSH autocompletion using the "compinit" command.
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Enable ZSH autocompletion using "compdef".
autoload -Uz compinit
compinit

# Autocomplete for 1Password CLI
eval "$(op completion zsh)"; compdef _op op


## Node Version Manager (NVM)

# Add Node Version Manager to the user's PATH, see https://github.com/nvm-sh/nvm
PATH_TO_NVM="$HOME/.nvm"
if test -f "$PATH_TO_NVM"; then
    export PATH="$PATH:$PATH_TO_NVM"
    echo "Added NVM to the user's path \"$PATH\"."
fi
# Load Node Version Manager
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# Add bash auto completion for Node Version Manager
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"


## Ruby Version Manager (RVM)

# Add Ruby Version Manager to the user's PATH, see https://rvm.io
PATH_TO_RVM="$HOME/.rvm/bin"
if test -f "$PATH_TO_RVM"; then
    export PATH="$PATH:$PATH_TO_RVM"
    echo "Added RVM bin to the user's path \"$PATH\"."
fi

## Bash Alias

alias pym='python manage.py'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'


## Methods

help() {
  echo "\nAvailable Aliases:"
  alias -Lr
  echo ""
}
