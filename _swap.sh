#!/usr/bin/env bash
add_swap(){
#check if exists swapfile
grep -q "swapfile" /etc/fstab

#if exists, delete it first.
if [ $? -eq 0 ]; then
        echo "Swapfile found, deleting..."
        sed -i '/swapfile/d' /etc/fstab
        echo "3" > /proc/sys/vm/drop_caches
        swapoff -a
        rm -f /swapfile
    echo "Swapfile deleted!"
fi

grep -q "swapfile" /etc/fstab
#if does not exist, create /swapfile
if [ $? -ne 0 ]; then
        echo "Swapfile not found, creating swapfile"
        fallocate -l $(( ($(getconf _PHYS_PAGES) * $(getconf PAGE_SIZE)/(512)) )) /swapfile
        chmod 600 /swapfile
        mkswap /swapfile
        swapon /swapfile
        echo '/swapfile none swap defaults 0 100' >> /etc/fstab
         echo "Swapfile successful created, checking information:"
         cat /proc/swaps
         cat /proc/meminfo | grep Swap
fi
}

del_swap(){
#check if swapfile exist
grep -q "swapfile" /etc/fstab

#if exists, delete it first.
if [ $? -eq 0 ]; then
        echo "Swapfile found, deleting..."
        sed -i '/swapfile/d' /etc/fstab
        echo "3" > /proc/sys/vm/drop_caches
        swapoff -a
        rm -f /swapfile
    echo -e "Swapfile deleted!"
else
        echo -e "Swapfile not found，swap delete failed！"
fi
}

#Start
add_swap
