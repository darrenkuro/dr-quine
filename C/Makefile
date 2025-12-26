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

%: %.c
	@printf "Building: $@..."
	@$(CC) $(CFLAGS) -o $@ $^
	@echo " ✅ "

.PHONY: all
all: $(COLLEEN) $(GRACE) $(SULLY)

.PHONY: clean
clean:
	@printf "Removing: generated files..."
	@$(RM) $(GRACE)_kid.c $(SULLY)_*
	@echo " ✅ "

.PHONY: fclean
fclean: clean
	@printf "Removing: binary files..."
	@$(RM) $(COLLEEN) $(GRACE) $(SULLY)
	@echo " ✅ "

.PHONY: re
re: fclean all

.PHONY: test
test: all
	@./$(COLLEEN) | diff - $(COLLEEN).c && echo "TESTING: Colleen ✅"
	@./$(GRACE); diff $(GRACE).c $(GRACE)_kid.c && echo "TESTING: Grace ✅"
	@./$(SULLY); \
	i=0; \
	while [ $$i -le 5 ]; do \
		test -f "$(SULLY)_$$i.c" || { echo "Missing $(SULLY)_$$i.c"; exit 1; }; \
		i=$$((i + 1)); \
	done
	@diff $(SULLY).c $(SULLY)_5.c && echo "TESTING: Sully ✅"
	@$(MAKE) --no-print-directory fclean

.DELETE_ON_ERROR:   # Delete target build that's incomplete
