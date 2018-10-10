FROM centos:7

RUN yum -y groupinstall 'Development Tools'
RUN yum -y install zlib-devel which screen sysvinit-tools
RUN mkdir -p /quake2/baseq2 /quake2/xatrix /quake2/rogue
WORKDIR /var/local
RUN git clone https://github.com/tastyspleen/r1q2-archive.git
#COPY r1q2ded.patch /var/local/r1q2-archive
#WORKDIR /var/local/r1q2-archive
#RUN git apply r1q2-archive
WORKDIR /var/local/r1q2-archive/binaries

RUN mkdir -p r1q2ded/.depends && make r1q2ded && \
        cp r1q2ded/r1q2ded /quake2/r1q2ded.x86_64

WORKDIR /var/local
RUN git clone https://github.com/skullernet/q2pro.git
WORKDIR /var/local/q2pro
RUN make gamex86_64.so

ADD q2coop.sh /usr/local/bin/

RUN groupadd -g 1002 q2 && useradd -u 1002 -g 1002 q2
RUN chown -R 1002:1002 /quake2/
USER 1002:1002
WORKDIR /quake2
CMD ["/usr/local/bin/q2coop.sh"]
