# About ShadowsocksR of Docker
# 
# Version:1.0

FROM ubuntu:14.04
MAINTAINER smounives <smounives@outlook.com>

ENV REFRESHED_AT 2016-03-20

RUN apt-get -qq update && \
    apt-get install -q -y wget build-essential python m2crypto git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN wget https://download.libsodium.org/libsodium/releases/LATEST.tar.gz && \
    tar zxf LATEST.tar.gz && \
    cd libsodium* && \
    ./configure && make -j2 && make install && \
    ldconfig
#RUN git clone -b manyuser https://github.com/breakwa11/shadowsocks.git ~/shadowsocks
git clone -b manyuser https://github.com/shadowsocksrr/shadowsocksr.git ~/shadowsocks

ENV SSR_SERVER_ADDR 0.0.0.0
ENV SSR_SERVER_PORT 8388
ENV SSR_PASSWORD password
ENV SSR_METHOD aes-256-cfb
ENV SSR_PROTOCOL origin
ENV SSR_TIMEOUT 300
ENV SSR_OBFS tls1.0_session_auth_compatible

ADD shadowsocks.json /etc/
ADD start.sh /usr/local/bin/start.sh
RUN chmod 755 /usr/local/bin/start.sh

EXPOSE $SSR_SERVER_PORT/tcp $SSR_SERVER_PORT/udp

CMD ["sh", "-c", "start.sh"]
