#!/bin/sh
echo "Starting Lasermine CTF Server"
cd /quake2
screen -A -m -d -S ctf ./q2proded-i386 \
           +set game ctf \
           +set hostname "The Last Lasermine CTF Server" \
           +set maxclients 32 +set net_port 27909 +exec server.cfg \
           +set public 1 +setmaster master.q2servers.com \
           +exec q2probans.cfg +map q2ctf1

sleep 5
exec tail -f /proc/`pidof q2proded-i386`/fd/1
