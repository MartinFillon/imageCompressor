##
## EPITECH PROJECT, 2024
## imageCompresor
## File description:
## Makefile
##

BIN_PATH = $(shell stack path --local-install-root)
NAME = imageCompressor

all: $(NAME)

$(NAME):
	$(shell stack build --allow-different-user)
	cp $(BIN_PATH)/bin/$(NAME)-exe $(NAME)

clean:
	stack purge --allow-different-user

fclean: clean
	$(RM) $(NAME)

re: fclean all

tests_run:
	stack test --coverage
	cp $(BIN_PATH)/hpc/ ./test/coverage -r

.PHONY: all fclean re clean $(NAME) tests_run
