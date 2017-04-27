FROM phusion/baseimage:latest
MAINTAINER skysider <skysider@163.com>

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get install -y \
	qemu \
	qemu-user \
	qemu-user-static \
	gdb-multiarch \
	'binfmt*' \
	python3-pip \
	cmake \
	socat && \
	rm -rf /var/lib/apt/list/*
	
RUN wget -q -O- https://github.com/hugsy/gef/raw/master/gef.sh | sh

RUN pip3 install --no-cache-dir \
	ropper \
	unicorn \
	capstone \
	retdec-python

EXPOSE 12345

CMD ['/bin/bash']

