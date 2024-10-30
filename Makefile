##
## EPITECH PROJECT, 2021
## B-FUN-300-PAR-3-1-funPoolDay2-francois.zhao [WSL: Ubuntu]
## File description:
## Makefile
##

SRC = main.hs
CXX = ghc --make
NAME = pushswap_checker

all: $(NAME)

$(NAME):
	$(CXX) -O2 -o $(NAME) $(SRC)
	rm -rf *.o *.hi

clean:
	$(RM) $(OBJ)
	rm -rf *.o *.hi

fclean:	clean
	$(RM) $(NAME)

re:	fclean all
	rm -rf *.o *.hi

.PHONY: all clean fclean re test
