FROM ubuntu:18.04
ENV TZ=Europe/US
ENV DEBIAN_FRONTEND=noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && sed -i -- 's/#deb-src/deb-src/g' /etc/apt/sources.list && sed -i -- 's/# deb-src/deb-src/g' /etc/apt/sources.list
RUN apt update && apt -y install net-tools build-essential  autoconf automake libtool git python python3 libglib2.0 libglib2.0-dev \
     libpixman-1-dev bridge-utils uml-utilities  python3-distutils \
     curl wget flex bison\
     gcc-arm-none-eabi gcc-arm-linux-gnueabi \
     gcc-mips-linux-gnu \
     gdb-multiarch \
     && apt -y build-dep qemu