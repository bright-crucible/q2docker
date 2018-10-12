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
    build-base screen wget

RUN mkdir -p /quake2/baseq2 /quake2/xatrix /quake2/rogue

WORKDIR /var/local
RUN git clone https://github.com/skullernet/q2pro.git
WORKDIR /var/local/q2pro
COPY etc/q2pro.patch /var/local/q2pro
RUN git apply q2pro.patch
RUN make q2proded && make gamex86_64.so && cp q2proded /quake2

RUN mkdir -p /var/local/xatrix
WORKDIR /var/local/xatrix
#OPTION 1
#COPY data/mirror/xatrixsrc320.shar.Z /var/local/xatrix
#OPTION 2
RUN wget ftp://ftp.gamers.org/pub/idgames/idstuff/quake2/source/xatrixsrc320.shar.Z
#OPTION 1 or 2: sometimes gamers.org refuses connections
RUN zcat xatrixsrc320.shar.Z | sed '98,438d' > xatrix.shar && chmod 755 xatrix.shar && ./xatrix.shar
#patch it then compile it
COPY etc/xatrix.patch /var/local/xatrix
RUN patch < xatrix.patch && make build_release
#Have a symlink to /var/local/xatrix/release/game.so in data/xatrix/gamex86_64.so

COPY etc/xatrixdm.sh /usr/local/bin/

RUN addgroup -S q2 -g 1002 && adduser -u 1002 -S q2 -G q2
RUN chown -R 1002:1002 /quake2/
USER 1002:1002
WORKDIR /quake2
CMD ["/usr/local/bin/xatrixdm.sh"]




FROM alpine:3.8 as roguedm

RUN apk add --no-cache \
    git make libcurl \
    zlib-dev linux-headers \
    build-base screen wget

RUN mkdir -p /quake2/baseq2 /quake2/rogue /quake2/rogue

WORKDIR /var/local
RUN git clone https://github.com/skullernet/q2pro.git
WORKDIR /var/local/q2pro
COPY etc/q2pro.patch /var/local/q2pro
RUN git apply q2pro.patch
RUN make q2proded && make gamex86_64.so && cp q2proded /quake2

RUN mkdir -p /var/local/rogue
WORKDIR /var/local/rogue
#OPTION 1
#COPY data/mirror/roguesrc320.shar.Z /var/local/rogue
#OPTION 2
RUN wget ftp://ftp.gamers.org/pub/idgames/idstuff/quake2/source/roguesrc320.shar.Z
#OPTION 1 or 2: sometimes gamers.org refuses connections
RUN zcat roguesrc320.shar.Z | sed '111,451d' > rogue.shar && chmod 755 rogue.shar && ./rogue.shar
#patch it then compile it
COPY etc/rogue.patch /var/local/rogue
RUN patch < rogue.patch && make build_release
#Have a symlink to /var/local/rogue/release/game.so in data/rogue/gamex86_64.so

COPY etc/roguedm.sh /usr/local/bin/

RUN addgroup -S q2 -g 1002 && adduser -u 1002 -S q2 -G q2
RUN chown -R 1002:1002 /quake2/
USER 1002:1002
WORKDIR /quake2
CMD ["/usr/local/bin/roguedm.sh"]




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




FROM i386/centos:7 as kick
#RUN yum -y groupinstall 'Development Tools'
RUN yum -y install zlib which screen sysvinit-tools unzip

RUN mkdir -p /quake2/baseq2 /quake2/kick

WORKDIR /quake2
COPY data/mirror/r1q2ded-old.zip /quake2
RUN unzip r1q2ded-old.zip && chmod 755 r1q2ded-old

COPY etc/kick.sh /usr/local/bin/

RUN groupadd -g 1002 q2 && useradd -u 1002 -g 1002 q2
RUN chown -R 1002:1002 /quake2/
USER 1002:1002
CMD ["/usr/local/bin/kick.sh"]
