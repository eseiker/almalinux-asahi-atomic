#!/usr/bin/env bash

set -xeuo pipefail

dnf -y install dnf-plugins-core epel-release
dnf -y update

dnf -y copr enable eseiker/asahi-el-kernel
dnf -y swap kernel* kernel-16k
dnf -y install kernel-16k-modules-extra @core @networkmanager-submodules

dnf -y copr enable eseiker/asahi
dnf -y copr enable @centoshyperscale/asahi
dnf -y copr enable @asahi/u-boot
dnf -y install asahi-scripts asahi-fwupdate dracut-asahi linux-firmware-vendor update-m1n1 asahi-battery asahi-audio mesa-vulkan-drivers

dnf -y update

# dracut generate initramfs workaround
kver=$(cd /usr/lib/modules && echo *); \
  dracut --no-hostonly --reproducible -vf /usr/lib/modules/$kver/initramfs.img $kver
