#!/bin/sh
echo "Starting Rogue DM Server"
cd /quake2
screen -A -m -d -S roguedm ./q2proded \
           +set game rogue +set deathmatch 1 +set dmflags 20 \
           +set hostname "Superior's Rogue DM Server" \
           +set maxclients 16 +set net_port 27907 +set timelimit 15 \
           +set fraglimit 20 +exec rdm.cfg +set public 1 \
           +setmaster master.q2servers.com +exec q2probans.cfg +map rdm1

sleep 5
exec tail -f /dev/null
