# ba0fde3d-bee7-4307-b97b-17d0d20aff50
ARG BASE_IMAGE=base

# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx

COPY files/system /system_files/
COPY --chmod=0755 files/scripts /build_files/
COPY *.pub /keys/

# Base Image
FROM quay.io/almalinuxorg/almalinux-bootc:10@sha256:4863f407b3a99f11dadd69c4798d161e0cf51f1b2ccda58ff62db0021758d334 AS base

ARG IMAGE_NAME
ARG IMAGE_REGISTRY

RUN --mount=type=tmpfs,dst=/opt \
    --mount=type=tmpfs,dst=/tmp \
    --mount=type=bind,from=ctx,source=/,target=/ctx \
    /ctx/build_files/build.sh

### LINTING
## Verify final image and contents are correct.
RUN bootc container lint

# Installer Image
FROM ${BASE_IMAGE} AS anaconda

# https://osbuild.org/docs/developer-guide/projects/image-builder/usage/#bootc-installer-payload-ref
RUN dnf install -y --setopt=install_weak_deps=False \
    anaconda \
    anaconda-install-env-deps \
    anaconda-dracut \
    dracut-config-generic \
    dracut-network \
    net-tools \
    squashfs-tools \
    python3-mako \
    lorax-templates-* \
    prefixdevname \
    grub2-efi-aa64-cdboot \
    && dnf reinstall -y shim-aa64 \
    && dnf clean all

RUN mkdir -p /boot/efi && cp -ra /usr/lib/efi/*/*/EFI /boot/efi || true
RUN mkdir /var/mnt

FROM base
