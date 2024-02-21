# Laptop
Laptop is a script to set up your computer for software development. 

It's idempotent and installs, upgrades, or skips packages based on what is already installed on the machine. In otherwords, there's no downside to running it again and again.

It supports macOS Ventura (13) on Apple Silicon and Intel processors. 

>Inspired by [Thoughtbot's Laptop](https://github.com/thoughtbot/laptop), and I hope this inspires you too!

## Getting Started

### Setup your Secrets

A few secrets are required to get setup. Laptop is configured to retreive these secrets from [1Password](https://1password.com).

1. Download, install, and login to the [1Password MacOS application](https://downloads.1password.com/mac/1Password.zip).

2. Unlock 1Password and add a `Login` item called `GitHub` with the following `fields`:

    | Type | Label | Example Value | Description |
    | -----| ----- | ------------- | ----------- |
    | text | `name` | John Smith | Full name to be used in Git configuration |
    | text | `email` | john@smith.com | Personal email address to be used in Git configuration |
    | text | `username` | jsmith | GitHub username |

3. Follow the 1Password guides to [add a new SSH Key to 1Password](https://developer.1password.com/docs/ssh/get-started#step-1-generate-an-ssh-key) called `GitHub SSH Key`. Then [add this SSH key to your GitHub account](https://developer.1password.com/docs/ssh/get-started#step-2-upload-your-public-key-on-github).

### Install Laptop

1. Review the [install-laptop](https://github.com/ssmereka/laptop/blob/main/install-laptop) and [install-mac](https://github.com/ssmereka/laptop/blob/main/src/install-mac) scripts. Avoid running a script you haven't read!

2. Run the Laptop `install-laptop` script.

    ```bash
    curl -o- https://raw.githubusercontent.com/ssmereka/laptop/main/install-laptop | bash
    ```

This will clone git project to `~/code/laptop` and run `~/code/laptop/install-mac` to setup your Laptop!

### Update Laptop

To update or fix any issues with Laptop just re-run the `install-laptop` script again.

You can use the alias

```bash
lt-update
```

OR

```bash
curl -o- https://raw.githubusercontent.com/ssmereka/laptop/main/install-laptop | bash
```


### Using Laptop

Run the command `help` in your terminal for a list of available commands. (Relaunch your terminal if the command doesn't work)

![laptop-help](https://github.com/ssmereka/laptop/assets/489291/6be6ecfb-ed78-498c-abca-3abc9e4662fb)

## What does Laptop setup?

Laptop installs and configures the following:

* [Homebrew](http://brew.sh/) for managing operating system libraries.
* [Git](https://git-scm.com/) configures the local Git client for use with 1Password and GitHub.
* [GitHub CLI](https://cli.github.com/) for interacting with the GitHub API
* [Zsh](http://www.zsh.org/) configures zsh with some opinions

Laptop will configure your computer in a very opinionated way. Let's describe those opinions and how the script is configured to meet them.

### Terminal history should persist indefinitely as evidence of the actions you have taken.

Your history is a timeline of actions you have taken that can be leveraged for a number of use-caes. Like recalling what you did to setup an application. Or reviewing actions taken during an outage.

The zsh history is configured to store all (well... 999,999,999) events in the terminal and the `~/.zsh_history` file. With each event containing a timestamp (in seconds since the epoch) and duration (in seconds) of the command. The history is shared across all terminal sessions, as if they were a single session.

If you need to enter secret information into your terminal prefix the command with a `space`, like `" SECRET=my-password"`. Any command the begins with a `space` will not be stored in the history.

Use commands like `history | grep <search term here>` or interactive history search with `CTRL+R` to query the history events. These commands are listed in the Laptop screen too, just run `help`.

### Use package managers.

When developing you want your development environment to be as close to production as is reasonable. Switching between mutliple versions of software, like Python or Terraform, is complicated. To make switching easier, use a version manager whenever possible.

[Homebrew](https://brew.sh), mac's unofficial package manager, is installed and used to manage the installation of 3rd party software, like `1password`.

Version managers are installed for Node, Python, Go, and Ruby. Enabling you to quickly install and use different versions for application development.

### Projects are stored in directory