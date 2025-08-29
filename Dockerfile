ARG UBUNTU_VERSION=24.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/London

FROM ubuntu:${UBUNTU_VERSION}

##########################################
# Arguments
##########################################

# Requirements for IMOD
## IMOD Requirments (https://bio3d.colorado.edu/imod/doc/guide.html#SettingUpLinux)
ARG CURL_VERSION="8.5.0-2ubuntu10.6" # https://packages.ubuntu.com/noble/curl
ARG DEFAULT_JRE_VERSION="2:1.21-75+exp1" # https://packages.ubuntu.com/noble/default-jre
ARG TCSH_VERSION="6.24.10-4build1" # https://packages.ubuntu.com/noble/tcsh
ARG PYTHON_VERSION="3.12.3-0ubuntu2" # https://packages.ubuntu.com/noble/python3
ARG PYTHON_IS_PYTHON3_VERSION="3.11.4-1" # https://packages.ubuntu.com/noble/python-is-python3
## Getting QT5 to work https://bio3d.colorado.edu/imod/doc/guide.html#UsingBashOnWin
ARG MESA_COMMON_DEV_VERSION="24.0.5-1ubuntu1" # https://packages.ubuntu.com/noble/mesa-common-dev
ARG LIBGLU1_MESA_DEV_VERSION="9.0.2-1.1build1" # https://packages.ubuntu.com/noble/libglu1-mesa-dev
ARG LIBHARFBUZZ_BIN_VERSION="8.3.0-2build2" # https://packages.ubuntu.com/noble/libharfbuzz-bin
ARG LIBICE6_VERSION="2:1.0.10-1build3" # https://packages.ubuntu.com/noble/libice6
ARG LIBSM_DEV_VERSION="2:1.2.3-1build3" # https://packages.ubuntu.com/noble/libsm-dev
ARG LIBXKBCOMMON_X11_0_VERSION="1.6.0-1build1" # https://packages.ubuntu.com/noble/libxkbcommon-x11-0
ARG LIBXCB_IMAGE0_VERSION="0.4.0-2build1" # https://packages.ubuntu.com/noble/libxcb-image0
ARG LIBXCB_RENDER_UTIL0_VERSION="0.3.9-1build4" # https://packages.ubuntu.com/noble/libxcb-render-util0
ARG LIBXCB_SHAPE0_VERSION="1.15-1ubuntu2" # https://packages.ubuntu.com/noble/libxcb-shape0
ARG LIBXCB_XKB1_VERSION="1.15-1ubuntu2" # https://packages.ubuntu.com/noble/libxcb-xkb1

# IMOD Requirments (https://bio3d.colorado.edu/imod/doc/guide.html#SettingUpLinux)
RUN apt-get -y update && apt-get install -y --no-install-recommends \
    curl=${CURL_VERSION} \
    default-jre=${DEFAULT_JRE_VERSION} \
    tcsh=${TCSH_VERSION} \
    python3=${PYTHON_VERSION} \
    python-is-python3=${PYTHON_IS_PYTHON3_VERSION} \
    # Getting QT5 to work https://bio3d.colorado.edu/imod/doc/guide.html#UsingBashOnWin
    mesa-common-dev=${MESA_COMMON_DEV_VERSION} \
    libglu1-mesa-dev=${LIBGLU1_MESA_DEV_VERSION} \
    libharfbuzz-bin=${LIBHARFBUZZ_BIN_VERSION} \
    libice6=${LIBICE6_VERSION} \
    libsm-dev=${LIBSM_DEV_VERSION} \
    libxkbcommon-x11-0=${LIBXKBCOMMON_X11_0_VERSION} \
    libxcb-image0=${LIBXCB_IMAGE0_VERSION} \
    libxcb-render-util0=${LIBXCB_RENDER_UTIL0_VERSION} \
    libxcb-shape0=${LIBXCB_SHAPE0_VERSION} \
    libxcb-xkb1=${LIBXCB_XKB1_VERSION} \
    # Clean up and remove cache to reduce the image size.
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download and install Imod
RUN  curl -o imod_5.1.2.sh -L https://bio3d.colorado.edu/imod/AMD64-RHEL5/imod_5.1.2_RHEL8-64_CUDA12.0.sh \
     && sh imod_5.1.2.sh -y -dir /opt -debian \
     && rm imod_5.1.2.sh

ENV PATH=$PATH:/opt/imod_5.1.2/bin
ENV IMOD_DIR=/opt/imod_5.1.2
