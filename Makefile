# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hcabel <hcabel@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/04/21 11:09:36 by hcabel            #+#    #+#              #
#    Updated: 2019/05/22 11:53:17 by hcabel           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DEBUG			=	yes
DL				=	yes

ifeq ($(DEBUG), yes) 
	MSG			=	echo "\033[0;31m/!\\ Warning /!\\ \
						\033[0;36mDebug mode ON\033[0;35m"
	FLAGS		=   -g
else
	FLAGS		=   -Wall -Wextra -Werror
endif

ifeq (, $(wildcard libft))
ifeq ($(DL), yes)
	UPDATE		=	git clone https://github.com/hcabel/libft.git libft \
						&& echo '\n'
else
	UPDATE		=	echo "\033[0;31m/!\\ Warning /!\\ \033[0;36m DL is \
						off \n But you can add your libft\033[0;35m"
endif
endif

ifeq (, $(wildcard libft/libft.a))
	CHECK		=	make -C libft
endif

NAME			=	fdf

OBJECT_REP		=	objects
INCLUDE_REP		=	includes
SOURCES_REP		=	srcs

INCLUDES_FILE	=	fdf.h

SOURCES			=	main.c			\
					parsing.c		\
					struct.c		\
					struct2.c		\
					display_map.c	\
					projection.c	\
					action.c		\
					image.c			\
					line.c			\
					color.c			\
					hud.c			\
					checkfile.c		\
					free.c

INCLUDES		=	-I $(INCLUDE_REP)/ -I libft/$(INCLUDE_REP)
LIB				=	-L /usr/local/lib/
FRAMEWORK		=	-framework OpenGL -framework Appkit

OBJECTS			=	$(addprefix $(OBJECT_REP)/, $(SOURCES:.c=.o))

.PHONY: all clean fclean re mkdir make
.SILENT: all clean fclean re $(OBJECT_FILE) $(NAME) $(OBJECTS) mkdir make \
			remake update remove

all: update $(NAME)
	$(MSG)

$(NAME): mkdir make $(OBJECTS) 
	gcc $(FLAGS) -o $(NAME) $(OBJECTS) $(LIB) -lmlx $(FRAMEWORK) libft/libft.a
	
mkdir:
	mkdir -p $(OBJECT_REP)

$(OBJECT_REP)/%.o: $(SOURCES_REP)/%.c $(INCLUDE_REP)/$(INCLUDES_FILE) Makefile
	gcc $(FLAGS) -o $@ $(INCLUDES) -c $<

clean:
	rm -rf $(OBJECT_REP)

fclean: clean
	rm -f $(NAME)

re: remove fclean all

remove:
	make -C libft re

update:
	echo "\n\033[0;35mUpdate \033[0;32m[\033[0;33mlibft\033[0;32m]\033[0;35m\n"
	$(UPDATE)
	$(CHECK)

make:
	make -C libft

norm:
	norminette $(SOURCES_REP)
	norminette $(INCLUDE_REP)