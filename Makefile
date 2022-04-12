.DEFAULT_GOAL	:= a
UTILS			= $(addprefix utils/, sigsegv.cpp color.cpp check.cpp leaks.cpp)
PARENT_DIR		= $(shell dirname $(shell pwd))
LIBFT_PATH		= $(PARENT_DIR)
TESTS_PATH		= tests/
MANDATORY		= isalpha \
					isdigit \
					isalnum \
					isascii \
					isprint \
					strlen \
					memset \
					bzero \
					memcpy \
					memmove \
					strlcpy \
					strlcat 
VSOPEN			= $(addprefix vs, $(MANDATORY)) $(addprefix vs, $(BONUS))

CC		= clang++
CFLAGS	= -g3 -ldl -std=c++11 -I utils/ -I$(LIBFT_PATH) 
UNAME = $(shell uname -s)
ifeq ($(UNAME), Linux)
	VALGRIND = valgrind -q --leak-check=full
endif
ifeq ($(IN_DOCKER),TRUE)
	LIBFT_PATH = /project/
endif

$(MANDATORY): %: mandatory_start
	@$(CC) $(CFLAGS) $(UTILS) $(TESTS_PATH)ft_$*_test.cpp -L$(LIBFT_PATH) -lft && $(VALGRIND) ./a.out && rm -f a.out

$(VSOPEN): vs%:
	@code $(TESTS_PATH)ft_$*_test.cpp

mandatory_start: update message
	@tput setaf 6
	make -C $(LIBFT_PATH)
	@tput setaf 4 && echo [Mandatory]

update:
	@git pull

message: checkmakefile
	@tput setaf 3 && echo "If all your tests are OK and the moulinette KO you, please run the tester with valgrind (see README)"

checkmakefile:
	@ls $(LIBFT_PATH) | grep Makefile > /dev/null 2>&1 || (tput setaf 1 && echo Makefile not found. && exit 1)

m: $(MANDATORY)

clean:
	make clean -C $(LIBFT_PATH) && rm -rf a.out*

fclean:
	make fclean -C $(LIBFT_PATH) && rm -rf a.out*

coffee:
	for _ in `seq 1 100`;do\
		clear;\
		echo "";\
		echo "                   (";\
		echo "	                     )     (";\
		echo "               ___...(-------)-....___";\
		echo '           .-""       )    (          ""-.';\
		echo "      .-''''|-._             )         _.-|";\
		echo '     /  .--.|   `""---...........---""`   |';\
		echo "    /  /    |                             |";\
		echo "    |  |    |                             |";\
		echo "     \  \   |                             |";\
		echo "      '\ '\ |                             |";\
		echo "        '\ '|                             |";\
		echo "        _/ /\                             /";\
		echo "       (__/  \                           /";\
		echo '    _..---""` \                         /`""---.._';\
		echo " .-'           \                       /          '-.";\
		echo ":               '-.__             __.-'              :";\
		echo ':                  ) ""---...---"" (                :';\
		echo "\'._                '"--...___...--"'              _.'";\
		echo '   \""--..__                              __..--""/';\
		echo "     '._     """----.....______.....----"""         _.'";\
		echo '         ""--..,,_____            _____,,..--"""''';\
		echo '                      """------"""';\
		sleep 0.005;\
		clear;\
		echo "";\
		echo "                 (";\
		echo "	                  )      (";\
		echo "               ___..(.------)--....___";\
		echo '           .-""       )   (           ""-.';\
		echo "      .-''''|-._      (       )        _.-|";\
		echo '     /  .--.|   `""---...........---""`   |';\
		echo "    /  /    |                             |";\
		echo "    |  |    |                             |";\
		echo "     \  \   |                             |";\
		echo "      '\ '\ |                             |";\
		echo "        '\ '|                             |";\
		echo "        _/ /\                             /";\
		echo "       (__/  \                           /";\
		echo '    _..---""` \                         /`""---.._';\
		echo " .-'           \                       /          '-.";\
		echo ":               '-.__             __.-'              :";\
		echo ':                  ) ""---...---"" (                :';\
		echo "\'._                '"--...___...--"'              _.'";\
		echo '   \""--..__                              __..--""/';\
		echo "     '._     """----.....______.....----"""         _.'";\
		echo '         ""--..,,_____            _____,,..--"""''';\
		echo '                      """------"""';\
		sleep 0.005;\
		clear;\
		echo "";\
		echo "             (         ) ";\
		echo "	              )        (";\
		echo "               ___)...----)----....___";\
		echo '           .-""      )    (           ""-.';\
		echo "      .-''''|-._      (       )        _.-|";\
		echo '     /  .--.|   `""---...........---""`   |';\
		echo "    /  /    |                             |";\
		echo "    |  |    |                             |";\
		echo "     \  \   |                             |";\
		echo "      '\ '\ |                             |";\
		echo "        '\ '|                             |";\
		echo "        _/ /\                             /";\
		echo "       (__/  \                           /";\
		echo '    _..---""` \                         /`""---.._';\
		echo " .-'           \                       /          '-.";\
		echo ":               '-.__             __.-'              :";\
		echo ':                  ) ""---...---"" (                :';\
		echo "\'._                '"--...___...--"'              _.'";\
		echo '   \""--..__                              __..--""/';\
		echo "     '._     """----.....______.....----"""         _.'";\
		echo '         ""--..,,_____            _____,,..--"""''';\
		echo '                      """------"""';\
		sleep 0.005;\
	done

.PHONY:	mandatory_start m fclean clean update message coffee $(VSOPEN) $(MAIL)
