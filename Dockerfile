FROM arm64v8/ubuntu:xenial
MAINTAINER Joe Hughes <jjhughes57@gmail.com>
ENTRYPOINT [ "/usr/bin/qemu-aarch64-static", "/usr/bin/env", "QEMU_EXECVE=1" ]
CMD [ "/bin/bash" ]

ENV QEMU_EXECVE=1 \
    DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    LOGDNA_VERSION=1.5.5

COPY qemu/bin/  /usr/bin/

RUN [ "cross-build-start" ]

RUN apt-get update && apt-get install -y curl &&\
    curl -sL https://deb.nodesource.com/setup_6.x | bash - &&\
    apt-get install -y ruby zlib1g-dev libssl-dev libffi-dev ruby-dev nodejs git curl build-essential &&\
    gem install fpm
RUN git clone -b ${LOGDNA_VERSION} https://github.com/logdna/logdna-agent.git &&\ 
    cd logdna-agent &&\
    npm install 
COPY docker-deps/logdna.conf /logdna.conf
COPY docker-deps/logdna.service /logdna.service
RUN fpm -s dir -t deb --deb-systemd /logdna.service -n logdna-agent -v ${LOGDNA_VERSION} \ 
    logdna-agent=/usr/local/lib/  /logdna.conf=/etc/logdna.conf

RUN [ "cross-build-end" ]

