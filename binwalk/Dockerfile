FROM pk8995/iotbase:latest
RUN git clone https://github.com/ReFirmLabs/binwalk.git /tmp/binwalk && cd /tmp/binwalk && python3 setup.py install && ./deps.sh --yes 18 && cd / && rm -rf /tmp/binwalk