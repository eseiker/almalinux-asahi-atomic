#!/usr/bin/env bash

set -xeuo pipefail

dnf install -y 'dnf-command(copr)' 'dnf-command(config-manager)'
dnf config-manager --set-enabled crb
dnf install -y epel-release
dnf -y copr enable eseiker/asahi-el-kernel
dnf install -y kernel-16k kernel-16k-core kernel-16k-modules kernel-16k-modules-extra
sudo ostree config set sysroot.bootprefix true
