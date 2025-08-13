WP_DATA = ~/data/wordpress
DB_DATA = ~/data/mariadb

.PHONY: all up down stop start build ng mdb wp clean re prune

all: up

up: build
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	docker compose -f ./srcs/docker-compose.yml up -d


# -f lets you specify a different docker compose file, usefull for 
stop:
	docker compose -f ./srcs/docker-compose.yml stop

start:
	docker compose -f ./srcs/docker-compose.yml start

build:
	docker compose -f ./srcs/docker-compose.yml build


# some easy diving into container commands
nginx:
	@docker exec -it nginx bash

mariadb:
	@docker exec -it mariadb bash

wordpress:
	@docker exec -it wordpress bash


down:
	docker compose -f ./srcs/docker-compose.yml down

clean: down
	docker system prune --all
	rm -rf $(WP_DATA) || true
	rm -rf $(DB_DATA) || true

re: clean up

prune: clean
	@docker system prune -a --volumes -f