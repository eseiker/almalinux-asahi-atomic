#!/usr/bin/env bash

set -xeuo pipefail

dnf -y install initial-setup
systemctl enable initial-setup.service
