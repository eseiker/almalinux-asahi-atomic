#!/usr/bin/env bash

set -xeuo pipefail

ostree config set sysroot.bootprefix true

dnf -y install dnf-plugins-core
dnf -y copr enable eseiker/asahi-el-kernel
dnf -y swap kernel* kernel-16k
dnf -y install kernel-16k-modules-extra systemd-boot-unsigned system-reinstall-bootc @core
dnf -y update

# dracut generate initramfs workaround
kver=$(cd /usr/lib/modules && echo *); \
  dracut --no-hostonly --reproducible --show-modules --uefi -vf /usr/lib/modules/$kver/initramfs.img $kver
