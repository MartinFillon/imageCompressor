##
## EPITECH PROJECT, 2024
## imageCompresor
## File description:
## Makefile
##

HCFLAGS = --allow-different-user

BIN_PATH = $(shell stack path --local-install-root)
NAME = imageCompressor

all: $(NAME)

$(NAME):
	$(shell stack build --allow-different-user)
	cp $(BIN_PATH)/bin/$(NAME)-exe $(NAME)

clean:
	stack clean

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all fclean re clean $(NAME)
