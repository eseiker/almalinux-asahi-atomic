#!/usr/bin/env bash

set -xeuo pipefail

dnf install -y 'dnf-command(copr)' 'dnf-command(config-manager)'
dnf config-manager --set-enabled crb
dnf install -y epel-release
dnf -y copr enable eseiker/asahi-el-kernel
dnf install -y --nogpgcheck kernel-16k
dnf remove -y kernel kernel-core kernel-modules
ostree config set sysroot.bootprefix true
