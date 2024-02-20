# Laptop
Laptop is a script to set up your computer for development. 

It's idempotent and installs, upgrades, or skips packages based on what is already installed on the machine.
Laptop works on macOS Ventura (13.0) on Intel processors, other versions and hardware are not tested.

Inspired by [Thoughtbot](https://github.com/thoughtbot/laptop).

## Getting Started

1. Download, install, and login to [1Password](https://downloads.1password.com/mac/1Password.zip).

2. Unlock 1Password and add a `Login` item called `GitHub` with the following `fields`:

    | Type | Label | Example Value | Description |
    | -----| ----- | ------------- | ----------- |
    | text | `name` | John Smith | Full name to be used in Git configuration |
    | text | `email` | john@smith.com | Personal email address to be used in Git configuration |
    | text | `username` | jsmith | GitHub username |

3. [Add a new SSH Key to 1Password](https://developer.1password.com/docs/ssh/get-started#step-1-generate-an-ssh-key) called `GitHub SSH Key`. Then [add this SSH key to your GitHub account](https://developer.1password.com/docs/ssh/get-started#step-2-upload-your-public-key-on-github).

4. Run the Laptop `install` script.

    ```bash
    curl -o- https://raw.githubusercontent.com/ssmereka/laptop/main/install | bash
    ```

## Update Laptop

To update or fix any issues with Laptop re-run the install:

```bash
curl -o- https://raw.githubusercontent.com/ssmereka/laptop/main/install | bash
```

## Using Laptop

Run the command `help` in your terminal for a list of available commands.

![laptop-help](https://github.com/ssmereka/laptop/assets/489291/6be6ecfb-ed78-498c-abca-3abc9e4662fb)


Laptop has configured your computer in a very opinionated way. Here's are those opinions and the settings applied as a result.

#### Terminal history should persist indefinitely as evidence of the actions you have taken.

Your history is a timeline of actions you have taken that can be leveraged for a number of use-caes. Like recalling what you did to setup an application. Or reviewing actions taken during an outage.

The zsh history is configured to store all (well... 999,999,999) events in the terminal and the `~/.zsh_history` file. With each event containing a timestamp (in seconds since the epoch) and duration (in seconds) of the command. The history is shared across all terminal sessions, as if they were a single session.

If you need to enter secret information into your terminal prefix the command with a `space`, like `" SECRET=my-password"`. Any command the begins with a `space` will not be stored in the history.

Use commands like `history | grep <search term here>` or interactive history search with `CTRL+R` to query the history events. These commands are listed in the Laptop screen too, just run `help`.

#### Use package managers.

Software is complex, configurable, and changes often. To mitigate issues caused by installing or managing versions we use version managers when possible.

[Homebrew](https://brew.sh), mac's unofficial package manager, is installed and used to manage the installation of 3rd party software, like `1password`.

Version managers are installed for Node, Python, Go, and Ruby. Enabling you to quickly install and use different versions for application development.

## Additional Settings

**Map external keyboard keys:**
1. Navigate to `System Settings` > `Keyboard`.
2. Change `Select keyboard` to the external keyboard.
3. Chanage `Option key` to `Command`.
4. Change `Command key` to `Option`.
