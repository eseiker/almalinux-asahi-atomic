# ba0fde3d-bee7-4307-b97b-17d0d20aff50
ARG BASE_IMAGE=base

# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx

COPY files/system /system_files/
COPY --chmod=0755 files/scripts /build_files/
COPY *.pub /keys/

# Base Image
FROM quay.io/almalinuxorg/almalinux-bootc:10@sha256:e42c37e678916335c65e8fdd53c93d50ea20d02846eece96219bccf63105bcd8 AS base

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
FROM ${BASE_IMAGE} AS installer

# https://osbuild.org/docs/developer-guide/projects/image-builder/usage/#bootc-installer-payload-ref
RUN dnf install -y \
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
    shim-unsigned-aarch64 \
    && dnf clean all

RUN mkdir -p /var/mnt /usr/lib/ostree-boot/efi/EFI/almalinux/ \
    && cp -ra /boot/* /usr/lib/ostree-boot/ \
    && cp -a /usr/share/shim/*/aa64/* /usr/lib/ostree-boot/efi/EFI/almalinux/ \
    && rm -rf /boot \
    && ln -s /usr/lib/ostree-boot/ /boot

FROM base
