.PHONY: build help start status stop venv

COMPOSE="venv/bin/docker-compose"

help:
	@echo "Welcome to Docker Q2!"

build:
	@bin/build_quake2

logs:
	@$(COMPOSE) logs

start:
	@bin/start_quake2

status:
	@$(COMPOSE) ps

stop:
	@bin/stop_quake2

venv:
	@bin/build_virtualenv

