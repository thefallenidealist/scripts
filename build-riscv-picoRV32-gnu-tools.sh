#!/bin/sh
# Created 181226
# build GNU tools (GCC, LD, AS, binutils) for Clifford Wolfs PicoRV32
# https://github.com/cliffordwolf/picorv32/#building-a-pure-rv32i-toolchain
# - needs about 3.4 GB of space for download
# - needs about 1.9 GB of space for "build" for per architecture

DESTDIR=$HOME/.opt	# -> $HOME/.opt/riscv32i/bin/riscv32-unknown-elf-gcc

USER_ID=$(id -u)
if [ "$USER_ID" == 0 ]; then
	pkg install -A gawk gsed bison flex texinfo
else
	echo "Install these: pkg install -A gawk gsed bison flex texinfo"
fi

git clone https://github.com/riscv/riscv-gnu-toolchain riscv-gnu-toolchain-riscv32
cd riscv-gnu-toolchain-riscv32
# git checkout c3ad555
git submodule update --init --recursive

ARCHS="rv32i rv32im rv32ic rv32imc"
for arch in $ARCHS ; do
	FOLDER=$(echo $arch | sed 's/rv/riscv/')
	rm -rf build
	mkdir build
	cd build
	# ../configure --with-arch=rv32i --prefix=$HOME/.opt/riscv32i
	../configure --with-arch=$arch --prefix=$DESTDIR/$FOLDER
	# time CC=gcc8 CXX=g++8 gmake -j4
	# {time CC=gcc8 CXX=g++8 gmake -j4} 2> /tmp/build-tools-$arch.time XXX
	CC=gcc8 CXX=g++8 gmake -j4
	cd -
done

# On ThinkPad T430s (Core i7 3rd gen, 2.9 GHz) 1 arch takes about 30 minutes to build

echo "--------------------------------------------------------------------------------"
echo "Checks:"
echo "--------------------------------------------------------------------------------"
for arch in $ARCHS ; do
	FOLDER=$(echo $arch | sed 's/rv/riscv/')
	# echo "Arch: $arch"
	echo "Arch: $arch folder: $FOLDER GCC target: $($DESTDIR/$FOLDER/bin/riscv32-unknown-elf-gcc -Q --help=target | grep march | awk '{print $2}')"
done
