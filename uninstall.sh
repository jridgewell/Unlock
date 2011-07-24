#!/bin/bash
echo "Uninstalling..."
sudo security >/dev/null 2>&1 delete-generic-password -D "Encrypted Volume Password" -l "Unlock" -s "name.ridgewell.unlock" "/Library/Keychains/System.keychain"
sudo rm /Library/LaunchDaemons/name.ridgewell.unlock.plist
sudo rm /Library/LaunchDaemons/name.ridgewell.unlock.sh

echo ""
echo "--------------------------"
echo "Uninstalled."
