ARG DISTRO_VER
ARG KERNEL_VER
ARG DEBIAN_FRONTEND=noninteractive

FROM ubuntu:$DISTRO_VER


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
        linux-image-$KERNEL_VER \
        linux-headers-$KERNEL_VER

RUN mkdir -p /workspace
WORKDIR /workspace

RUN git clone --depth 1 --branch master https://github.com/volatilityfoundation/volatility.git && \
    cd ./volatility/tools/linux && \
	sed -i 's/$(shell uname -r)/'$KERNEL_VER'/g' Makefile && \
	echo 'MODULE_LICENSE("GPL");' >> module.c && \
    make && \
    zip ../../../$(lsb_release -i -s)-$KERNEL_VER-profile.zip ./module.dwarf /boot/System.map-$KERNEL_VER

