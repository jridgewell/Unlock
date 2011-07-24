#!/bin/bash
if [ "`whoami`" != "root" ]
	then
		echo "Attempting to re-run as root..."
		curl https://raw.github.com/jridgewell/Unlock/keychain/install.sh -o install.sh
		chmod +x install.sh
		sudo bash ./install.sh
		rm install.sh
		exit
fi

# Make a temporary directory so that original files are not changed
mkdir tmp_install_unlock
cd tmp_install_unlock
echo "Downloading necessary files..."
curl https://raw.github.com/jridgewell/Unlock/keychain/files/name.ridgewell.unlock.plist -o name.ridgewell.unlock.plist
curl https://raw.github.com/jridgewell/Unlock/keychain/files/name.ridgewell.unlock.sh -o name.ridgewell.unlock.sh.tmp
echo "Done downloading!"
echo ""

echo "--------------------------"
echo "What is the UUID of the volume?"
read uuid
echo "And the passphrase used to encrypt it?"
read password
echo ""

echo "--------------------------"
echo "Installing..."
# Preform some sed jiggery to change required values
sed "s/UUID/$uuid/" name.ridgewell.unlock.sh.tmp > name.ridgewell.unlock.sh
rm name.ridgewell.unlock.sh.tmp

# Move them to the LaunchDaemons dir, and make sure they have the right permissions
mv ./* /Library/LaunchDaemons/
chown root:wheel /Library/LaunchDaemons/name.ridgewell.unlock.plist
chown root:wheel /Library/LaunchDaemons/name.ridgewell.unlock.sh
chmod 644 /Library/LaunchDaemons/name.ridgewell.unlock.plist
chmod 755 /Library/LaunchDaemons/name.ridgewell.unlock.sh
# Add the password to the System keychain
security add -a "$uuid" -D "Encrypted Volume Password" -l "Unlock" -s "name.ridgewell.unlock" \
	-w "$password" -T "/usr/bin/security" "/Library/Keychains/System.keychain"

# Cleanup
cd ..
rm -r tmp_install_unlock

echo ""
echo "--------------------------"
echo "Installed!"
