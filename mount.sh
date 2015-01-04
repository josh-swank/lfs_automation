#!/bin/bash

if [ -z "$LFS_ROOT_DEV" ]; then . $(dirname ${BASH_SOURCE[0]})/config; fi

mkdir -pv $LFS
mount -vt $LFS_ROOT_TYPE $LFS_ROOT_DEV $LFS

for dev in "${LFS_SWAP_DEV[@]}"; do
  swapon -v $dev
done
for i in $(seq 1 ${#LFS_MOUNT_DEV[@]}); do
  mkdir -pv ${LFS_MOUNT[$i]}
  mount -vt ${LFS_MOUNT_TYPE[$i]} ${LFS_MOUNT_DEV[$i]} ${LFS_MOUNT[$i]}
done
