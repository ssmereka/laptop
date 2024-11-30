# User profile for interactive zsh(1) shells.

# The system-wide profile can be found at /etc/zshrc.

# Explicitly add Homebrew to the PATH, otherwise some terminals cannot find it.
export PATH=/opt/homebrew/bin:$PATH

# Enable Homebrew autocompletion, 
# https://formulae.brew.sh/formula/zsh-completions
if type brew &>/dev/null; then
  # This must be done before loading ZSH autocompletion using the "compinit" command.
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Enable ZSH autocompletion using "compdef".
autoload -Uz compinit
zstyle ':completion:*' menu select
# zmodload zsh/complist
compinit
# Enable autocomplete for hidden (ie. dot) files.
_comp_options+=(globdots)

# Enable Atuin for managing shell history, https://atuin.sh
eval "$(atuin init zsh)"

# Enable autocomplete for 1Password CLI, 
# https://developer.1password.com/docs/cli/reference/commands/completion/
eval "$(op completion zsh)"; compdef _op op

# Use the 1Password SSH Agent Integration so you do not need to enter the SSH key passphrases.
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# Source the 1Password alias for the GitHub CLI so it uses the Personal Access Token from 
# 1Password for authentication.
if [ -f /Users/scott/.config/op/plugins.sh ]; then
    source /Users/scott/.config/op/plugins.sh
fi

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

# ASDF Version Manager
# https://asdf-vm.com
. $(brew --prefix asdf)/libexec/asdf.sh

# Python Version Manager
# https://github.com/pyenv/pyenv
# ASDF python plugin uses pyenv under the hood. These are the configurations for that package manager.
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# ASDF is currently configured to manage node, go, python, and ruby. However these plugins can
# sometimes not be as reliable as the individual version managers. Settings are included for the
# standard package managers should you need to use them instead of ASDF.

# Node Version Manager (NVM)
# https://github.com/nvm-sh/nvm
# # Add NVM to the user's PATH.
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# # Add NVM autocompletion
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


# Ruby Version Manager (RVM)
# https://rvm.io
# Add Ruby Version Manager to the user's PATH.
# PATH_TO_RVM="$HOME/.rvm/bin"
# if test -f "$PATH_TO_RVM"; then
#     export PATH="$PATH:$PATH_TO_RVM"
#     echo "Added RVM bin to the user's path \"$PATH\"."
# fi

# Go Version Manager (GVM)
# https://github.com/moovweb/gvm
# Add Go Version Manager to the user's PATH
# [[ -s ~/.gvm/scripts/gvm ]] && . ~/.gvm/scripts/gvm
# export GOPATH="$HOME/go"
# PATH="$GOPATH/bin:$PATH"



########################################
##### Load Custom Configuration
########################################

# Sources any files in the default Laptop directory (ie "~/.config/.laptop") that contain "zshrc_"
# in the filename. For example, "~/.config/.laptop/.zshrc_methods".
if [[ -d "$HOME/.config/laptop" ]]; then
  for file in $HOME/.config/laptop/*(DN); do 
    if [[ "$file" =~ "zshrc_" ]]; then
      source $file; 
    fi
  done
fi

# Sources any files in the user's defined Laptop directory (ie "~/.laptop") that contain "zshrc_"
# in the filename. For example, "~/.laptop/.zshrc_my_work_config".
if [[ -d "$HOME/.laptop" ]]; then
  for file in $HOME/.laptop/*(DN); do 
    if [[ "$file" =~ "zshrc_" ]]; then
      source $file; 
    fi
  done
fi