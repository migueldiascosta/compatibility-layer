#!/bin/bash

export EESSI_PILOT_VERSION=2020.10
export EPREFIX=/eessi/$EESSI_PILOT_VERSION/compat/x86_64

echo "Installing Gentoo Prefix in $EPREFIX..."
export PYTHON_TARGETS="python3_7"
export SNAPSHOT_URL="http://cvmfs-s0.eessi-hpc.org/snapshots"
export CUSTOM_SNAPSHOT="portage-20201028.tar.bz2"
singularity run -B /eessi:/eessi docker://eessi/bootstrap-prefix:centos8-$(uname -m)
sed -i 's|/cvmfs/pilot.eessi-hpc.org|/eessi|' scripts/prefix-symlink-host-paths.sh
scripts/prefix-symlink-host-paths.sh

echo >> $EPREFIX/etc/locale.gen <<EOF
C.UTF-8 UTF-8
en_US.UTF-8 UTF-8
en_GB.UTF-8 UTF-8
en_SG.UTF-8 UTF-8
EOF

echo "Starting prefix..."
${EPREFIX}/startprefix
locale-gen


