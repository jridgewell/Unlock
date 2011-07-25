Unlock
=========

https://github.com/jridgewell/unlock

## Description

Unlock will allow the system to unlock and mount CoreStorage encrypted volumes during boot (and before a User logs in). In other words, this allows you to log in as a User whose home directory is on an encrypted secondary volume without any problems.

## Install

- Run `bash <(curl -s https://raw.github.com/jridgewell/Unlock/master/install.sh)` in the terminal
- You will be asked for your login password.
- Follow the prompts
- - The program will find all CoreStorage volumes connected to your computer,
- - It will then loop through those it finds and ask you if you want to unlock the volume.
- - If you do, it will ask for the passphrase used to unlock that volume.

- Everything should be set up! Restart your computer and log in to test.

## Uninstall

- Run `bash <(curl -s https://raw.github.com/jridgewell/Unlock/master/uninstall.sh)` in the terminal (you'll be asked for your login password) to remove all traces from the system.

## How does it work?

During the install process, a LaunchDaemon is installed to `/Library/LaunchDaemons` that runs when the system is still starting up. The daemon starts a program that requests the passphrase to unlock the volume from the system's secure keychain. After the keychain returns the passphrase, the program unlocks the volume and allows the system to use the volume like a normal one. All of this completes before the system loads any information from the User's home directory, allowing a normal log in. 

## Problems?

If you have a problem, file a [bug report][issue] or fix it and submit a [pull request][pull].

[issue]: https://github.com/jridgewell/unlock/issues
[pull]: https://github.com/jridgewell/unlock/pulls
