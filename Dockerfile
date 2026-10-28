ARG UBUNTU_VERSION=24.04
FROM ubuntu:${UBUNTU_VERSION} AS imod

ARG UBUNTU_VERSION
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

RUN cd /tmp \
    && curl -fsSL -O "${IMOD_URL}" \
    && INSTALLER="$(basename "${IMOD_URL}")" \
    && sh "${INSTALLER}" -y -dir /opt -debian \
    && rm "${INSTALLER}"

ENV IMOD_DIR=/opt/imod_${IMOD_VERSION}
ENV PATH=$PATH:${IMOD_DIR}/bin \
    QT_X11_NO_MITSHM=1 \
    QT_LOGGING_RULES="qt.qpa.xcb.warning=false" 

ARG IMAGE_VERSION="${IMOD_VERSION}-cuda${CUDA_VERSION}"
ARG IMAGE_REVISION=""
ARG IMAGE_CREATED=""

LABEL org.opencontainers.image.title="RFI/CCP-volumeEM IMOD" \
      org.opencontainers.image.description="Ubuntu container with IMOD (3dmod, etomo)" \
      org.opencontainers.image.authors="The Rosalind Franklin Institute, The Collaborative Computational Project for Volume Electron Microscopy" \
      org.opencontainers.image.source="https://github.com/rosalindfranklininstitute/imod-container" \
      org.opencontainers.image.documentation="https://rosalindfranklininstitute.github.io/volume-em-container-documentation/software/imod/" \
      org.opencontainers.image.licenses="GPL-2.0-only" \
      org.opencontainers.image.base.name="docker.io/library/ubuntu:${UBUNTU_VERSION}" \
      org.opencontainers.image.version="${IMAGE_VERSION}" \
      org.opencontainers.image.revision="${IMAGE_REVISION}" \
      org.opencontainers.image.created="${IMAGE_CREATED}" \
      uk.ac.rfi.imod.version="${IMOD_VERSION}" \
      uk.ac.rfi.imod.cuda.version="${CUDA_VERSION}" \
      uk.ac.rfi.imod.rhel.version="${RHEL_VERSION}"
