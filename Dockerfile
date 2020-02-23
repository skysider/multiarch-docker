FROM phusion/baseimage:master-amd64
MAINTAINER skysider <skysider@163.com>

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
	python3-dev \
	python3-pip \
	socat \
	cmake \
	wget \
	git \
	file \
	ssh \
	tmux \
	libffi-dev \
    libssl-dev \
    build-essential \
	bison \
	libpixman-1-dev \
	flex \
	vim && \
	rm -rf /var/lib/apt/list/*

RUN wget https://download.qemu.org/qemu-4.0.0.tar.xz && \
	tar xvJf qemu-4.0.0.tar.xz && cd qemu-4.0.0 && \ 
	./configure --target-list=aarch64-linux-user,arm-linux-user,armeb-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,mips-linux-user \
		--enable-debug \
		--python=/usr/bin/python3 && \
	make && make install && cd .. && rm -rf qemu-4.0.0

RUN python3 -m pip install -U pip && \
    python3 -m pip install --no-cache-dir \
	pwntools \
	ropper 

RUN wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh

RUN mkdir /etc/qemu-binfmt && \
    ln -s /usr/mipsel-linux-gnu /usr/mipsel-linux-gnu && \
    ln -s /usr/mips-linux-gnu /usr/mips-linux-gnu && \
	ln -s /usr/mips64el-linux-gnuabi64 /usr/mips64el-linux-gnuabi64 && \
	ln -s /usr/mips64-linux-gnuabi64 /usr/mips64-linux-gnuabi64 && \
    ln -s /usr/arm-linux-gnueabi /usr/arm-linux-gnuabihf && \
	ln -s /usr/aarch64-linux-gnu /usr/aarch64-linux-gnu/

WORKDIR /work/

COPY listen_program.sh /work/

CMD ["/sbin/my_init"]
