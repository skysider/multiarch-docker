#!/usr/bin/env bash
if [[ -z ${1} ]]; then
    echo -e "Missing binary path"
    exit 0
fi
if [[ -z ${2} ]]; then
    echo -e "Missing binary arch"
    exit 0
fi
binary_path=${1}
arch=${2}

socat tcp-listen:2333,reuseaddr,fork exec:"qemu-${arch} -g 1234 ${binary_path}"
