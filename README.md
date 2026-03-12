# AlmaLinux Asahi bootc (ARM64)

## Base image

This respin uses the minimal bootc image
`quay.io/almalinuxorg/almalinux-bootc:10-kitten`(https://github.com/AlmaLinux/bootc-images).
The base image signature is verified with the Cosign public key stored as
[`bootc-images.pub`](bootc-images.pub);
update this file and the workflow reference if the upstream key changes.

## Resources

- [AlmaLinux Atomic Respin Template](https://github.com/AlmaLinux/atomic-respin-template)
- [AlmaLinux Atomic SIG](https://wiki.almalinux.org/sigs/Atomic.html)
- [AlmaLinux bootc images](https://github.com/AlmaLinux/bootc-images)
- [Asahi Linux](https://asahilinux.org/)
- [bootc](https://github.com/bootc-dev/bootc)
