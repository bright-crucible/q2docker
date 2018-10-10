#!/bin/sh
echo "Starting Q2 Coop Server"
cd /quake2
#./r1q2ded.x86_64 +set deathmatch 0 +set coop 1 +set dmflags 4 +set hostname "docker test coop" +set maxclients 4 +set port 27911 +set skill 3 +exec coop.cfg +set public 1 +exec r1bans.cfg +map base1
screen -A -m -d -S q2coop ./r1q2ded.x86_64 +set deathmatch 0 +set coop 1 +set dmflags 4 +set hostname "docker test coop" +set maxclients 4 +set port 27911 +set skill 3 +exec coop.cfg +set public 1 +exec r1bans.cfg +map base1

sleep 5
exec tail -f /proc/`pidof r1q2ded.x86_64`/fd/1
#exec tail -f /dev/null
