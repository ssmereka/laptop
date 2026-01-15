#!/bin/zsh

# Directory where all coding projects will be cloned and stored.
code_directory="$HOME/code"

# Directory where local Laptop configurations are stored. Laptop will create files
# in this directory and link them to appropriate locations. Users can modify these
# files as needed. Laptop will always require confirmation or a force flag before
# overwriting files in this directory.
laptop_local_directory="$HOME/.config/laptop"

# Path to the user's optional custom configuration script. This file is executed before
# commands are executed, allowing users to set or override variables and methods.
laptop_custom_config_script="$HOME/.laptop/custom_config.sh"

# Directory where a user's custom scripts are stored. Laptop will run and source 
# files from this directory, make sure proper permissions are set. Laptop will never
# modified files in this directory.
laptop_custom_directory="$HOME/.laptop"

# Directory where a local copy of the Laptop repository will be cloned and stored.
laptop_repo_directory="$code_directory/ssmereka/laptop"

# Base URL for the remote Laptop repository.
remote_laptop_base_url="https://raw.githubusercontent.com/ssmereka/laptop/refs/heads/main"

# The name of the 1Password "item" where the Git configurations exist, including email, name, and
# username.
secret_item_name_git="GitHub"

# Name of the 1Password "field" in the item "secret_item_name_git" that contains the email address that
# should be used by the Git client.
secret_field_name_git_email="GitHub Email"

# Name of the 1Password "field" in the item "secret_item_name_git" that contains the name that
# should be used by the Git client.
secret_field_name_git_name="Name"

# Name of the 1Password "field" in the item "secret_item_name_git" that contains the git username that
# should be used by the Git client.
secret_field_name_git_username="GitHub Username"

# The name of the 1Password "item" where the Git SSH Key configurations exist. This key should be
# added to your remote Git repository, eg. GitHub.
secret_item_name_ssh_key="GitHub SSH Key"

# Name of the 1Password "field" in the item "secret_item_name_ssh_key" that contains the public ssh key
# used by your remote Git repository, eg. GitHub.
secret_field_name_ssh_key_public="public key"