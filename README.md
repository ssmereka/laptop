# Laptop
Laptop is a script to set up your computer for software development. 

It's idempotent and installs, upgrades, or skips packages based on what is already installed on the machine. In otherwords, there's no downside to running it again and again.

It supports macOS on Apple Silicon.

> Inspired by [Thoughtbot's Laptop](https://github.com/thoughtbot/laptop), and I hope this inspires you too!

## Getting Started

### Setup your Secrets

Laptop will configure your computer so it can communicate with external services. This requires credentials and other information that should be kept secret. Laptop is configured to retreive these secrets from [1Password](1Password). So you're going to need 1Password for this to work out of the box.

1. Download, install, and login to the [1Password MacOS application].

2. Create a [GitHub Personal Access Token].

2. Unlock 1Password and add a `Login` item called `GitHub` with at least the following `fields`:

    | Type | Label | Example Value | Description |
    | -----| ----- | ------------- | ----------- |
    | text | `Name` | John Smith | Full name to be used in Git configuration |
    | text | `GitHub Email` | john@smith.com | Personal email address to be used in Git configuration |
    | password | `token` | github_pat_asdfjkl | GitHub Personal Access Token to be used with GitHub CLI |
    | text | `GitHub Username` | jsmith | GitHub username |

    > Note: These are the default names and they are configurable with command `./mac configure`.

3. Generate and save a new [SSH Key in 1Password] with the name `GitHub SSH Key`.

4. Create a [Authentication SSH Key in GitHub] with the public portion of the SSH Key you just added to 1Password.

5. Create a [Signing SSH Key in GitHub] with the public portion of the SSH Key you just added to 1Password.

6. Enable [1Password App Integration] so you can use the 1Password CLI. Check at least the following:

    * ✅ Use the SSH Agent
    * ✅ Integrate with 1Password CLI


### Install Laptop

1. Review the [mac] script. Avoid running a script you haven't read!

2. **Optionally**, customize the script's [configurations].

    ```bash
    curl -o- https://raw.githubusercontent.com/ssmereka/laptop/main/src/mac | zsh -s -- configure
    ```

3. Run the [mac] script. This will clone the Laptop git project to the directory `~/code/ssmereka/laptop` and setup your computer.

    ```bash
    curl -o- https://raw.githubusercontent.com/ssmereka/laptop/main/src/mac | zsh
    ```


### Available Commands
The `mac` Laptop script has a few commands available to help with setup or teardown. These are the available commands:

| Command | Example Usage | Description |
| ------- | ------------- | ----------- |
| `install` | `./mac install` | Install and configure your computer for development (default command if none specified) |
| `install --force` | `./mac install --force` | Remove existing local configurations and then run the install command. |
| `configure` | `./mac configure` | Create a local custom configuration file that you can use to customize Laptop's settings. |
| `uninstall` | `./mac uninstall` | Uninstall all applications and remove all configurations applied by Laptop. |
| `uninstall --force` | `./mac uninstall --force` | Run the uninstall command without any confirmation prompts. |


### Using Laptop

Laptop installs and configures tools that are used for software development. After running Laptop your machine is ready for development! Laptop also provides some useful commands, in your terminal run `help` to see the list.

```
  💻 Laptop Commands:

        🍰  lt-alias     list alias commands.
        🏥  lt-help      displays this help menu, can also use "help".
        🔄  lt-k8s       list kubernetes commands.
        🏓  lt-myip      displays external IP address.
        📥  lt-reset     update this "Laptop" software and reset the local configs.
        📥  lt-update    update this "Laptop" software.
 
  🧰 Tools:

        🏭  aws          https://docs.aws.amazon.com/cli/
        🍺  brew         http://brew.sh/
        🐵  code         https://code.visualstudio.com
        🐱  gh           https://cli.github.com/
        🌳  git          https://git-scm.com
        🐁  mise         https://mise.jdx.dev
        📦  nvm          https://github.com/nvm-sh/nvm
        🔐  op           https://developer.1password.com/docs/cli
        🌯  tofu         https://opentofu.org
```


### Update Laptop

Want the latest updates? Just re-run the [mac] script again using `curl` or the `lt-update` command.

```bash
lt-update
```


## What does Laptop do?

Laptop installs and configures your computer for development. Including programming languages, frameworks, and software tools that are common in web and mobile development. The setup is opinionated and iterated upon of years. It's designed to save us time and shared to help set others up for success.

**Languages:**

* [Kotlin]
* [Go]
* [Node.js]
* [Python]
* [Ruby] (and [Ruby on Rails])
* [Rust]

**Software Tools**

* [1Password CLI] for secret management from the commandline.
* [Atuin] for interactive searches of your shell history.
* [AWS CLI] command line interface for interacting with Amazon Web Services.
* [Core Utils] for GNU File, Shell, and Text utilities.
* [Curl] for interacting with URLs from the commandline.
* [Gawk] for interacting with files via the commandline.
* [Git] configures the local mac Git client for use with 1Password and GitHub.
* [GitHub CLI] for interacting with the GitHub API.
* [GnuPG] for encryption and signing.
* [Homebrew] for managing operating system libraries.
* [LibYAML] dependency for reading and writing yaml.
* [Mise] for managing software tools, environments, and automations.
* [NVM] for managing installations of Node.js.
* [OpenSSL] dependency for cryptography.
* [PostgreSQL] Database for storing application information in SQL and JSON.
* [OpenTofu] tool for maintaining infrastructure as code.
* [Visual Studio Code] for a programming IDE.
* [Zsh] configures zsh with some opinions (see the [Zsh Manual]).

Let's look at how some of the software tools are configured.


### ZSH Configuration

Terminal history should persist indefinitely as evidence of the actions you have taken.

Your history is a timeline of actions you have taken that can be leveraged for a number of use-caes. Like recalling what you did to setup an application. Or reviewing actions taken during an outage.

The zsh history is configured to store all (well... 999,999,999) events in the terminal and the `~/.zsh_history` file. With each event containing a timestamp (in seconds since the epoch) and duration (in seconds) of the command. The history is shared across all terminal sessions, as if they were a single session.

If you need to enter secret information into your terminal prefix the command with a `space`, like `" SECRET=my-password"`. Any command the begins with a `space` will not be stored in the history.

Use [Atuin](https://atuin.sh) (using the `Up Arrow` or `CTRL+R`) to interactively view and search your history. Programmatically search with the `history` command, like `history | grep <search term here>`.


### Version Manager

When developing you want your development environment to be as close to production as is reasonable. Switching between mutliple versions of software is complicated. To make switching easier, use version managers and package managers.

[Homebrew](https://brew.sh), mac's unofficial package manager, manages the installation of 3rd party software like `1password` and `curl`.

A language version manager called [Mise] is installed for managing several langugaes, enabling you to quickly switch between versions per project. Sometimes projects have tooling around a specific version manager, like NVM or pyenv. While Mise is configured as the default, you can still use other version managers. For example NVM is also installed and you can switch to the NVM managed node version with the `nvm use` command.


### Code Directory

Coding projects from git repositories are stored in the local `~/code` directory. We recommend using the pattern `~/code/<organization-name>/<repository-name>` so `<organization-name>` and `<repository-name>` align with GitHub. For example `~/code/ssmereka/laptop`. We find having code all in one root level folder makes it easier to work in an IDE or terminal. While a namespacing that mirrors GitHub makes it easy to find the right project and prevents naming collisions.


### Secrets

Secrets should be encrypted while at rest **and** you should authorize when anything tries to access those secrets. Laptop will install and configure the 1Password CLI so that secrets can be retrieved programmatically. With 1Password prompting you for authorization when anything attempts to access them. Laptop also configures Git to pull credentials from 1Password for authentication and signing. You can extend this to support multiple accounts.


## Customize Laptop

Laptop creates a folder to store all the configuration files it manages. By default this is in the user's home directory at path `~/.config/laptop`. These files are then semantically linked to the appropriate locations as required by the various software tools. You can modified these files as needed to customize your individual setup. Subsequent runs of Laptop will never modifiy these files without confirmation or an override command like `-f` or `--force`.

Additional files can be added to extend some of the existing configurations. For example, you may want to extend the configuartions for multiple accounts or for internal tools.

You can add the following files to the `~/.config/laptop` directory:

* `.zshrc_*` - Files with the `.zshrc_` prefix will be added to the end of the `.zshrc` file and loaded in each session.


### Environment Variables

You can override Laptop's default configuration by setting environment variables before running the script. These variables allow you to customize paths, repository locations, and 1Password secret references without modifying the script itself. Environment variables will override both default values and values set in the user's custom configuration script.

| Environment Variable | Default Value | Description |
| -------------------- | ------------- | ----------- |
| `LAPTOP_CODE_DIRECTORY` | `$HOME/code` | Directory where all coding projects will be cloned and stored |
| `LAPTOP_CUSTOM_CONFIG_SCRIPT` | `$HOME/.laptop/custom_config.sh` | Path to your optional custom configuration script |
| `LAPTOP_CUSTOM_SCRIPT_DIRECTORY` | `$HOME/.laptop` | Directory where your custom scripts are stored |
| `LAPTOP_CONFIG_DIRECTORY` | `$HOME/.config/laptop` | Directory where local Laptop configurations are stored |
| `LAPTOP_LOCAL_REPOSITORY_DIRECTORY` | `$HOME/code/ssmereka/laptop` | Directory where the local Laptop repository is cloned |
| `LAPTOP_REMOTE_BASE_URL` | `https://raw.githubusercontent.com/ssmereka/laptop/refs/heads/main` | URL to the Laptop remote repository's root directory, for downloading files |
| `LAPTOP_REMOTE_SSH_URL` | `git@github.com:ssmereka/laptop.git` | SSH URL for cloning the Laptop repository |
| `LAPTOP_SECRET_ITEM_NAME_GIT` | `GitHub` | Name of the 1Password item containing Git configuration fields |
| `LAPTOP_SECRET_FIELD_NAME_GIT_EMAIL` | `GitHub Email` | Name of the 1Password field containing your Git email |
| `LAPTOP_SECRET_FIELD_NAME_GIT_NAME` | `Name` | Name of the 1Password field containing your Git name |
| `LAPTOP_SECRET_FIELD_NAME_GIT_USERNAME` | `GitHub Username` | Name of the 1Password field containing your Git username |
| `LAPTOP_SECRET_ITEM_NAME_SSH_KEY` | `GitHub SSH Key` | Name of the 1Password item containing your SSH key |
| `LAPTOP_SECRET_FIELD_NAME_SSH_KEY_PUBLIC` | `public key` | Name of the 1Password field containing your public SSH key |
| `LAPTOP_TRASH_DIRECTORY` | `/tmp/Laptop` | Directory where deleted files are moved temporarily, mac will delete these on a reboot |

**Example usage:**

```bash
# Install Laptop with a custom code directory
LAPTOP_CODE_DIRECTORY="$HOME/projects" curl -o- https://raw.githubusercontent.com/ssmereka/laptop/main/src/mac | zsh

# Use a different 1Password item for Git credentials
LAPTOP_SECRET_ITEM_NAME_GIT="Work GitHub" ./mac install
```


### Custom Install Script

You can extend the Laptop install or uninstall by adding `zsh` scripts to the custom config directory. You may want to do this to install additional tools or tweak configurations per machine.

By default this directory is at path `~/.laptop/`. Laptop will automatically run the following scripts, if they exist in that directory:

* `custom_pre_install.sh` - Run before a Laptop install command is executed.
* `custom_post_install.sh` - Run after a Laptop install command is finished executing.
* `custom_pre_uninstall.sh` - Run before a Laptop uninstall command is executed.
* `custom_post_uninstall.sh` - Run after a Laptop uninstall command is finished executing.

Custom scripts will be "sourced" so they run in the same shell as the Laptop script, as if they were all in the same file. This gives you access to all the variables and methods in the Laptop script. Use caution when assigning global variables and methods to avoid collisions, and make sure your scripts are idempotent and readable by the user running Laptop.

Here is an example `custom_post_install.sh` script:

```zsh
#!/bin/zsh

brew bundle --file=- <<EOF
brew "ngrok"
EOF
```


<!-- Links -->

[1Password]: https://1password.com
[1Password App Integration]: https://developer.1password.com/docs/cli/app-integration/
[1Password CLI]: https://developer.1password.com/docs/cli/get-started/
[1Password MacOS application]: https://downloads.1password.com/mac/1Password.zip
[Atuin]: https://atuin.sh
[Authentication SSH Key in GitHub]: https://developer.1password.com/docs/ssh/get-started#step-2-upload-your-public-key-on-github
[AWS CLI]: https://docs.aws.amazon.com/cli/
[Core Utils]: https://formulae.brew.sh/formula/coreutils
[Curl]: https://curl.se
[Homebrew]: http://brew.sh/
[Gawk]: https://www.gnu.org/software/gawk/
[Git]: https://git-scm.com/
[GitHub CLI]: https://cli.github.com/
[GitHub Personal Access Token]: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens
[Go]: https://go.dev
[GnuPG]: https://www.gnupg.org
[LibYAML]:  https://pyyaml.org/wiki/LibYAML
[Kotlin]: https://kotlinlang.org
[mac]: https://github.com/ssmereka/laptop/blob/main/src/mac
[Mise]: https://mise.jdx.dev
[Node.js]: https://nodejs.org/en
[NVM]: https://github.com/nvm-sh/nvm
[OpenSSL]: https://www.openssl.org/
[OpenTofu]: https://opentofu.org
[PostgreSQL]: https://www.postgresql.org
[Python]: https://www.python.org
[Ruby]: https://www.ruby-lang.org/en/
[Ruby on Rails]: https://rubyonrails.org
[Rust]: https://rustup.rs
[configurations]: https://github.com/ssmereka/laptop/blob/main/examples/custom_config.sh
[Signing SSH Key in GitHub]: https://developer.1password.com/docs/ssh/git-commit-signing
[SSH Key in 1Password]: https://developer.1password.com/docs/ssh/get-started#step-1-generate-an-ssh-key
[Visual Studio Code]: https://code.visualstudio.com
[Zsh]: http://www.zsh.org/
[Zsh Manual]: https://zsh.sourceforge.io/Doc/Release/The-Z-Shell-Manual.html#The-Z-Shell-Manual
