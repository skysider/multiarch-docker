Multiarchdocker
=========
A docker environment which could run and debug multiarch program, such as mips, arm

### Usage

	docker run -it \
		--rm \
		-h ${ctf_name} \
		--name ${ctf_name} \
		-v $(pwd)/${ctf_name}:/ctf/work \
    	-P \
    	--cap-add=SYS_PTRACE \
		skysider/multiarchdocker

### Example
	socat TCP-LISTEN:12345,reuseaddr,fork EXEC:"qemu-mips -g 23333 ./demo"
	qemu-mips -strace ./demo
	gdb-multiarch ./demo
	gef>set arch mips
	gef>set endian big
	gef>target remote localhost:23333