#!/usr/bin/env bash

set -xeuo pipefail

dnf install -y 'dnf-command(copr)'
dnf -y copr enable eseiker/asahi-el-kernel
dnf install -y kernel kernel-core kernel-modules kernel-modules-extra
