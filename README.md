Unlock
=========

https://github.com/jridgewell/unlock


## Description

Unlock allows the system to unlock and mount Core Storage encrypted volumes
during boot. In other words, this allows you to log in as a user whose home
directory is on an encrypted secondary disk without any problems.


## Why?

Like a many power users, I have two disks in my Macbook Pro. My startup volume
is on a SSD and all of my home folder is on a second disk drive. Mac OS X Lion's
FileVault 2 supports unlocking and mounting the startup volume, but doesn't
support unlocking any other volume until a user has logged in. After encrypting
my home drive and restarting, I was locked out of my user account and had to log
in to and out of another user just to log in in as myself. This program solves
that problem by unlocking Core Storage volumes (e.g., my home disk) without the
need for another user account. Simply put, it allows me to log in like normal.


## Install

Run [this][install] in the terminal.

    curl -L https://raw.github.com/jridgewell/Unlock/master/install.sh | bash

- You will be asked for your login password.
- Follow the prompts
  * The install script will find all Core Storage encrypted volumes connected to
	your computer (it will ignore the startup volume).
  * It will then loop through the volumes it finds and ask you if you want to
	unlock the volume during boot.
	+ If you do, it will then ask for the passphrase used to unlock that volume.
- Everything should be set up! Restart your computer and log in to test.


## Uninstall

Run [this][uninstall] in the terminal (you'll be asked for your login password)
to remove all traces from the system.

    curl -L https://raw.github.com/jridgewell/Unlock/master/uninstall.sh | bash


## Q&A

### Does this encrypt my drive?
No, this program only unlocks volumes during boot. You must encrypt the volumes
yourself before using this program.
### Where is the passphrase stored?
The passphrase is stored in the encrypted System Keychain. Only users with administrative access to the computer will be able to retrieve the passphrase, but all user's will be able to unlock the volume (see next question).
### I'm user A. What if user B logs in? Will my home drive be mounted?
Yes it will. The program is not aware of who is logging in and I don't know of a
way to make it aware other than making it a User LaunchDaemon, which won't work.
A [pull request][pull] implementing this would be greatly appreciated.
### Is my data really secure?
Yes. Because the System Keychain is tied to its system, your drive can't be pulled out of the computer and unlocked using another computer. Only users of your own system will be able to unlock the volume, and even then, inbuilt security measures will prevent nonadministrative users from getting any data.
### Will this work after updates?
Yes, this program will continue to work even after updates. Because Apple doesn't
delete LaunchDaemons during updates, the program will always be there to run on
startup. And because the program uses Apple's supported APIs, the program will
continue to work.
### What if Apple fixes the bug?
If Apple does fix the bug, the program will not harm nor interfere in anyway.
Because of the way the program works, the worst case scenario is a warning
appearing in the console logs. Run the [uninstall][uninstall] script and
everything will go back to normal.

## Problems?

If you have a problem, file a [bug report][issue] or fix it and submit a [pull
request][pull].

[install]: https://raw.github.com/jridgewell/Unlock/master/install.sh
[uninstall]: https://raw.github.com/jridgewell/Unlock/master/uninstall.sh
[issue]: https://github.com/jridgewell/unlock/issues
[pull]: https://github.com/jridgewell/unlock/pulls
