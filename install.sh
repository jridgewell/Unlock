#!/bin/bash
if [[ `whoami` != "root" ]]; then
# Run as root to avoid Console logging sudo commands.
	echo "Attempting to re-run as root..."
	#curl https://raw.github.com/jridgewell/Unlock/objc/install.sh -o install.sh
	chmod +x install.sh
	echo "--------------------------"
	echo ""

	sudo bash ./install.sh
	#rm install.sh
	exit
fi

# We need to set up the LaunchDaemon script to unlock the volumes
echo "--------------------------"
echo ""
echo "Installing..."
curl "https://raw.github.com/jridgewell/Unlock/objc/files/name.ridgewell.unlock.plist" -o name.ridgewell.unlock.plist
curl "https://raw.github.com/jridgewell/Unlock/objc/files/name.ridgewell.unlock" >> name.ridgewell.unlock

mv ./* /Library/LaunchDaemons/
chown root:wheel /Library/LaunchDaemons/name.ridgewell.unlock.plist
chown root:wheel /Library/LaunchDaemons/name.ridgewell.unlock
chmod 644 /Library/LaunchDaemons/name.ridgewell.unlock.plist
chmod 755 /Library/LaunchDaemons/name.ridgewell.unlock

echo "--------------------------"
echo ""
echo "Installed!"

vname() { echo `diskutil cs info $1 | grep "Volume Name" | cut -d : -f 2 | sed -e 's/^\ *//'`; }
unlock() {
	echo "What is the passphrase used to encrypt ${2}?"
	read password < /dev/tty
	# Add the password to the System keychain
	security add -a "${1}" -D "Encrypted Volume Password" -l "Unlock: ${2}" -s "name.ridgewell.unlock" \
		-w "${password}" -T "" -T "/Library/LaunchDaemons/name.ridgewell.unlock" -U "/Library/Keychains/System.keychain"
}
ask() {
	# Get the name of the volume with UUID
	name=`vname $1`
	echo "Do you want to unlock ${name} at boot? (y/N)"
	read yn < /dev/tty
	# Make user input lowercase
	answer=`echo ${yn}| awk '{print tolower($0)}'`
	if [[ $answer = "y" || $answer = "yes" ]]; then
		unlock $1 $name
	fi
}

if [ -d tmp_install_unlock ]; then
# In case command was exited before
	rm -r tmp_install_unlock
fi
mkdir tmp_install_unlock
cd tmp_install_unlock
boolInstall=false
boolUUID=false
bootUUID=`diskutil cs info \`mount | grep " / " | cut -d " " -f 1\` 2>/dev/null | grep UUID | grep -v LV | cut -d : -f 2 | sed -e 's/^\ *//'`

# http://stackoverflow.com/questions/893585/how-to-parse-xml-in-bash#answer-2608159
rdom() { local IFS=\> ; read -d \< E C ;}
CSVs=`diskutil cs list -plist`
echo $CSVs | while rdom; do
	if [[ $E = "string" ]]; then
	# All the important stuff is inside the "string" elements
		echo "$C"
	fi
done | \
while read LINE; do
# Loop through all found LVGs, LVFs, LVs
	if $boolUUID; then
	# If this is a LV's UUID, ask if they want to unlock it
		if [[ $bootUUID != $LINE ]]; then
		# Don't ask about the boot volume, File Vault will take care of that one
			ask $LINE
		fi
	fi
	if [[ $LINE = "LV" ]]; then
	# If true, the next line will be a LV's UUID
		boolUUID=true
	else
		boolUUID=false
	fi
done

# Cleanup
cd ..
rm -r tmp_install_unlock
