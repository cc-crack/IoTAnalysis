FROM pk8995/qemu:latest
COPY init.sh /root/
RUN  chmod +x /root/init.sh
VOLUME /data
EXPOSE 4096
