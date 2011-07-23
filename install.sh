sudo mv ./name.ridgewell.unlock.plist /Library/LaunchDaemons/
sudo mv ./unlock.sh /Library/LaunchDaemons/
sudo chown root:wheel /Library/LaunchDaemons/name.ridgewell.unlock.plist
sudo chown root:wheel /Library/LaunchDaemons/unlock.sh
sudo chmod 644 /Library/LaunchDaemons/name.ridgewell.unlock.plist
sudo chmod 744 /Library/LaunchDaemons/unlock.sh