# Laptop
Laptop is a script to set up your computer for development. 

It's idempotent and installs, upgrades, or skips packages based on what is already installed on the machine.
Laptop works on macOS Monterey (12.2) on Intel processors, other versions and hardware are not tested.
Inspired by [Thoughtbot](https://github.com/thoughtbot/laptop).

## Install 

1. Download, install, and login to [1Password](https://downloads.1password.com/mac/1Password.zip)

2. Run the Laptop script

    ```bash
    curl -o- https://raw.githubusercontent.com/ssmereka/laptop/main/install | bash
    ```
