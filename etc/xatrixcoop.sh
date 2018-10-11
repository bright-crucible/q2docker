#!/bin/sh
echo "Starting Xatrix Coop Server"
cd /quake2
screen -A -m -d -S xatrixcoop ./r1q2ded.x86_64 \
           +set game xatrix +set coop 1 +set deathmatch 0 \
           +set skill 3 +set maxclients 4 +set dmflags 4 \
           +set hostname "Superior's Xatrix Cooperative Server" \
           +set port 27902 +exec coop.cfg +exec special.cfg \
           +set public 1 +exec r1bans.cfg +map xswamp

sleep 5
exec tail -f /proc/`pidof r1q2ded.x86_64`/fd/1
