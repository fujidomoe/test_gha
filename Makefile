ENV := development

DOCKER_COMPOSE := docker-compose -f docker-compose.yml

BUILD_ARGS := --build-arg GHA_ENV="$(ENV)"

ifeq ($(ENV),development)
	BUILD_ARGS := $(BUILD_ARGS) --build-arg pipenv_install_option="--system --dev"
endif

docker_setup:
	$(DOCKER_COMPOSE) up -d

docker_ssh:
	$(DOCKER_COMPOSE) exec batch /bin/bash

test:
	$(DOCKER_COMPOSE) exec batch /usr/bin/make test -C app_py
