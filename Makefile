.PHONY: build help logs start status stop venv \
		q2coop xatrixcoop roguecoop \
		q2dm q2dm64 xatrixdm roguedm \
		kick ctf

COMPOSE="venv/bin/docker-compose"

help:
	@echo "Welcome to Docker Q2!"
	@echo ""
	@echo "Commands:"
	@echo ""
	@echo " build - build docker images locally"
	@echo " help - print this help"
	@echo " logs - print container logs"
	@echo " q2coop - control a shell on the indicated container"
	@echo " xatrixcoop - control a shell on the indicated container"
	@echo " roguecoop - control a shell on the indicated container"
	@echo " q2dm - control a shell on the indicated container"
	@echo " q2dm64 - control a shell on the indicated container"
	@echo " xatrixdm - control a shell on the indicated container"
	@echo " roguedm - control a shell on the indicated container"
	@echo " kick - control a shell on the indicated container"
	@echo " ctf - control a shell on the indicated container"
	@echo " start - launch the containers"
	@echo " status - show running container ps info"
	@echo " stop - stop containers"
	@echo " venv - create virtual environment for docker-compose"

build:
	@bin/build_quake2

logs:
	@$(COMPOSE) logs

q2coop:
	@bin/quake2_shell "$@"

xatrixcoop:
	@bin/quake2_shell "$@"

roguecoop:
	@bin/quake2_shell "$@"

q2dm:
	@bin/quake2_shell "$@"

q2dm64:
	@bin/quake2_shell "$@"

xatrixdm:
	@bin/quake2_shell "$@"

roguedm:
	@bin/quake2_shell "$@"

kick:
	@bin/quake2_shell "$@"

ctf:
	@bin/quake2_shell "$@"

start:
	@bin/start_quake2

status:
	@$(COMPOSE) ps

stop:
	@bin/stop_quake2

venv:
	@bin/build_virtualenv
