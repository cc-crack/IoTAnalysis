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

COPY init.sh /root/
RUN  git clone https://github.com/ReFirmLabs/binwalk.git /tmp/binwalk && cd /tmp/binwalk && python3 setup.py install && ./deps.sh --yes 18 && cd / && rm -rf /tmp/binwalk && \
     git clone git://git.qemu.org/qemu.git /tmp/qemu && cd /tmp/qemu && git submodule update --init --recursive \
     && ./configure --prefix=$(cd ..; pwd)/qemu-user-static --static --disable-system --enable-linux-user \
     && make -j8 && make install && cp /tmp/qemu/scripts/qemu-binfmt-conf.sh /usr/bin/ && cd ../qemu-user-static/bin &&  for i in *; do cp $i $i-static; done \
     && cp *-static /usr/local/bin/ \
     && chmod +x /root/init.sh \
     && chmod +x /usr/bin/qemu-binfmt-conf.sh
VOLUME /data
EXPOSE 4096
ENTRYPOINT ["/root/init.sh"]
