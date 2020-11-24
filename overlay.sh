#!/bin/bash

export EESSI_PILOT_VERSION=2020.10
export EPREFIX=/eessi/$EESSI_PILOT_VERSION/compat/x86_64

echo "Installing Gentoo Prefix in $EPREFIX..."
export PYTHON_TARGETS="python3_7"

echo "Installing EESSI Gentoo overlay..."
mkdir -p ${EPREFIX}/etc/portage/repos.conf
emerge eselect-repository
eselect repository add eessi git https://github.com/EESSI/gentoo-overlay.git
emerge --sync eessi
mkdir ${EPREFIX}/etc/portage/sets/
ln -s  ${EPREFIX}/var/db/repos/eessi/etc/portage/sets/$EESSI_PILOT_VERSION ${EPREFIX}/etc/portage/sets/
emerge @$EESSI_PILOT_VERSION

