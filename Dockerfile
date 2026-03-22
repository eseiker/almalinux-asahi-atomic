# ba0fde3d-bee7-4307-b97b-17d0d20aff50
ARG BASE_IMAGE=base

# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx

COPY files/system /system_files/
COPY --chmod=0755 files/scripts /build_files/
COPY *.pub /keys/

# Base Image
FROM quay.io/almalinuxorg/almalinux-bootc:10-kitten@sha256:55fa449ca5697eeec17d86fd51707efe4db1c5d44a7d7f6f2f370595c9e507e8 AS base

ARG IMAGE_NAME
ARG IMAGE_REGISTRY

RUN --mount=type=tmpfs,dst=/opt \
    --mount=type=tmpfs,dst=/tmp \
    --mount=type=bind,from=ctx,source=/,target=/ctx \
    /ctx/build_files/build.sh

### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
