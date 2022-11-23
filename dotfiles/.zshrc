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

## GO
[[ -s ~/.gvm/scripts/gvm ]] && . ~/.gvm/scripts/gvm
export GOPATH="$HOME/go"
PATH="$GOPATH/bin:$PATH"


## Bash Alias
alias pym='python manage.py'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

## Kubernetes Alias
alias k='kubectl'
alias kcontext='kubectl config use-context'

## Laptop
alias laptop-update='curl -o- https://raw.githubusercontent.com/ssmereka/laptop/main/install | bash'

## Utility Alias
alias myip='curl ipinfo.io/ip'

## Methods

help() {
  echo "\n\nAvailable Aliases:\n"
  alias -Lr
  echo "\n"
}
