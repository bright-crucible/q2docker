# q2docker
Setup my various Quake2 servers in containers using Docker. This is unlikely to be useful to anyone else except possibly as an example of how to use Docker.

## Requirements
- Linux (64-bit)
- [docker 1.11+](https://docs.docker.com/engine/installation/)
- git
- Quake2 Assets
- make
- python 3
- [virtualenv](https://virtualenv.pypa.io/en/stable/installation/)

## Installation
```sh
$ git clone https://github.com/bright-crucible/q2docker.git
$ cd q2docker

# Create a directory to store the mod and game assets
$ mkdir data
$ cp -r -v /path/to/quake2/baseq2/ data/
$ cp -r -v /path/to/quake2/xatrix/ data/
# cp -r -v ...

# Create the empty logfiles
$ cd logs
$ ./touch_logs.sh
$ cd -

# Start the Quake2 containers
$ make start
```

## Commands
Run ``make`` to see what else you can do.

```
$ make
Welcome to Q2 Docker!

Commands:

 build      - build docker images locally
 help       - print this help
 logs       - print container logs
 q2coop     - control a shell on the indicated container
 xatrixcoop - control a shell on the indicated container
 roguecoop  - control a shell on the indicated container
 q2dm       - control a shell on the indicated container
 q2dm64     - control a shell on the indicated container
 xatrixdm   - control a shell on the indicated container
 roguedm    - control a shell on the indicated container
 kick       - control a shell on the indicated container
 ctf        - control a shell on the indicated container
 start      - launch the containers
 status     - show running container ps info
 stop       - stop containers
 ```

 ## Acknowledgements
- Based on work from [simply-nzedb](https://github.com/slydetector/simply-nzedb)
