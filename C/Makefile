# ------------------------ Project Metadata
COLLEEN	:=	Colleen
GRACE	:=	Grace
SULLY	:=	Sully

# ------------------------ Toolchain & Flags
CC		:=	cc
CFLAGS	:=	-Wall -Wextra -Werror
RM		:=	rm -rf

# ------------------------ Build Settings
.DEFAULT_GOAL	:= all

# ------------------------ Rules & Targets
.PHONY: all
all: $(COLLEEN) $(GRACE) $(SULLY)

.PHONY: clean
clean:
	@printf "Removing: Generated files..."
	@$(RM) $(GRACE)_kid.c $(SULLY)_[0-5].c $(SULLY)_[0-5]
	@echo " [OK]"

.PHONY: fclean
fclean: clean
	@printf "Removing: Binary files..."
	@$(RM) $(COLLEEN) $(GRACE) $(SULLY)
	@echo " [OK]"

.PHONY: re
re: fclean all

%: %.c
	@printf "Building: %s..." "$@"
	@$(CC) $(CFLAGS) -o $@ $^
	@echo " [OK]"

.PHONY: test
test: all
	@./$(COLLEEN) | diff - $(COLLEEN).c && echo "TESTING:  Colleen [OK]"
	@./$(GRACE); diff $(GRACE).c $(GRACE)_kid.c && echo "TESTING:  Grace [OK]"
	@./$(SULLY); \
	i=0; \
	while [ $$i -le 5 ]; do \
		test -f "$(SULLY)_$$i.c" || { echo "Missing $(SULLY)_$$i.c"; exit 1; }; \
		i=$$((i + 1)); \
	done
	@diff $(SULLY).c $(SULLY)_5.c && echo "TESTING:  Sully [OK]"
	@$(MAKE) --no-print-directory fclean

.DELETE_ON_ERROR:   # Delete target build that's incomplete
