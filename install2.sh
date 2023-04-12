# locale # check locale was succesful
echo "trying distro upgrade"
sleep 2
sudo apt dist-upgrade
sudo apt full-upgrade
echo "trying bootloader upgrade"
sleep 2
sudo rpi-eeprom-update
echo "going for docker"
sudo sh install3.sh

