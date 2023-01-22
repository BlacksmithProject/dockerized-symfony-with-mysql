# Executables (local)
DOCKER_COMP = docker compose

# Docker containers
PHP_CONTAINER = $(DOCKER_COMP) exec php

# Executables
PHP      = $(PHP_CONTAINER) php
COMPOSER = $(PHP_CONTAINER) composer
SYMFONY  = $(PHP_CONTAINER) bin/console

# Misc
.DEFAULT_GOAL = help
.PHONY        : init help build up start down logs shell composer vendor symfony clear-cache stan

## —— 🎵 🐳 The Symfony Docker Makefile 🐳 🎵 ——————————————————————————————————
init: start vendor clear-cache ## Build and start the containers, install vendors and run migrations

help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9\./_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

## —— Docker 🐳 ————————————————————————————————————————————————————————————————
build: ## Builds the Docker images
	@$(DOCKER_COMP) build --pull --no-cache

up: ## Start the docker hub in detached mode (no logs)
	@$(DOCKER_COMP) up --detach

start: build up ## Build and start the containers

down: ## Stop the docker hub
	@$(DOCKER_COMP) down --remove-orphans

shell: ## Connect to the PHP FPM container
	@$(PHP_CONTAINER) sh

## —— Composer 🧙 ——————————————————————————————————————————————————————————————
composer: ## Run composer, pass the parameter "c=" to run a given command, example: make composer c='req symfony/orm-pack'
	@$(eval c ?=)
	@$(COMPOSER) $(c)

vendor: ## Install vendors according to the current composer.lock file
vendor: c=install --prefer-dist --no-dev --no-progress --no-scripts --no-interaction
vendor: composer

## —— Symfony 🎵 ———————————————————————————————————————————————————————————————
symfony: ## List all Symfony commands or pass the parameter "c=" to run a given command, example: make symfony c=about
	@$(eval c ?=)
	@$(SYMFONY) $(c)

clear-cache: c=c:c ## Clear the cache
clear-cache: symfony

## —— PHPstan 🔧 ———————————————————————————————————————————————————————————————

stan: ## Launch PHPstan at level 9 on src
	@$(PHP_CONTAINER) vendor/bin/phpstan analyse src --level=9
