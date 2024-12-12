# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lmedrano <lmedrano@student.42lausanne.ch>  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/12 10:48:23 by lmedrano          #+#    #+#              #
#    Updated: 2024/12/12 15:44:28 by lmedrano         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

BLUE 		= \033[38;5;69m
ORANGE 		= \033[38;5;215m
GREEN 		= \033[38;5;82m
RESET 		= \033[0m

SRCS 		= ./srcs/docker-compose.yml

NAME		= inception

RM		= rm -rf

all:		$(NAME)

${NAME}:	
			@echo "$(BLUE)                           $(RESET)"
			@echo "$(BLUE)       Welcome mon p'tit ! $(RESET)"
			@echo "$(BLUE)        ___  _____ ___  ___      _        $(RESET)"
			@echo "$(BLUE)       /   |/ __  \|  \/  |     | |        $(RESET)"
			@echo "$(BLUE)      / /| |\`' / /'| .  . | __ _| | _____  $(RESET)"
			@echo "$(BLUE)     / /_| |  / /  | |\/| |/ _\` | |/ / _ \\ $(RESET)"
			@echo "$(BLUE)     \___  |./ /___| |  | | (_| |   <  __/ $(RESET)"
			@echo "$(BLUE)         |_/\_____/\_|  |_/\__,_|_|\_\___|......I'm so badass wesh $(RESET)"
			@echo "$(BLUE)                           $(RESET)"
			@echo "$(RESET)$(ORANGE)$(NAME) IS STARTING... $(RESET)"
			@docker-compose -f ${SRCS} up -d --build
			@echo "$(RESET)$(GREEN)$(NAME) STARTED !$(RESET)"


stop:			
			@docker-compose -f ${SRCS} down
			@echo "$(RESET)$(RED)$(NAME) STOPPED !$(RESET)"

clean:		
			@echo "$(RESET)$(ORANGE)DOCKER IS PRUNING... $(RESET)"
			@docker system prune -a -f
			@echo "$(RESET)$(GREEN)DOCKER PRUNED !$(RESET)"

volume-clean:
			@sudo ${RM} /home/lmedrano/data/mariadb/*
			@sudo ${RM} /home/lmedrano/data/wordpress/*
			@echo "$(RESET)$(RED)DOCKER VOLUMES DELETED !$(RESET)"

logs:			
			@docker-compose -f ${SRCS} logs

mariadb:		
			@docker exec -it mariadb sh

nginx:			
			@docker exec -it nginx sh

wordpress:		
			@docker exec -it wordpress sh

re:			stop clean volume-clean all

.PHONY:			all stop clean volume-clean mariadb nginx wordpress re logs
