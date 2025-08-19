WP_DATA = ~/data/wordpress
DB_DATA = ~/data/mariadb
COMPOSE_FILE = ./srcs/docker-compose.yml
BASE_COMPOSE_CMD = docker compose -f ./srcs/docker-compose.yml

# -f lets you specify a different docker compose file, usefull when it's in a diff directory
# -d == detached mode, AKA it will run in thebackground and your terminal will stay free?
all: up

up:
	mkdir -p $(WP_DATA)
	mkdir -p $(DB_DATA)
	docker compose -f ./srcs/docker-compose.yml up --build -d


down:
	$(BASE_COMPOSE_CMD) down

clean: down
	docker system prune --all -f
	sudo rm -rf $(WP_DATA) || true
	sudo rm -rf $(DB_DATA) || true

# fclean: doesnt work in makefile?
# 	docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null

re:
	docker-compose -f $(COMPOSE_FILE) down
	docker-compose -f $(COMPOSE_FILE) up --build -d

prune: clean
	docker system prune -a --volumes -f

.PHONY: all up down stop start build ng mdb wp clean re fclean