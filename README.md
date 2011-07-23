Unlock
=========

http://github.com/jridgewell/unlock

## Description

The LaunchDaemon will allow the system to unlock and mount CoreStorage encrypted drives during boot (and before a User logs in). In other words, this allows you to log in as a User whose user directory is on an encrypted secondary volume without any problems.

## Install

- Download and extract the [repo][].
- Edit `unlock.sh`, replacing \[UUID\] with the UUID of the CoreStorage Logical Volume you are trying to unlock (run `diskutil cs list` and search for the LV UUID; it will be a string like: "497C771B-63FE-461F-AD7B-0BEF9A6BA718"). Also replace \[PASSWORD\] with the passphrase you used to encrypt the drive.
- Run `./install.sh` in the terminal (you'll be asked for your password).
- Everything should be set up! Restart your computer to test.

## Uninstall

- Run `./uninstall.sh` in the terminal (you'll be asked for your password) to remove all traces from the system.

## Problems?

If have a problem, file a [bug report][issue] or fix it and submit [pull request][pull].

[repo]: https://github.com/jridgewell/unlock/tarball/master
[issue]: http://github.com/jridgewell/unlock/issues
[pull]: http://github.com/jridgewell/unlock/pulls
