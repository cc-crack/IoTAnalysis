FROM ubuntu
ENV TZ=Europe/US
ENV DEBIAN_FRONTEND=noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt -y install net-tools build-essential  autoconf automake libtool git python python3 libglib2.0 libglib2.0-dev \
     libpixman-1-dev bridge-utils uml-utilities  python3-distutils \
     curl wget
RUN git clone https://github.com/ReFirmLabs/binwalk.git /tmp/binwalk && cd /tmp/binwalk && python3 setup.py install && /deps.sh --yes 18
RUN git clone git://git.qemu.org/qemu.git /tmp/qemu && cd /tmp/qemu && ./configure && make && make install
VOLUME /data
EXPOSE 4096