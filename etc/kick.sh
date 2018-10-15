#!/bin/sh
echo "Starting Q2 Kick Server"
cd /quake2
screen -A -m -d -S kick ./r1q2ded-old \
           +set game kick +exec server.cfg \
           +set hostname "The Last Kick Server" \
           +set port 27908 +set maxclients 24 +set public 1 \
           +exec r1bans.cfg +map kickback

sleep 5
exec tail -f /dev/null
