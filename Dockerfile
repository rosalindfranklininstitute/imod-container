ARG UBUNTU_VERSION=24.04
FROM ubuntu:${UBUNTU_VERSION}

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/London
ARG IMOD_VERSION=5.1.13

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates file curl default-jre gdb tcsh python3 python-is-python3 \
    locales \
    mesa-common-dev mesa-utils libglu1-mesa-dev libharfbuzz-bin libice6 \
    libsm-dev libxkbcommon-x11-0 libxcb-image0 libxcb-render-util0 \
    libxcb-shape0 libxcb-xkb1 libgl1 libegl1 libxv1 \
    && sed -i 's/^# *\(en_GB.UTF-8\)/\1/' /etc/locale.gen \
    && locale-gen \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY imod_${IMOD_VERSION}_RHEL8-64_CUDA12.0.sh /tmp/
RUN cd /tmp \
    && sh imod_${IMOD_VERSION}_RHEL8-64_CUDA12.0.sh -y -dir /opt -debian \
    && rm imod_${IMOD_VERSION}_RHEL8-64_CUDA12.0.sh

ENV IMOD_DIR=/opt/imod_${IMOD_VERSION}
ENV PATH=$PATH:${IMOD_DIR}/bin
