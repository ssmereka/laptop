# Laptop
Laptop is a script to set up your computer for software development. 

It's idempotent and installs, upgrades, or skips packages based on what is already installed on the machine. In otherwords, there's no downside to running it again and again.

It supports macOS Ventura (13) on Apple Silicon and Intel processors. 

>Inspired by [Thoughtbot's Laptop](https://github.com/thoughtbot/laptop), and I hope this inspires you too!

## Getting Started

### Setup your Secrets

A few secrets are required to get setup. Laptop is configured to retreive these secrets from [1Password](https://1password.com). So you're going to need 1Password for this to work out of the box.

1. Download, install, and login to the [1Password MacOS application](https://downloads.1password.com/mac/1Password.zip).

2. Unlock 1Password and add a `Login` item called `GitHub` with the following `fields`:

    | Type | Label | Example Value | Description |
    | -----| ----- | ------------- | ----------- |
    | text | `name` | John Smith | Full name to be used in Git configuration |
    | text | `email` | john@smith.com | Personal email address to be used in Git configuration |
    | text | `username` | jsmith | GitHub username |

3. Follow the 1Password guides to [add a new SSH Key to 1Password](https://developer.1password.com/docs/ssh/get-started#step-1-generate-an-ssh-key) called `GitHub SSH Key`. Then [add this SSH key to your GitHub account](https://developer.1password.com/docs/ssh/get-started#step-2-upload-your-public-key-on-github).

4. Follow the [1Password guide to enable App Integration](https://developer.1password.com/docs/cli/app-integration/) so you can use the 1Password CLI.

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

![laptop-help](https://github.com/ssmereka/laptop/assets/489291/6be6ecfb-ed78-498c-abca-3abc9e4662fb)


### Using Laptop

Laptop installs software and configures your Laptop. It also provides some useful commands. Run the command `help` in your terminal for a list of available commands. (You may need to relaunch your terminal if the command doesn't work)

![laptop-help](https://github.com/ssmereka/laptop/assets/489291/6be6ecfb-ed78-498c-abca-3abc9e4662fb)

## What does Laptop setup?

Laptop installs and configures the following software:

* [Homebrew](http://brew.sh/) for managing operating system libraries.
* [Git] configures the local mac Git client for use with 1Password and GitHub.
* [GitHub CLI] for interacting with the GitHub API
* [Zsh] configures zsh with some opinions
* [asdf] for managing programming language versions
* [Node.js] and npm (via the [asdf-nodejs] plugin)
* [Ruby] and npm (via the [asdf-ruby] plugin)

Laptop will configure your computer in a very opinionated way. Let's describe those opinions and how the script is configured to meet them.

### ZSH Configuration

We believe terminal history should persist indefinitely as evidence of the actions you have taken.

Your history is a timeline of actions you have taken that can be leveraged for a number of use-caes. Like recalling what you did to setup an application. Or reviewing actions taken during an outage.

The zsh history is configured to store all (well... 999,999,999) events in the terminal and the `~/.zsh_history` file. With each event containing a timestamp (in seconds since the epoch) and duration (in seconds) of the command. The history is shared across all terminal sessions, as if they were a single session.

If you need to enter secret information into your terminal prefix the command with a `space`, like `" SECRET=my-password"`. Any command the begins with a `space` will not be stored in the history.

Use commands like `history | grep <search term here>` or interactive history search with `CTRL+R` to query the history events. These commands are listed in the Laptop screen too, just run `help`.

### ASDF Version Manager

When developing you want your development environment to be as close to production as is reasonable. Switching between mutliple versions of software is complicated. To make switching easier we setup version managers and package managers.

[Homebrew](https://brew.sh), mac's unofficial package manager, is installed and used to manage the installation of 3rd party software, like `1password`.

Version managers are installed for Node.js, Python, Go, and Ruby. Enabling you to quickly install and use different versions for application development. These version manager are all managed by [asdf].

### Code Directory

Coding projects from git repositories are stored in the local `~/code` directory.

## Customize Laptop

If provided, your local file `~/.laptop.local` is run at the end of the Laptop script. Put your customizations there.

For example:

```zsh
#!/bin/zsh

brew bundle --file=- <<EOF
brew "ngrok"
EOF
```

Write your customizations such that they can be run safely more than once.


[mac]: https://github.com/ssmereka/laptop/blob/main/src/mac
[Homebrew]: http://brew.sh/
[Git]: https://git-scm.com/
[GitHub CLI]: https://cli.github.com/
[Zsh]: http://www.zsh.org/
[asdf]: https://github.com/asdf-vm/asdf
[Node.js]: https://nodejs.org/en
[Ruby]: https://www.ruby-lang.org/en/
[asdf-nodejs]: https://github.com/asdf-vm/asdf-nodejs
[asdf-ruby]: https://github.com/asdf-vm/asdf-ruby