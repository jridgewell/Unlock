#!/bin/sh
# Unlock Drive
echo "Checking if drive is unlocked."
if [ "`diskutil cs list | grep Locked`" ]
	then
		echo "Unlocking drive."
		diskutil cs unlockVolume [UUID] -passphrase [PASSWORD]
fi