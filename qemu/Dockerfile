FROM pk8995/binwalk:latest

RUN  git clone git://git.qemu.org/qemu.git /tmp/qemu && cd /tmp/qemu && git submodule update --init --recursive \
     && ./configure --prefix=$(cd ..; pwd)/qemu-user-static --static --disable-system --enable-linux-user \
     && make -j8 && make install && cp /tmp/qemu/scripts/qemu-binfmt-conf.sh /usr/bin/ && cd ../qemu-user-static/bin &&  for i in *; do cp $i $i-static; done \
     && cp *-static /usr/local/bin/ \
     && chmod +x /usr/bin/qemu-binfmt-conf.sh