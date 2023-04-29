ARG DISTRO
ARG KERNEL

FROM ubuntu:$DISTRO

ARG DISTRO
ARG KERNEL
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install -y make \
        dwarfdump \
        flex \
        bison \
        golang \
        git \
        zip \
        wget \
	lsb-core \
        build-essential \
        libssl-dev \
        libelf-dev \
        linux-image-$KERNEL \
        linux-headers-$KERNEL

RUN mkdir -p /workspace
WORKDIR /workspace

RUN git clone --depth 1 --branch master https://github.com/volatilityfoundation/volatility.git && \
    cd ./volatility/tools/linux && \
	sed -i 's/$(shell uname -r)/'$KERNEL'/g' Makefile && \
	echo 'MODULE_LICENSE("GPL");' >> module.c && \
    make && \
    zip ../../../$(lsb_release -i -s)-$KERNEL-profile.zip ./module.dwarf /boot/System.map-$KERNEL

