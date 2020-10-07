#!/bin/sh
echo "Starting Rogue Coop Server"
cd /quake2
screen -A -m -d -S roguecoop ./r1q2ded.x86_64 \
           +set game rogue \
           +set dmflags 4 \
           +set deathmatch 0 \
           +set coop 1 \
           +set hostname "Superior's Rogue Cooperative Server" \
           +set port 27903 \
           +set maxclients 4 \
           +set skill 3 \
           +exec coop.cfg \
           +set public 1 \
           +exec r1bans.cfg \
           +map rmine1

sleep 5
exec tail -f /quake2/rogue/qconsole.log
