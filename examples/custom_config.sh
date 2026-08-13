#!/bin/zsh

# Directory where all coding projects will be cloned and stored.
laptop_code_directory="$HOME/code"

# Directory where a user's custom scripts are stored. Laptop will run and source 
# files from this directory, make sure proper permissions are set. Laptop will always
# require confirmation or a force flag before overwriting files in this directory.
laptop_custom_script_directory="$HOME/.laptop"

# Directory where local Laptop configurations are stored. Laptop will create files
# in this directory and link them to appropriate locations. Users can modify these
# files as needed. Laptop will always require confirmation or a force flag before
# overwriting files in this directory.
laptop_config_directory="$HOME/.config/laptop"

# Directory where a local copy of the Laptop repository will be cloned and stored.
laptop_local_repository_directory="$laptop_code_directory/ssmereka/laptop"

# Directory where log files are stored for Laptop.
laptop_log_directory="$HOME/Library/Logs/Laptop"

# A URL to the most recent Laptop code repository stored in GitHub. This should point
# to the root directory so you can append file paths to navigate to files and folders
# in the repository.
laptop_remote_base_url="https://raw.githubusercontent.com/ssmereka/laptop/refs/heads/main"

# The URL used to clone the remote Laptop repository via SSH.
laptop_remote_ssh_url="git@github.com:ssmereka/laptop.git"

# The name of the 1Password "item" where the Git configurations exist, including email, name, and
# username.
laptop_secret_item_name_git="GitHub"

# Name of the 1Password "field" in the item "laptop_secret_item_name_git" that contains the email address that
# should be used by the Git client.
laptop_secret_field_name_git_email="GitHub Email"

# Name of the 1Password "field" in the item "laptop_secret_item_name_git" that contains the name that
# should be used by the Git client.
laptop_secret_field_name_git_name="Name"

# Name of the 1Password "field" in the item "laptop_secret_item_name_git" that contains the git username that
# should be used by the Git client.
laptop_secret_field_name_git_username="GitHub Username"

# The name of the 1Password "item" where the Git SSH Key configurations exist. This key should be
# added to your remote Git repository, eg. GitHub.
laptop_secret_item_name_ssh_key="GitHub SSH Key"

# Name of the 1Password "field" in the item "laptop_secret_item_name_ssh_key" that contains the public ssh key
# used by your remote Git repository, eg. GitHub.
laptop_secret_field_name_ssh_key_public="public key"

# Directory where Laptop files or configurations are moved when they should be deleted.
# Enables user to recover files if needed and they will be automatically removed when the
# computer is restarted.
laptop_trash_directory="/tmp/Laptop"
