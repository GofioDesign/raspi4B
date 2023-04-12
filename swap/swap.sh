#!/usr/bin/env bash
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
        fallocate -l $(( ($(getconf _PHYS_PAGES) * $(getconf PAGE_SIZE)/(1024*512)) )) /swapfile
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
add_swap