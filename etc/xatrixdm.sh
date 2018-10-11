#!/bin/sh
echo "Starting Xatrix DM Server"
cd /quake2
screen -A -m -d -S xatrixdm ./q2proded \
           +set game xatrix \
           +set hostname "Superior's Xatrix DM" \
           +set dmflags 20 +set timelimit 15 +set fraglimit 20 \
           +set maxclients 16 +set net_port 27906 +exec xdm.cfg \
           +set public 1 +setmaster master.q2servers.com \
           +exec q2probans.cfg +map xdm1

sleep 5
exec tail -f /proc/`pidof q2proded`/fd/1
