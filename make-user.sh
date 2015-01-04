#!/bin/bash

if [ -z "$LFS_ROOT_DEV" ]; then . $(dirname ${BASH_SOURCE[0]})/config; fi

groupadd $LFS_GROUP
useradd -s /bin/bash -g $LFS_GROUP -m -k /dev/null $LFS_USER
passwd $LFS_USER

cat > /home/$LFS_USER/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

echo ". $LFS_WORK_ENV/config" > /home/$LFS_USER/.bashrc
cat >> /home/$LFS_USER/.bashrc << "EOF"
set +h
umask 022
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=$LFS_WORK_ENV/bin:/bin:/usr/bin
export LC_ALL LFS_TGT PATH
EOF

chmod -v 644 /home/$LFS_USER/.bash_profile /home/$LFS_USER/.bashrc
chown -v $LFS_USER:$LFS_GROUP /home/$LFS_USER/.bash_profile /home/$LFS_USER/.bashrc
find $LFS_TEMP -name '*' -exec chown -v $LFS_USER:$LFS_GROUP {} +
