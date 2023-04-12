# create a 8G bigger swap partition
sudo sh _swap.sh
sudo apt install locales-all
sudo locale-gen es_ES.UTF-8
sudo update-locale LANG=es_ES.UTF-8
sudo apt update && sudo apt upgrade
sudo reboot
#after reboot run install2.sh
