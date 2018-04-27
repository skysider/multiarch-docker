FROM phusion/baseimage:latest
MAINTAINER skysider <skysider@163.com>

RUN apt-get -y update && \
		apt-get install -y \
		qemu \
		qemu-user \
		qemu-user-static \
		gdb-multiarch \
		'binfmt*' \
		libc6-mipsel-cross \
		libc6-dbg-mipsel-cross \
		libc6-armhf-armel-cross \
		libc6-dbg-armhf-cross \
		gcc-arm-linux-gnueabi \
		gcc-arm-linux-gnueabihf \
		gcc-mips-linux-gnu \
		g++-mips-linux-gnu \
		gcc-mipsel-linux-gnu \
		g++-mipsel-linux-gnu \
		python3-dev \
		python3-pip \
		cmake \
		socat \
		git

RUN mkdir /etc/qemu-binfmt && \
    ln -s /usr/mipsel-linux-gnu /etc/qemu-binfmt/mipsel && \
    ln -s /usr/mips-linux-gnu /etc/qemu-binfmt/mips && \
    ln -s /usr/arm-linux-gnueabihf /etc/qemu-binfmt/arm

RUN git clone https://github.com/pwndbg/pwndbg && \
    cd pwndbg && sed -i 's/sudo//g' setup.sh && \
    ./setup.sh && rm -rf /var/lib/apt/list/*

WORKDIR /work/

CMD ["/bin/bash"]
