#!/bin/bash

# Make a temporary directory so that original files are not changed
mkdir tmp_install_unlock
cd tmp_install_unlock
echo "Downloading necessary files..."
curl https://raw.github.com/jridgewell/Unlock/curlinstall/files/name.ridgewell.unlock.plist -o name.ridgewell.unlock.plist
curl https://raw.github.com/jridgewell/Unlock/curlinstall/files/unlock.sh -o unlock.sh
echo "Done downloading!"
echo ""

echo "--------------------------"
echo "What is the UUID of the drive?"
read uuid
echo "And the passphrase used to encrypt it?"
read password
echo ""

echo "--------------------------"
echo "Installing..."
# Preform some sed jiggery to change required values
sed "s/UUID/$uuid/" unlock.sh > unlock.sh.tmp
rm unlock.sh
sed "s/PASSWORD/$password/" unlock.sh.tmp > unlock.sh
rm unlock.sh.tmp

# Move them to the LaunchDaemons dir, and make sure they have the right permissions
sudo mv ./* /Library/LaunchDaemons/
sudo chown root:wheel /Library/LaunchDaemons/name.ridgewell.unlock.plist
sudo chown root:wheel /Library/LaunchDaemons/unlock.sh
sudo chmod 644 /Library/LaunchDaemons/name.ridgewell.unlock.plist
sudo chmod 755 /Library/LaunchDaemons/unlock.sh

# Cleanup
cd ..
rm -r tmp_install_unlock
