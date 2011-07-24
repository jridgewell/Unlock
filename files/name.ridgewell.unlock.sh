#!/bin/sh
# Unlock volumes at boot
echo "Checking if volume is locked."
if [ "`diskutil cs list | grep Locked`" ]
	then
		PASSWORD=`security 2>&1 >/dev/null find -gs name.ridgewell.unlock "/Library/Keychains/System.keychain" | cut -d '"' -f 2`
		echo "Unlocking volume."
		diskutil cs unlockVolume UUID -passphrase "$PASSWORD"
fi
