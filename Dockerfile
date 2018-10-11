FROM alpine:3.8 as q2dm

RUN apk add --no-cache \
    git make libcurl \
    zlib-dev linux-headers \
    build-base screen

RUN mkdir -p /quake2/baseq2 /quake2/xatrix /quake2/rogue

WORKDIR /var/local
RUN git clone https://github.com/skullernet/q2pro.git
WORKDIR /var/local/q2pro
COPY etc/q2pro.patch /var/local/q2pro
RUN git apply q2pro.patch
RUN make q2proded && make gamex86_64.so && cp q2proded /quake2

COPY etc/q2dm.sh /usr/local/bin/

RUN addgroup -S q2 -g 1002 && adduser -u 1002 -S q2 -G q2
RUN chown -R 1002:1002 /quake2/
USER 1002:1002
WORKDIR /quake2
CMD ["/usr/local/bin/q2dm.sh"]




FROM alpine:3.8 as q2dm64

RUN apk add --no-cache \
    git make libcurl \
    zlib-dev linux-headers \
    build-base screen

RUN mkdir -p /quake2/baseq2 /quake2/xatrix /quake2/rogue

WORKDIR /var/local
RUN git clone https://github.com/skullernet/q2pro.git
WORKDIR /var/local/q2pro
COPY etc/q2pro.patch /var/local/q2pro
RUN git apply q2pro.patch
RUN make q2proded && make gamex86_64.so && cp q2proded /quake2

COPY etc/q2dm64.sh /usr/local/bin/

RUN addgroup -S q2 -g 1002 && adduser -u 1002 -S q2 -G q2
RUN chown -R 1002:1002 /quake2/
USER 1002:1002
WORKDIR /quake2
CMD ["/usr/local/bin/q2dm64.sh"]




FROM alpine:3.8 as xatrixdm

RUN apk add --no-cache \
    git make libcurl \
    zlib-dev linux-headers \
    build-base screen

RUN mkdir -p /quake2/baseq2 /quake2/xatrix /quake2/rogue

WORKDIR /var/local
RUN git clone https://github.com/skullernet/q2pro.git
WORKDIR /var/local/q2pro
COPY etc/q2pro.patch /var/local/q2pro
RUN git apply q2pro.patch
RUN make q2proded && make gamex86_64.so && cp q2proded /quake2

RUN mkdir -p /var/local/xatrix
WORKDIR /var/local/xatrix
RUN wget 'https://ftp.gwdg.de/pub/misc/ftp.idsoftware.com/idstuff/quake2/source/xatrixsrc320.shar.Z' && zcat xatrixsrc320.shar.Z > xatrixsrc320.shar
RUN chmod 755 xatrixsrc320.shar

COPY etc/xatrixdm.sh /usr/local/bin/

RUN addgroup -S q2 -g 1002 && adduser -u 1002 -S q2 -G q2
RUN chown -R 1002:1002 /quake2/
USER 1002:1002
WORKDIR /quake2
CMD ["/usr/local/bin/xatrixdm.sh"]




FROM centos:7 as q2coop

RUN yum -y groupinstall 'Development Tools'
RUN yum -y install zlib-devel which screen sysvinit-tools

RUN mkdir -p /quake2/baseq2 /quake2/xatrix /quake2/rogue

WORKDIR /var/local
RUN git clone https://github.com/tastyspleen/r1q2-archive.git
COPY etc/r1q2-archive.patch /var/local/r1q2-archive
WORKDIR /var/local/r1q2-archive
RUN git apply r1q2-archive.patch
WORKDIR /var/local/r1q2-archive/binaries
RUN mkdir -p r1q2ded/.depends && make r1q2ded && \
        cp r1q2ded/r1q2ded /quake2/r1q2ded.x86_64

WORKDIR /var/local
RUN git clone https://github.com/skullernet/q2pro.git
WORKDIR /var/local/q2pro
COPY etc/q2pro.patch /var/local/q2pro
RUN git apply q2pro.patch
RUN make gamex86_64.so

COPY etc/q2coop.sh /usr/local/bin/

RUN groupadd -g 1002 q2 && useradd -u 1002 -g 1002 q2
RUN chown -R 1002:1002 /quake2/
USER 1002:1002
WORKDIR /quake2
CMD ["/usr/local/bin/q2coop.sh"]
