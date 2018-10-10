#!/bin/sh
echo "Start Q2DM Server"
cd /quake2
#./q2proded +set deathmatch 1 +set coop 0 +set timelimit 15 +set fraglimit 20 +set net_port 27910 +set dmflags 20 +set hostname "docker test 1" +set maxclients 16 +exec q2dm.cfg +set public 1 +setmaster master.q2servers.com +exec q2probans.cfg +map q2dm1
screen -A -m -d -S q2dm ./q2proded +set deathmatch 1 +set coop 0 +set timelimit 15 +set fraglimit 20 +set net_port 27910 +set dmflags 20 +set hostname "docker test 1" +set maxclients 16 +exec q2dm.cfg +set public 1 +setmaster master.q2servers.com +exec q2probans.cfg +map q2dm1

sleep 5
exec tail -f /proc/`pidof q2proded`/fd/1
