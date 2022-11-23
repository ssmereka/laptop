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
