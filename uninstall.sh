#!/bin/bash
echo "Uninstalling..."
err=`sudo security 2>&1 >/dev/null delete-generic-password -D "Encrypted Volume Password" -s "name.ridgewell.unlock" "/Library/Keychains/System.keychain"`
while [[ $err == "password has been deleted." ]]; do
	err=`sudo security 2>&1 >/dev/null delete-generic-password -D "Encrypted Volume Password" -s "name.ridgewell.unlock" "/Library/Keychains/System.keychain"`
done
sudo rm /Library/LaunchDaemons/name.ridgewell.unlock.plist
sudo rm /Library/LaunchDaemons/name.ridgewell.unlock.sh

echo "--------------------------"
echo ""
echo "Uninstalled."
