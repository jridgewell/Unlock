#!/bin/bash
echo "Uninstalling..."
if [ "`whoami`" != "root" ]
	then
		echo "Attempting to re-run as root..."
#		sudo bash ./uninstall.sh
		sudo $0
		exit
fi

security >/dev/null 2>&1 delete-generic-password -D "Encrypted Volume Password" -l "Unlock" -s "name.ridgewell.unlock" "/Library/Keychains/System.keychain"
rm /Library/LaunchDaemons/name.ridgewell.unlock.plist
rm /Library/LaunchDaemons/name.ridgewell.unlock.sh

echo ""
echo "--------------------------"
echo "Uninstalled."
