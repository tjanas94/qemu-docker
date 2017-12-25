ARG PULL_TAG
FROM $PULL_TAG

ARG QEMU_ARCH
COPY download/qemu-${QEMU_ARCH}-static /usr/bin/qemu-${QEMU_ARCH}-static
