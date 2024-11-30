# Laptop
Laptop is a script to set up your computer for software development. 

It's idempotent and installs, upgrades, or skips packages based on what is already installed on the machine. In otherwords, there's no downside to running it again and again.

It supports macOS on Apple Silicon and Intel processors.

>Inspired by [Thoughtbot's Laptop](https://github.com/thoughtbot/laptop), and I hope this inspires you too!

## Getting Started

### Setup your Secrets

A few secrets are required to get setup. Laptop is configured to retreive these secrets from [1Password](1Password). So you're going to need 1Password for this to work out of the box.

1. Download, install, and login to the [1Password MacOS application](1Password MacOS application).

2. Create a [GitHub Personal Access Token].

2. Unlock 1Password and add a `Login` item called `GitHub` with the following `fields`:

    | Type | Label | Example Value | Description |
    | -----| ----- | ------------- | ----------- |
    | text | `name` | John Smith | Full name to be used in Git configuration |
    | text | `email` | john@smith.com | Personal email address to be used in Git configuration |
    | text | `token` | github_pat_asdfjkl | GitHub Personal Access Token to be used with GitHub CLI |
    | text | `username` | jsmith | GitHub username |

3. Generate and save a new [SSH Key to 1Password] with the name `GitHub SSH Key`.

4. Create a [Authentication SSH Key in GitHub] with the public portion of the SSH Key you just added to 1Password.

5. Create a [Signing SSH Key in GitHub] with the public portion of the SSH Key you just added to 1Password.

6. Enable [1Password App Integration] so you can use the 1Password CLI.

    Recommend the following 1Password Developer settings:

    ![1password_developer_settings_1](https://github.com/user-attachments/assets/8611fc21-c91a-486a-8c49-d584d13cd2e8)
    ![1password_developer_settings_2](https://github.com/user-attachments/assets/9c693078-5e7a-4429-ad69-d458a19d504e)


### Install Laptop

1. Review the [mac] script. Avoid running a script you haven't read!

2. Run the [mac] script.

    ```bash
    curl -o- https://raw.githubusercontent.com/ssmereka/laptop/main/src/mac | zsh
    ```

This will clone the git project to `~/code/laptop` and setup your computer!

### Update Laptop

To update or fix any issues with Laptop just re-run the [mac] script again. You can use the alias:


```bash
lt-update
```

OR

```bash
curl -o- https://raw.githubusercontent.com/ssmereka/laptop/main/src/mac | zsh
```

### Using Laptop

Laptop installs software and configures your Laptop. It also provides some useful commands. Run the command `help` in your terminal for a list of available commands. (You may need to relaunch your terminal if the command doesn't work)

![laptop-help](https://github.com/user-attachments/assets/0552bd40-ceff-41d1-b8fa-94d39c908792)

## What does Laptop setup?

Laptop installs and configures the following software:

* [1Password CLI] for secret management from the commandline.
* [asdf] for managing programming language versions.
    * [Go] via the [asdf-golang] plugin.
    * [Node.js] and npm via the [asdf-nodejs] plugin.
    * [Python] via the [asdf-python] plugin.
    * [Ruby] via the [asdf-ruby] plugin.
* [Atuin]
* [Core Utils] for GNU File, Shell, and Text utilities.
* [Curl] for interacting with URLs from the commandline.
* [Gawk] for interacting with files via the commandline.
* [Git] configures the local mac Git client for use with 1Password and GitHub.
* [GitHub CLI] for interacting with the GitHub API.
* [GnuPG] for encryption and signing.
* [Homebrew] for managing operating system libraries.
* [Visual Studio Code] for a programming IDE.
* [Zsh]configures zsh with some opinions (see the [Zsh Manual]).


Laptop will configure your computer in a very opinionated way. Let's describe those opinions and how the script is configured to meet them.

### ZSH Configuration

Terminal history should persist indefinitely as evidence of the actions you have taken.

Your history is a timeline of actions you have taken that can be leveraged for a number of use-caes. Like recalling what you did to setup an application. Or reviewing actions taken during an outage.

The zsh history is configured to store all (well... 999,999,999) events in the terminal and the `~/.zsh_history` file. With each event containing a timestamp (in seconds since the epoch) and duration (in seconds) of the command. The history is shared across all terminal sessions, as if they were a single session.

If you need to enter secret information into your terminal prefix the command with a `space`, like `" SECRET=my-password"`. Any command the begins with a `space` will not be stored in the history.

Use [Atuin](https://atuin.sh) (using the `Up Arrow` or `CTRL+R`) to interactively view and search your history. Programmatically search with the `history` command, like `history | grep <search term here>`.

### ASDF Version Manager

When developing you want your development environment to be as close to production as is reasonable. Switching between mutliple versions of software is complicated. To make switching easier, use version managers and package managers.

[Homebrew](https://brew.sh), mac's unofficial package manager, is installed and used to manage the installation of 3rd party software, like `1password` and `curl`.

Language version managers are installed for Node.js, Python, Go, and Ruby. Enabling you to quickly install and use different versions for each application you are developing. These version manager are all managed by [asdf](https://asdf-vm.com). This makes interaction with version managers more consistant as you switch between them or need to add/remove version managers.

### Code Directory

Coding projects from git repositories are stored in the local `~/code` directory. This make it easy to find git projects.

### Secrets

Secrets belong in a password manager or secret storage **and** you should authorize when anything tries to access those secrets. Laptop will install and configure the 1Password CLI so that secrets can be retrieved programmatically. Git is also configured to use 1Password for authentication and signing.

## Customize Laptop

You can customize Laptop for each computer by placing files in the `~/.laptop` directory. If provided, the following files will be used:

* `.custom_install.sh` - Script that will be run at the end of the Laptop `install`.


Here's a `.custom_install.sh` example:

```zsh
#!/bin/zsh

brew bundle --file=- <<EOF
brew "ngrok"
EOF
```

Write your customizations such that they can be run safely more than once.

[1Password]: https://1password.com
[1Password App Integration]: https://developer.1password.com/docs/cli/app-integration/
[1Password CLI]: https://developer.1password.com/docs/cli/get-started/
[1Password MacOS application]: https://downloads.1password.com/mac/1Password.zip
[asdf]: https://asdf-vm.com
[asdf-golang]: https://github.com/asdf-community/asdf-golang?tab=readme-ov-file#version-selection
[asdf-nodejs]: https://github.com/asdf-vm/asdf-nodejs
[asdf-python]: https://github.com/asdf-community/asdf-python
[asdf-ruby]: https://github.com/asdf-vm/asdf-ruby
[Atuin]: https://atuin.sh
[Authentication SSH Key in GitHub]: https://developer.1password.com/docs/ssh/get-started#step-2-upload-your-public-key-on-github
[Core Utils]: https://formulae.brew.sh/formula/coreutils
[Curl]: https://curl.se
[mac]: https://github.com/ssmereka/laptop/blob/main/src/mac
[Homebrew]: http://brew.sh/
[Gawk]: https://www.gnu.org/software/gawk/
[Git]: https://git-scm.com/
[GitHub CLI]: https://cli.github.com/
[GitHub Personal Access Token]: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens
[Go]: https://go.dev
[GnuPG]: https://www.gnupg.org
[Node.js]: https://nodejs.org/en
[Python]: https://www.python.org
[Ruby]: https://www.ruby-lang.org/en/
[Signing SSH Key in GitHub]: https://developer.1password.com/docs/ssh/git-commit-signing
[SSH Key to 1Password]: https://developer.1password.com/docs/ssh/get-started#step-1-generate-an-ssh-key
[Visual Studio Code]: https://code.visualstudio.com
[Zsh]: http://www.zsh.org/
[Zsh Manual]: https://zsh.sourceforge.io/Doc/Release/The-Z-Shell-Manual.html#The-Z-Shell-Manual

