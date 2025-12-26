# ------------------------ Project Metadata
TARGET1	:=	Colleen
TARGET2	:=	Grace
TARGET3	:=	Sully

# ------------------------ Toolchain & Flags
CC		:=	cc
CFLAGS	:=	-Wall -Wextra -Werror
RM		:=	rm -rf

# ------------------------ Build Settings
.DEFAULT_GOAL	:= all

%: %.c
	$(CC) $(CFLAGS) -o $@ $^

.PHONY: all
all: $(TARGET1) $(TARGET2) $(TARGET3)

.PHONY: clean
clean:
	rm Sully_* a.out

.PHONY: fclean
fclean: clean

.PHONY: re
re: fclean all


.DELETE_ON_ERROR:   # Delete target build that's incomplete
