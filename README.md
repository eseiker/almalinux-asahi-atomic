# AlmaLinux Asahi bootc (ARM64)

## Base image

This respin uses the minimal bootc image `quay.io/almalinuxorg/almalinux-bootc:10`(https://github.com/AlmaLinux/bootc-images). The base image signature is verified
with the Cosign public key stored as [`bootc-images.pub`](bootc-images.pub); update this file and the workflow
reference if the upstream key changes.

## Building

Use `make image` to build the base bootc image with `Dockerfile`. To build the installer (anaconda) variant, use `make image-anaconda`; it reuses the base image you just built (override with `BASE_IMAGE=<ref>` if you want to point at a different tag).

## Resources

- [AlmaLinux Atomic Respin Template](https://github.com/AlmaLinux/atomic-respin-template)
- [AlmaLinux Atomic SIG](https://wiki.almalinux.org/sigs/Atomic.html)
- [AlmaLinux bootc images](https://github.com/AlmaLinux/bootc-images)
- [bootc documentation](https://github.com/containers/bootc)
- [Podman documentation](https://podman.io/)
- [QEMU documentation](https://www.qemu.org/)
