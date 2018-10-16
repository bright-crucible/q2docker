FROM alpine:3.8 as buildq2pro
RUN apk add --no-cache \
    git make libcurl \
    zlib-dev linux-headers \
    build-base screen util-linux wget tzdata
ENV TZ America/Los_Angeles

WORKDIR /var/local
RUN git clone https://github.com/skullernet/q2pro.git
RUN mkdir xatrix rogue

WORKDIR /var/local/xatrix
#OPTION 1:
#COPY data/mirror/xatrixsrc320.shar.Z /var/local/xatrix
#OPTION 2:
RUN wget ftp://ftp.gamers.org/pub/idgames/idstuff/quake2/source/xatrixsrc320.shar.Z
#OPTION 1 or 2: sometimes gamers.org refuses connections
RUN zcat xatrixsrc320.shar.Z | sed '98,438d' > xatrix.shar && \
        chmod 755 xatrix.shar && ./xatrix.shar
#patch it then compile it
COPY etc/xatrix.patch /var/local/xatrix
RUN patch < xatrix.patch && make build_release
#cd data/xatrix;ln -s /var/local/xatrix/release/game.so gamex86_64.so

WORKDIR /var/local/rogue
#OPTION 1
#COPY data/mirror/roguesrc320.shar.Z /var/local/rogue
#OPTION 2
RUN wget ftp://ftp.gamers.org/pub/idgames/idstuff/quake2/source/roguesrc320.shar.Z
#OPTION 1 or 2: sometimes gamers.org refuses connections
RUN zcat roguesrc320.shar.Z | sed '111,451d' > rogue.shar && \
        chmod 755 rogue.shar && ./rogue.shar
#patch it then compile it
COPY etc/rogue.patch /var/local/rogue
RUN patch < rogue.patch && make build_release
#cd data/rogue;ln -s /var/local/rogue/release/game.so gamex86_64.so

WORKDIR /var/local/q2pro
COPY etc/q2pro.patch /var/local/q2pro
RUN git apply q2pro.patch
RUN make q2proded && make gamex86_64.so




FROM alpine:3.8 as q2probase
RUN apk add --no-cache \
        screen zlib tzdata
ENV TZ America/Los_Angeles
RUN mkdir -p /quake2/baseq2 /quake2/xatrix /quake2/rogue \
        /var/local/xatrix/release /var/local/rogue/release \
        /var/local/q2pro
COPY --from=buildq2pro /var/local/q2pro/q2proded /quake2/
COPY --from=buildq2pro /var/local/q2pro/gamex86_64.so /var/local/q2pro/
COPY --from=buildq2pro /var/local/xatrix/release/game.so /var/local/xatrix/release/
COPY --from=buildq2pro /var/local/rogue/release/game.so /var/local/rogue/release/
RUN addgroup -S q2 -g 1002 && adduser -u 1002 -S q2 -G q2
RUN chown -R 1002:1002 /quake2/




FROM q2probase as q2dm
COPY etc/q2dm.sh /usr/local/bin/
USER 1002:1002
WORKDIR /quake2
CMD ["/usr/local/bin/q2dm.sh"]




FROM q2probase as q2dm64
COPY etc/q2dm64.sh /usr/local/bin/
USER 1002:1002
WORKDIR /quake2
CMD ["/usr/local/bin/q2dm64.sh"]




FROM q2probase as xatrixdm
COPY etc/xatrixdm.sh /usr/local/bin/
USER 1002:1002
WORKDIR /quake2
CMD ["/usr/local/bin/xatrixdm.sh"]




FROM q2probase as roguedm
COPY etc/roguedm.sh /usr/local/bin/
USER 1002:1002
WORKDIR /quake2
CMD ["/usr/local/bin/roguedm.sh"]




FROM centos:7 as buildr1q2
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
RUN yum -y groupinstall 'Development Tools'
RUN yum -y install zlib-devel which screen wget

WORKDIR /var/local
RUN mkdir xatrix rogue

RUN git clone https://github.com/skullernet/q2pro.git
RUN git clone https://github.com/tastyspleen/r1q2-archive.git
COPY etc/r1q2-archive.patch /var/local/r1q2-archive
WORKDIR /var/local/r1q2-archive
RUN git apply r1q2-archive.patch
WORKDIR /var/local/r1q2-archive/binaries
RUN mkdir -p r1q2ded/.depends && make r1q2ded

WORKDIR /var/local/xatrix
#OPTION 1:
#COPY data/mirror/xatrixsrc320.shar.Z /var/local/xatrix
#OPTION 2:
RUN wget ftp://ftp.gamers.org/pub/idgames/idstuff/quake2/source/xatrixsrc320.shar.Z
#OPTION 1 or 2: sometimes gamers.org refuses connections
RUN zcat xatrixsrc320.shar.Z | sed '98,438d' > xatrix.shar && \
        chmod 755 xatrix.shar && ./xatrix.shar
#patch it then compile it
COPY etc/xatrix.patch /var/local/xatrix
RUN patch < xatrix.patch && make build_release
#cd data/xatrix;ln -s /var/local/xatrix/release/game.so gamex86_64.so

WORKDIR /var/local/rogue
#OPTION 1
#COPY data/mirror/roguesrc320.shar.Z /var/local/rogue
#OPTION 2
RUN wget ftp://ftp.gamers.org/pub/idgames/idstuff/quake2/source/roguesrc320.shar.Z
#OPTION 1 or 2: sometimes gamers.org refuses connections
RUN zcat roguesrc320.shar.Z | sed '111,451d' > rogue.shar && \
        chmod 755 rogue.shar && ./rogue.shar
#patch it then compile it
COPY etc/rogue.patch /var/local/rogue
RUN patch < rogue.patch && make build_release
#cd data/rogue;ln -s /var/local/rogue/release/game.so gamex86_64.so

WORKDIR /var/local/q2pro
COPY etc/q2pro.patch /var/local/q2pro
RUN git apply q2pro.patch
RUN make gamex86_64.so




FROM centos:7 as r1q2base
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
RUN yum -y install screen zlib
RUN mkdir -p /quake2/baseq2 /quake2/xatrix /quake2/rogue \
        /var/local/xatrix/release /var/local/rogue/release \
        /var/local/r1q2-archive/binaries/r1q2ded \
        /var/local/q2pro
COPY --from=buildr1q2 /var/local/r1q2-archive/binaries/r1q2ded/r1q2ded /quake2/r1q2ded.x86_64
COPY --from=buildr1q2 /var/local/q2pro/gamex86_64.so /var/local/q2pro/
COPY --from=buildr1q2 /var/local/xatrix/release/game.so /var/local/xatrix/release/
COPY --from=buildr1q2 /var/local/rogue/release/game.so /var/local/rogue/release/
RUN groupadd -g 1002 q2 && useradd -u 1002 -g 1002 q2
RUN chown -R 1002:1002 /quake2/




FROM r1q2base as q2coop
COPY etc/q2coop.sh /usr/local/bin/
USER 1002:1002
WORKDIR /quake2
CMD ["/usr/local/bin/q2coop.sh"]




FROM r1q2base as xatrixcoop
COPY etc/xatrixcoop.sh /usr/local/bin/
USER 1002:1002
WORKDIR /quake2
CMD ["/usr/local/bin/xatrixcoop.sh"]



FROM r1q2base as roguecoop
COPY etc/roguecoop.sh /usr/local/bin/
USER 1002:1002
WORKDIR /quake2
CMD ["/usr/local/bin/roguecoop.sh"]




FROM i386/centos:7 as kick
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
RUN yum -y install screen unzip zlib

RUN mkdir -p /quake2/baseq2 /quake2/kick

WORKDIR /quake2
#No known URL to download r1q2ded-old from :(
COPY data/mirror/r1q2ded-old.zip /quake2
RUN unzip r1q2ded-old.zip && chmod 755 r1q2ded-old

COPY etc/kick.sh /usr/local/bin/

RUN groupadd -g 1002 q2 && useradd -u 1002 -g 1002 q2
RUN chown -R 1002:1002 /quake2/
USER 1002:1002
CMD ["/usr/local/bin/kick.sh"]




FROM i386/centos:7 as ctf
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
RUN yum -y groupinstall 'Development Tools'
RUN yum -y install zlib-devel which screen

RUN mkdir -p /quake2/baseq2 /quake2/ctf

WORKDIR /var/local
RUN git clone https://github.com/skullernet/q2pro.git
RUN git clone https://bitbucket.org/jwaggoner/lasermine.git

WORKDIR /var/local/q2pro
COPY etc/q2pro-i386.patch /var/local/q2pro
RUN echo 'CPU=x86' > .config && git apply q2pro-i386.patch && \
        make q2proded && cp q2proded /quake2/q2proded-i386

WORKDIR /var/local/lasermine
COPY etc/lasermine.patch /var/local/lasermine
RUN git apply lasermine.patch && make

COPY etc/ctf.sh /usr/local/bin/

RUN groupadd -g 1002 q2 && useradd -u 1002 -g 1002 q2
RUN chown -R 1002:1002 /quake2/
USER 1002:1002
WORKDIR /quake2
CMD ["/usr/local/bin/ctf.sh"]
