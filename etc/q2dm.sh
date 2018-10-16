#!/bin/sh
echo "Starting Q2DM Server"
cd /quake2
screen -A -m -d -S q2dm ./q2proded \
           +set deathmatch 1 +set coop 0 +set timelimit 15 \
           +set fraglimit 20 +set net_port 27904 +set dmflags 20 \
           +set hostname "Superior's Old-Fashioned DM Server" \
           +set maxclients 16 +exec q2dm.cfg +set public 1 \
           +setmaster master.q2servers.com +exec q2probans.cfg +map q2dm1

sleep 5
exec tail -f /quake2/baseq2/logs/console.log
