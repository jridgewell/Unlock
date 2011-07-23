echo "What is the UUID of the drive?"
read uuid
echo "And the passphrase used to encrypt it?"
read password
echo ""
echo "--------------------------"
echo "Installing..."

# Make a temporary directory so that original files are not changed
mkdir ./tmp
cp ./files/* ./tmp/

# Preform some sed jiggery to change required values
sed "s/UUID/$uuid/" ./tmp/unlock.sh > ./tmp/unlock.sh.tmp
rm ./tmp/unlock.sh
sed "s/PASSWORD/$password/" ./tmp/unlock.sh.tmp > ./tmp/unlock.sh
rm ./tmp/unlock.sh.tmp

# Move them to the LaunchDaemons dir, and make sure they have the right permissions
sudo mv ./tmp/* /Library/LaunchDaemons/
sudo chown root:wheel /Library/LaunchDaemons/name.ridgewell.unlock.plist
sudo chown root:wheel /Library/LaunchDaemons/unlock.sh
sudo chmod 644 /Library/LaunchDaemons/name.ridgewell.unlock.plist
sudo chmod 755 /Library/LaunchDaemons/unlock.sh

# Cleanup
rm -r ./tmp