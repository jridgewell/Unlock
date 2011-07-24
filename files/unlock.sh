#!/bin/sh
# Unlock volumes at boot
echo "Checking if volume is locked."
if [ "`diskutil cs list | grep Locked`" ]
	then
		echo "Unlocking volume."
		diskutil cs unlockVolume UUID -passphrase PASSWORD
fi