FROM ubuntu:24.04 as imod

ARG IMOD_VERSION=5.1.13
ARG CUDA_VERSION=12.0
ARG RHEL_VERSION=8-64
ARG IMOD_URL=https://bio3d.colorado.edu/imod/AMD64-RHEL5/imod_${IMOD_VERSION}_RHEL${RHEL_VERSION}_CUDA${CUDA_VERSION}.sh
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/London


RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates file curl default-jre gdb tcsh python3 python-is-python3 \
    locales \
    mesa-common-dev mesa-utils libglu1-mesa-dev libharfbuzz-bin libice6 \
    libsm-dev libxkbcommon-x11-0 libxcb-image0 libxcb-render-util0 \
    libxcb-shape0 libxcb-xkb1 libgl1 libegl1 libxv1 \
    && sed -i 's/^# *\(en_GB.UTF-8\)/\1/' /etc/locale.gen \
    && locale-gen \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


RUN curl -fsSL -o /tmp/imod.sh "${IMOD_URL}" \
    && sh /tmp/imod.sh -y -dir /opt -debian \
    && rm /tmp/imod.sh

ENV IMOD_DIR=/opt/imod_${IMOD_VERSION}
ENV PATH=$PATH:${IMOD_DIR}/bin
ENV QT_X11_NO_MITSHM=1
ENV QT_LOGGING_RULES="qt.qpa.xcb.warning=false" 

LABEL org.opencontainers.image.title="RFI IMOD"
LABEL org.opencontainers.image.description="Ubuntu container with IMOD (3dmod, etomo)"
LABEL org.opencontainers.image.version="RHEL${RHEL_VERSION}_IMOD${IMOD_VERSION}_CUDA${CUDA_VERSION}"
LABEL org.opencontainers.image.authors="The Rosalind Franklin Institute"
LABEL org.opencontainers.image.source="https://github.com/rosalindfranklininstitute/imod-container"
LABEL org.opencontainers.image.licenses="GPL-2.0"
