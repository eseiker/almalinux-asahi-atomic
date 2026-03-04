#!/usr/bin/env bash

set -xeuo pipefail

dnf -y install dnf-plugins-core epel-release
dnf config-manager --set-enabled crb
dnf -y update

ostree config set sysroot.bootprefix true
dnf -y copr enable eseiker/asahi-el-kernel
dnf -y swap kernel* kernel-16k --nogpgcheck

# dracut generate initramfs workaround
kver=$(cd /usr/lib/modules && echo *); \
  dracut -vf /usr/lib/modules/$kver/initramfs.img $kver

dnf -y install system-reinstall-bootc
