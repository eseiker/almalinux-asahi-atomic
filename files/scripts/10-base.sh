#!/usr/bin/env bash

set -xeuo pipefail

dnf install -y dnf-plugins-core epel-release
dnf config-manager --set-enabled crb
dnf -y update
dnf -y copr enable eseiker/asahi-el-kernel
ostree config set sysroot.bootprefix true
dnf -y swap kernel* kernel-16k --nogpgcheck
# dracut generate initramfs workaround
kver=$(cd /usr/lib/modules && echo *); \
  dracut -vf /usr/lib/modules/$kver/initramfs.img $kver
