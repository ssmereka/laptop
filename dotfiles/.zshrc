# Configuration for zsh (not OH-My-ZSH)

# Enable Homebrew autocompletion, 
# https://formulae.brew.sh/formula/zsh-completions
if type brew &>/dev/null; then
  # This must be done before loading ZSH autocompletion using the "compinit" command.
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  # Enable ZSH autocompletion using "compdef".
  autoload -Uz compinit
  compinit
fi

# Enable autocomplete for 1Password CLI, 
# https://developer.1password.com/docs/cli/reference/commands/completion/
eval "$(op completion zsh)"; compdef _op op

# Enable autocomplete for Flux CD CLI, 
# https://fluxcd.io/flux/cmd/flux_completion_zsh/
command -v flux >/dev/null && . <(flux completion zsh)


########################################
##### ZSH Parameters and Options
########################################
# https://zsh.sourceforge.io/Doc/Release/index.html


# Parameters
# https://zsh.sourceforge.io/Doc/Release/Parameters.html#Parameters-Used-By-The-Shell

# Maximum number of events stored in the internal history list.
# Setting to a ridiculous number expressible in 32-bits to store all events.
# https://www.zsh.org/mla/users/2013/msg00691.html
HISTSIZE=999999999

# Maximum number of history events to save in the history file.
# Must match "HISTSIZE" to store all events in the history file.
SAVEHIST=999999999

# Location of file to save the history in when an interactive shell exits.
HISTFILE=~/.zsh_history

# History Options
# https://zsh.sourceforge.io/Doc/Release/Options.html#History

# Save each command’s beginning timestamp (in seconds since the epoch) and the duration 
# (in seconds) to the history file. The format of this prefixed data is: 
# ‘: <beginning time>:<elapsed seconds>;<command>’.
setopt EXTENDED_HISTORY

# When searching for history entries in the line editor, do not display duplicates of a line 
# previously found, even if the duplicates are not contiguous.
setopt HIST_FIND_NO_DUPS

# Remove command lines from the history list when the first character on the line is a space, 
# or when one of the expanded aliases contains a leading space.
# Note: Command lingers in the internal history until the next command is entered before it
#       vanishes, allowing you to briefly reuse or edit the line.
setopt HIST_IGNORE_SPACE

# Shares shell history between all sessions.
# * Imports new commands from the history file into the shell’s history list.
# * Appends typed commands to the history file.
# * Invokes "EXTENDED_HISTORY" to adds timestamps (in seconds since the epoch) 
#   and the duration (in seconds) to the history file.  The format of this 
#   prefixed data is: ‘: <beginning time>:<elapsed seconds>;<command>’.
# Warning: The settings SHARE_HISTORY, INC_APPEND_HISTORY, and INC_APPEND_HISTORY_TIME 
# are mutually exclusive. Do not use them together.
setopt SHARE_HISTORY


########################################
##### Version Managers
########################################

# Node Version Manager (NVM)
# https://github.com/nvm-sh/nvm

# Add NVM to the user's PATH.
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# Add NVM autocompletion
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


# Ruby Version Manager (RVM)
# https://rvm.io

# Add Ruby Version Manager to the user's PATH.
PATH_TO_RVM="$HOME/.rvm/bin"
if test -f "$PATH_TO_RVM"; then
    export PATH="$PATH:$PATH_TO_RVM"
    echo "Added RVM bin to the user's path \"$PATH\"."
fi


# Go Version Manager (GVM)
# https://github.com/moovweb/gvm

# Add Go Version Manager to the user's PATH
[[ -s ~/.gvm/scripts/gvm ]] && . ~/.gvm/scripts/gvm
export GOPATH="$HOME/go"
PATH="$GOPATH/bin:$PATH"


# Python Version Manager
# https://github.com/pyenv/pyenv

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

########################################
##### Alias
########################################

# Shorter Django management commands
alias pym='python manage.py'

# Navigate up the directory tree quickly
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Kubectl Aliases
alias k='kubectl'
alias kcontext='kubectl config use-context'

# Update the "Laptop" software
alias lt-update='curl -o- https://raw.githubusercontent.com/ssmereka/laptop/main/install | bash'

# Display external IP address
alias lt-myip='curl ipinfo.io/ip'


########################################
##### Methods
########################################

# Set the Kubernetes context to a specific namespace.
kns() {
  kubectl config set-context --current --namespace="$@"
}


# Laptop Methods

# Display all available aliases.
lt-alias() {
  print -- '\nAliases:\n'
  alias -Lr
  print -- '\n'
}

# Display a help menu with a list of available Laptop comands.
lt-help() {
  print -- '
  💻 Laptop Commands:

  \t🍰  lt-alias  \t list alias commands.
  \t🔄  lt-k8s    \t list kubernetes commands.
  \t🏓  lt-myip   \t displays external IP address.
  \t📥  lt-update \t update this "Laptop" software.
  \t🏥  lt-help   \t displays this help menu, can also use "help".

  🧙 Zsh:
  \t⏳  CTRL+R  \t interactive command history search. Press CTRL+R again to go to next.
  \t⏳  history \t print command history, use "history | grep <search>" to search.
  
  🧰 Tools:
  \t👻  nvm   \t https://github.com/nvm-sh/nvm
  \t💎  rvm   \t https://rvm.io
  \t🐍  pyenv \t 
  \t🦔  gvm   \t https://github.com/moovweb/gvm

  🔄 Kubernetes:
  \t k                  \t kubectl alias
  \t kcontext <context> \t change to context
  \t kns <namespace>    \t use namespace
  '
}

help() {
  lt-help
}

# Display help menu with a list of available Kubernetes commands.
lt-k8s() {
  print -- '
  🔄 Kubernetes Commands
  \t k                  \t kubectl alias
  \t kcontext <context> \t change to context
  \t kns <namespace>    \t use namespace
  '
}
