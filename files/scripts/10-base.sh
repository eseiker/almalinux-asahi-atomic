#!/usr/bin/env bash

set -xeuo pipefail

dnf -y install dnf-plugins-core epel-release
dnf config-manager --set-enabled crb
dnf -y update

ostree config set sysroot.bootprefix true
dnf -y copr enable eseiker/asahi-el-kernel
dnf -y --nogpgcheck swap kernel* kernel-16k

# dracut generate initramfs workaround
kver=$(cd /usr/lib/modules && echo *); \
  dracut -vf /usr/lib/modules/$kver/initramfs.img $kver

dnf -y --nogpgcheck --setopt=install_weak_deps=False install system-reinstall-bootc @core
