#!/bin/sh
# Unlock volumes at boot
echo "Checking if any volumes are locked."
if [ "`diskutil cs list | grep Locked`" ]
	then
		echo "Unlocking volume(s)."
