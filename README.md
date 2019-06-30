Multiarchdocker
=========
A docker environment which could run and debug multiarch program, such as mips, arm

### Usage

run docker:

```shell
docker run -d \
	--rm \
	-h ${ctf_name} \
	--name ${ctf_name} \
	-v $(pwd)/${ctf_name}:/work/ctf \
	-P \
	--cap-add=SYS_PTRACE \
	skysider/multiarch-docker
```

debug mips program in docker:

```shell
socat TCP-LISTEN:2333,reuseaddr,fork EXEC:"qemu-mips -g 1234 ./demo"
qemu-mips -strace ./demo
gdb-multiarch ./demo
gef>set arch mips
gef>set endian big
gef>target remote localhost:1234
```

If you need cross compile environment, please specify tag: `skysider/multiarch-docker:compile`

```shell
cat > test.c <<EOF
#include <stdio.h>
int main()
{
	puts("hello world");
    return 0;
}
EOF
mips-linux-gnu-gcc test.c -o test-mips
```

### Supported arch

```
mipsel
mips64el
mips
mips64
armel(armhf)
aarch64
```

