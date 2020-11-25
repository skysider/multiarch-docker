FROM phusion/baseimage:master-amd64
MAINTAINER skysider <skysider@163.com>

ENV QEMU_VERSION 5.1.0

RUN apt-get -y update && \
	apt-get install -y \
        pkg-config \
	libglib2.0-dev \
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
	gcc-arm-linux-gnueabi \
	gcc-arm-linux-gnueabihf \
	gcc-aarch64-linux-gnu \
	gcc-mips-linux-gnu \
	gcc-mipsel-linux-gnu \
	gcc-mips64-linux-gnuabi64 \
	gcc-mips64el-linux-gnuabi64 \
	python3-dev \
	python3-pip \
	cmake \
	socat \
	wget \
	git \
	file  \
	flex \
	bison \
	libpixman-1-dev && \
	rm -rf /var/lib/apt/list/*

RUN wget https://download.qemu.org/qemu-${QEMU_VERSION}.tar.xz && \
	tar xvJf qemu-${QEMU_VERSION}.tar.xz && cd qemu-${QEMU_VERSION} && \ 
	./configure --target-list=aarch64-linux-user,arm-linux-user,armeb-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,mips-linux-user --enable-debug --python=/usr/bin/python3 && \
	make && make install && cd .. && rm -rf qemu-${QEMU_VERSION}

RUN python3 -m pip install -U pip && \
    python3 -m pip install --no-cache-dir \
	pwntools \
	ropper 

RUN wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh

RUN mkdir /usr/gnemul && \
    ln -s /usr/mipsel-linux-gnu /usr/gnemul/qemu-mipsel && \
    ln -s /usr/mips-linux-gnu /usr/gnemul/qemu-mips && \
	ln -s /usr/mips64el-linux-gnuabi64 /usr/gnemul/qemu-mips64el && \
	ln -s /usr/mips64-linux-gnuabi64 /usr/gnemul/qemu-mips64 && \
    ln -s /usr/arm-linux-gnueabi /usr/gnemul/qemu-arm && \
	ln -s /usr/aarch64-linux-gnu /usr/gnemul/qemu-aarch64

WORKDIR /work/

COPY listen_program.sh /work/

CMD ["/sbin/my_init"]
