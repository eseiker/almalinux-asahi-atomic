#!/usr/bin/env bash

set -xeuo pipefail

dnf install -y 'dnf-command(copr)'
dnf -y copr enable eseiker/asahi-el-kernel
dnf install -y kernel-16k kernel-16k-core kernel-16k-modules kernel-16k-modules-extra
