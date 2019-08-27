FROM ubuntu:18.04
ENV TZ=Europe/US
ENV DEBIAN_FRONTEND=noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt -y install net-tools build-essential  autoconf automake libtool git python python3 libglib2.0 libglib2.0-dev \
     libpixman-1-dev bridge-utils uml-utilities  python3-distutils \
     curl wget \
     gcc-arm-none-eabi gcc-arm-linux-gnueabi \
     gcc-mips-linux-gnu \
     gdb-multiarch

COPY ./init.sh ~/
RUN  git clone https://github.com/ReFirmLabs/binwalk.git /tmp/binwalk && cd /tmp/binwalk && python3 setup.py install && ./deps.sh --yes 18 && cd / && rm -rf /tmp/binwalk && \
     git clone git://git.qemu.org/qemu.git /tmp/qemu && cd /tmp/qemu && git submodule update --init --recursive \
     && ./configure --static --disable-system --enable-linux-user \
     && make && make install && cp /tmp/qemu/scripts/qemu-binfmt-conf.sh /usr/bin/ && \
     chmod +x /root/init.sh \
     chmod +x /usr/bin/qemu-binfmt-conf.sh
VOLUME /data
EXPOSE 4096
ENTRYPOINT ["/root/init.sh"]
