#!/usr/bin/env bash

#root permission
root_need(){
    if [[ $EUID -ne 0 ]]; then
        echo "Error:This script must be run as root!"
        exit 1
    fi
}

#check ovz
ovz_no(){
    if [[ -d "/proc/vz" ]]; then
        echo "Your VPS is based on OpenVZ，not supported!"
        exit 1
    fi
}

add_swap(){
#check if exists swapfile
grep -q "swapfile" /etc/fstab

#if exists, delete it first.
if [ $? -eq 0 ]; then
        echo "swapfile found, deleting..."
        sed -i '/swapfile/d' /etc/fstab
        echo "3" > /proc/sys/vm/drop_caches
        swapoff -a
        rm -f /swapfile
    echo "swapfile deleted!"
fi

grep -q "swapfile" /etc/fstab
#if does not exist, create /swapfile
if [ $? -ne 0 ]; then
        echo "Swapfile not found, creating swapfile"
        sudo fallocate -l $(( $(getconf _PHYS_PAGES) * $(getconf PAGE_SIZE)/(1024*512) ))M /swapfile
        chmod 600 /swapfile
        mkswap /swapfile
        swapon /swapfile
        echo '/swapfile none swap defaults 0 100' >> /etc/fstab
         echo "swapfile successful created, checking information:"
         cat /proc/swaps
         cat /proc/meminfo | grep Swap
fi
}

del_swap(){
#check if swapfile exist
grep -q "swapfile" /etc/fstab

#if exists, delete it first.
if [ $? -eq 0 ]; then
        echo -e "${Green}swapfile found, deleting...${Font}"
        sed -i '/swapfile/d' /etc/fstab
        echo "3" > /proc/sys/vm/drop_caches
        swapoff -a
        rm -f /swapfile
    echo -e "${Green}swapfile deleted！${Font}"
else
        echo -e "${Red}swapfile not found，swap delete failed！${Font}"
fi
}

#Start
main(){
root_need
ovz_no
add_swap
}

main