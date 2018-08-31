FROM phusion/baseimage:latest
MAINTAINER skysider <skysider@163.com>

RUN apt-get -y update && \
		apt-get install -y \
		qemu-user \
		qemu-user-static \
		gdb-multiarch \
		'binfmt*' \
		libc6-mipsel-cross \
		libc6-dbg-mipsel-cross \
		libc6-mips-cross \
		libc6-dbg-mips-cross \
		libc6-mips64el-cross \
		libc6-dbg-mips64el-cross \
		libc6-mips64-cross \
		libc6-dbg-mips64-cross \
		libc6-armel-cross \
		libc6-dbg-armel-cross \
		libc6-armhf-cross \
		libc6-dbg-armhf-cross \
		libc6-arm64-cross \
		libc6-dbg-arm64-cross \
		python3-dev \
		python3-pip \
		cmake \
		socat \
		git \
		file

RUN mkdir /etc/qemu-binfmt && \
    ln -s /usr/mipsel-linux-gnu /etc/qemu-binfmt/mipsel && \
    ln -s /usr/mips-linux-gnu /etc/qemu-binfmt/mips && \
	ln -s /usr/mips64el-linux-gnuabi64 /etc/qemu-binfmt/mips64el && \
	ln -s /usr/mips64-linux-gnuabi64 /etc/qemu-binfmt/mips64 && \
    ln -s /usr/arm-linux-gnueabi /etc/qemu-binfmt/arm && \
	ln -s /usr/aarch64-linux-gnu /etc/qemu-binfmt/aarch64


RUN git clone https://github.com/pwndbg/pwndbg && \
    cd pwndbg && sed -i 's/sudo//g' setup.sh && \
    ./setup.sh && rm -rf /var/lib/apt/list/*

WORKDIR /work/

COPY listen_program.sh .



CMD ["/bin/bash"]
