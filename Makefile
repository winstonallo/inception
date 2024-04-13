all : up

up : 
	@docker-compose -f ./srcs/docker-compose.yml up --build

down : 
	@docker-compose -f ./srcs/docker-compose.yml down

stop : 
	@docker-compose -f ./srcs/docker-compose.yml stop

start : 
	@docker-compose -f ./srcs/docker-compose.yml start

reset :
	@docker system prune -a --volumes && sudo rm -rf /home/abied-ch/data/*

re : stop reset all

status : 
	@docker ps

.PHONY: all up down stop start reset re status