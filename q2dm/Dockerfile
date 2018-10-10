FROM alpine:3.8

RUN apk add --no-cache \
    git make libcurl \
    zlib-dev linux-headers \
    build-base screen

RUN mkdir -p /quake2/baseq2 /quake2/xatrix /quake2/rogue

WORKDIR /var/local
RUN git clone https://github.com/skullernet/q2pro.git
WORKDIR /var/local/q2pro
RUN make q2proded && make gamex86_64.so && cp q2proded /quake2

ADD q2dm.sh /usr/local/bin/

RUN addgroup -S q2 -g 1002 && adduser -u 1002 -S q2 -G q2
RUN chown -R 1002:1002 /quake2/
USER 1002:1002
WORKDIR /quake2
CMD ["/usr/local/bin/q2dm.sh"]
