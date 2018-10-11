#!/bin/sh
echo "Starting Q2DM64 Server"
cd /quake2
screen -A -m -d -S q2dm64 ./q2proded \
           +set deathmatch 1 +set coop 0 +set timelimit 30 \
           +set fraglimit 50 +set net_port 27905 \
           +set net_enable_ipv6 2 +set dmflags 1044 \
           +set hostname "Superior's DM64 Server" \
           +set maxclients 64 +exec q2dm64.cfg +set public 1 \
           +setmaster master.q2servers.com +exec q2probans.cfg +map base64

sleep 5
exec tail -f /proc/`pidof q2proded`/fd/1
