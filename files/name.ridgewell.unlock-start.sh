#!/bin/sh
# Unlock volumes at boot
echo "Checking if any volumes are locked."
if [ "`diskutil cs list | grep Locked`" ]; then
	getPass() {
		security 2>&1 >/dev/null find -ga $1 "/Library/Keychains/System.keychain" | cut -d '"' -f 2
	}
	echo "Unlocking volume(s)."
