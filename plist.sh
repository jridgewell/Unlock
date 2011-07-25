#!/bin/bash
if [ "`whoami`" != "root" ]
	then
		# Run as root to avoid Console logging sudo commands.
		echo "Attempting to re-run as root..."
		sudo bash ./plist.sh
		exit
fi

vname() { echo `diskutil cs info $1 | grep "Volume Name" | cut -d : -f 2 | sed -e 's/^\ *//'` ;}
unlock() {
	echo "What is the passphrase used to encrypt ${2}"
	read password < /dev/tty
	# Add the password to the System keychain
	security add -a "${1}" -D "Encrypted Volume Password" -l "Unlock: ${2}" -s "name.ridgewell.unlock" \
		-w "${password}" -T "/usr/bin/security" -U "/Library/Keychains/System.keychain"
	echo ""
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
}

bool=false

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
#rm LVs.txt
