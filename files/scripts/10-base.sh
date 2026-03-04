#!/usr/bin/env bash

set -xeuo pipefail

dnf install -y dnf-plugins-core epel-release
dnf config-manager --set-enabled crb
dnf -y copr enable eseiker/asahi-el-kernel
ostree config set sysroot.bootprefix true
rpm-ostree override remove kernel kernel-core kernel-modules --install kernel-16k
