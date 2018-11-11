FROM ubuntu:18.04
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
	socat \
	wget \
	git \
	file \
	ssh \
	python \
	tmux \
	libffi-dev \
    libssl-dev \
    python-dev \
    build-essential \
	vim && \
	rm -rf /var/lib/apt/list/*

RUN mkdir /etc/qemu-binfmt && \
    ln -s /usr/mipsel-linux-gnu /etc/qemu-binfmt/mipsel && \
    ln -s /usr/mips-linux-gnu /etc/qemu-binfmt/mips && \
	ln -s /usr/mips64el-linux-gnuabi64 /etc/qemu-binfmt/mips64el && \
	ln -s /usr/mips64-linux-gnuabi64 /etc/qemu-binfmt/mips64 && \
    ln -s /usr/arm-linux-gnueabi /etc/qemu-binfmt/arm && \
	ln -s /usr/aarch64-linux-gnu /etc/qemu-binfmt/aarch64

RUN wget https://bootstrap.pypa.io/get-pip.py && \
	python get-pip.py && \
	rm get-pip.py

RUN pip install --upgrade setuptools && \
	pip install --no-cache-dir \
	-i https://pypi.doubanio.com/simple/  \
    --trusted-host pypi.doubanio.com \
	pwntools

RUN git clone https://github.com/pwndbg/pwndbg && \
    cd pwndbg && chmod +x setup.sh && ./setup.sh

ENV LANG C.UTF-8

RUN useradd -m -s /bin/bash user && \
	echo "user:user" | chpasswd && \
	mkdir -p /var/run/sshd

WORKDIR /work/

CMD ["/usr/sbin/sshd", "-D"]
