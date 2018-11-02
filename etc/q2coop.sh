#!/bin/sh
echo "Starting Q2 Coop Server"
cd /quake2
screen -A -m -d -S q2coop ./r1q2ded.x86_64 \
           +set deathmatch 0 +set coop 1 +set dmflags 4 \
           +set hostname "Superior's Old-Fashioned Coop Server" \
           +set maxclients 4 +set port 27901 +set skill 3 \
           +exec coop.cfg +set public 1 +exec r1bans.cfg +map base1 \
           +set cheats 1

sleep 5
exec tail -f /quake2/baseq2/qconsole.log
