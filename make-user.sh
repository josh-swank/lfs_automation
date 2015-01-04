#!/bin/bash

if [ -z "$LFS" ]; then . $(dirname ${BASH_SOURCE[0]})/set-env.sh; fi

groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
passwd lfs

cat > /home/lfs/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat $(dirname ${BASH_SOURCE[0]})/set-env.sh > /home/lfs/.bashrc
cat >> /home/lfs/.bashrc << "EOF"
set +h
umask 022
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=$LFS_TEMP/tools/bin:/bin:/usr/bin
export LC_ALL LFS_TGT PATH
EOF

chmod -v 644 /home/lfs/.bash_profile /home/lfs/.bashrc
chown -v lfs:lfs /home/lfs/.bash_profile /home/lfs/.bashrc
find $LFS_TEMP -name '*' -exec chown -v lfs:lfs {} +
