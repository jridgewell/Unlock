#!/bin/bash
echo "Uninstalling..."
cmd() { sudo security 2>&1 >/dev/null delete-generic-password -D "Encrypted Volume Password" -s "name.ridgewell.unlock" "/Library/Keychains/System.keychain"; }
err=`cmd`
while [[ $err == "password has been deleted." ]]; do
	err=`cmd`
done
sudo rm /Library/LaunchDaemons/name.ridgewell.unlock.plist
sudo rm /Library/LaunchDaemons/name.ridgewell.unlock.sh

echo "--------------------------"
echo ""
echo "Uninstalled."
