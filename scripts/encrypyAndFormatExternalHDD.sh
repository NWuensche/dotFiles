#!/bin/sh
set -e
sed -e 's/\s*\([+0-9a-zA-Z]*\).*/\1/' << EOF | sudo fdisk /dev/sdb
  o # clear current table (root)
  n # new partition (LVM - Rest)
  p # primary
  1 # number 1
    # default - start at beginning of disk
    # default - till the end of disk
  w # write
EOF

#If error here, delete partition with gparted first and unmount HDD
sudo cryptsetup -y -v luksFormat --type luks2 /dev/sdb1

sudo cryptsetup open /dev/sdb1 usbenc

echo Y | sudo mkfs.ext4 /dev/mapper/usbenc

echo "Also do last line script after remount to make HDD writeable"
#sudo chown -R $USER /run/media/$USER/20118cj7-33b1-4f38-bbf5-94a58dee2751



