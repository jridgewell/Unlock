#!/bin/bash
if [ "`whoami`" != "root" ]
	then
		# Run as root to avoid Console logging sudo commands.
		echo "Attempting to re-run as root..."
		curl https://raw.github.com/jridgewell/Unlock/dynamic/install.sh -o install.sh
		chmod +x install.sh
		echo ""
		sudo bash ./install.sh
		rm install.sh
        # sudo bash ./plist.sh
		exit
fi

vname() { echo `diskutil cs info $1 | grep "Volume Name" | cut -d : -f 2 | sed -e 's/^\ *//'` ;}
unlock() {
	echo "What is the passphrase used to encrypt ${2}"
	read password < /dev/tty
	# Add the password to the System keychain
	security add -a "${1}" -D "Encrypted Volume Password" -l "Unlock: ${2}" -s "name.ridgewell.unlock" \
		-w "${password}" -T "" -T "/usr/bin/security" -U "/Library/Keychains/System.keychain"
	echo $1 >> "UUIDs.txt"
}
ask() {
	# Get the name of the volume with UUID
	name=`vname $1`
    echo "Do you want to unlock ${name} at boot? (y/N)"
	read yn < /dev/tty
	# Make user input lowercase
    answer=`echo ${yn}| awk '{print tolower($0)}'`
    if [[ $answer == "y" || $answer == "yes" ]]
        then
            unlock $1 $name
    fi
	echo ""
}

bool=false
mkdir tmp_install_unlock
cd tmp_install_unlock

# http://stackoverflow.com/questions/893585/how-to-parse-xml-in-bash#answer-2608159
rdom() { local IFS=\> ; read -d \< E C ;}
CSVs=`diskutil cs list -plist`
echo $CSVs | while rdom; do
	# All the important stuff is inside the "string" elements
    if [[ $E = string ]]; then
        echo "$C"
    fi
done | \
while read LINE; do
# Loop through all found LVGs, LVFs, LVs
    if $bool
    	# If this is a LV's UUID, ask if they want to unlock it
        then
            ask $LINE
    fi
    if [[ $LINE == "LV" ]]
    	# If true, the next line will be the LV's UUID
        then
            bool=true
        else
            bool=false
    fi
done
if [ -e "UUIDs.txt" ]
    then
        echo "--------------------------"
        echo "Installing..."
        curl "https://raw.github.com/jridgewell/Unlock/master/files/name.ridgewell.unlock.plist" -o name.ridgewell.unlock.plist
        curl "https://raw.github.com/jridgewell/Unlock/dynamic/files/name.ridgewell.unlock-start.sh" >> name.ridgewell.unlock.sh
        while read LINE; do
            echo "      diskutil cs unlockVolume UUID -passphrase \"\`security 2>&1 >/dev/null find -ga UUID \"/Library/Keychains/System.keychain\" | cut -d '\"' -f 2\`\" 2>/dev/null" | sed "s/UUID/$LINE/g" >> name.ridgewell.unlock.sh
        done
        curl "https://raw.github.com/jridgewell/Unlock/dynamic/files/name.ridgewell.unlock-end.sh" >> name.ridgewell.unlock.sh
        rm "UUIDs.txt"
        
        mv ./* /Library/LaunchDaemons/
        chown root:wheel /Library/LaunchDaemons/name.ridgewell.unlock.plist
        chown root:wheel /Library/LaunchDaemons/name.ridgewell.unlock.sh
        chmod 644 /Library/LaunchDaemons/name.ridgewell.unlock.plist
        chmod 755 /Library/LaunchDaemons/name.ridgewell.unlock.sh

        # Cleanup
        cd ..
        rm -r tmp_install_unlock

        echo ""
        echo "--------------------------"
        echo "Installed!"
fi