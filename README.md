Unlock
=========

https://github.com/jridgewell/unlock

## Description

Unlock will allow the system to unlock and mount Core Storage encrypted volumes during boot. In other words, this allows you to log in as a user whose home directory is on an encrypted secondary volume without any problems.

## Why?

Like a many power users, I have two disks in my Macbook Pro. My startup volume is on a SSD and all of my sensitive user data is on a second disk drive. Lion's FileVault 2 supports unlocking and loading the startup volume, but doesn't support unlocking any other volume until a user has logged in. Encrypting my disk drive locked me out of logging directly into my user account, and required me to log in and out of another user in order to log in as myself. This script solves that problem by unlocking Core Storage volumes before any user logs in and without using another account.

## Install

- Run [this][install] in the terminal.

     bash <(curl -s https://raw.github.com/jridgewell/Unlock/master/install.sh)

- You will be asked for your login password.
- Follow the prompts
  * The script will find all Core Storage encrypted volumes connected to your computer.
  * It will then loop through the volumes it finds and ask you if you want to unlock the volume during boot.
    + If you do, it will then ask for the passphrase used to unlock that volume.
- Everything should be set up! Restart your computer and log in to test.

## Uninstall

- Run [this][uninstall] in the terminal (you'll be asked for your login password) to remove all traces from the system.

     bash <(curl -s https://raw.github.com/jridgewell/Unlock/master/uninstall.sh)


## Problems?

If you have a problem, file a [bug report][issue] or fix it and submit a [pull request][pull].

[install]: https://raw.github.com/jridgewell/Unlock/master/install.sh
[uninstall]: https://raw.github.com/jridgewell/Unlock/master/uninstall.sh
[issue]: https://github.com/jridgewell/unlock/issues
[pull]: https://github.com/jridgewell/unlock/pulls
