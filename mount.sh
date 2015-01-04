#!/bin/bash

if [ -z "$LFS" ]; then . $(dirname ${BASH_SOURCE[0]})/set-env.sh; fi

swapon -v /dev/sda5

mkdir -pv $LFS
mount -vt ext4 /dev/sda6 $LFS
mount -vt ext4 /dev/sda7 $LFS/usr/src
mount -vt ext4 /dev/sda8 $LFS/home
mount -vt ext2 /dev/sda1 $LFS/boot
