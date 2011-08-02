Unlock
=========

https://github.com/jridgewell/unlock

## Description

Unlock allows the system to unlock and mount Core Storage encrypted volumes during boot. In other words, this allows you to log in as a user whose home directory is on an encrypted secondary disk without any problems.

## Why?

Like a many power users, I have two disks in my Macbook Pro. My startup volume is on a SSD and all of my home folder is on a second disk drive. Mac OS X Lion's FileVault 2 supports unlocking and mounting the startup volume, but doesn't support unlocking any other volume until a user has logged in. After encrypting my home drive and restarting, I was locked out of my user account and to log in to and out of another user just to log in in as myself. This script solves that problem by unlocking Core Storage volumes (e.g., my home disk) without the need for another user account. Simply put, it allows me to log in like normal.

## Install

Run [this][install] in the terminal.

    bash <(curl -s https://raw.github.com/jridgewell/Unlock/master/install.sh)

- You will be asked for your login password.
- Follow the prompts
  * The script will find all Core Storage encrypted volumes connected to your computer (it will ignore the startup volume).
  * It will then loop through the volumes it finds and ask you if you want to unlock the volume during boot.
    + If you do, it will then ask for the passphrase used to unlock that volume.
- Everything should be set up! Restart your computer and log in to test.

## Uninstall

Run [this][uninstall] in the terminal (you'll be asked for your login password) to remove all traces from the system.

    bash <(curl -s https://raw.github.com/jridgewell/Unlock/master/uninstall.sh)

## Problems?

If you have a problem, file a [bug report][issue] or fix it and submit a [pull request][pull].

[install]: https://raw.github.com/jridgewell/Unlock/master/install.sh
[uninstall]: https://raw.github.com/jridgewell/Unlock/master/uninstall.sh
[issue]: https://github.com/jridgewell/unlock/issues
[pull]: https://github.com/jridgewell/unlock/pulls
