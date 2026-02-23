# ------------------------ Subdirectories
DIRS	:=	C JavaScript ASM

# ------------------------ Colors
RESET	:=	\033[0m
GREEN 	:=	\033[32m

# ------------------------ Build Settings
.DEFAULT_GOAL	:= all

# ------------------------ Rules & Targets
.PHONY: all
all:
	@for dir in $(DIRS); do \
		echo "$(GREEN)[$${dir}]$(RESET)"; \
		$(MAKE) -C $$dir --no-print-directory || exit 1; \
	done

.PHONY: clean
clean:
	@for dir in $(DIRS); do \
		$(MAKE) -C $$dir --no-print-directory clean || exit 1; \
	done

.PHONY: fclean
fclean:
	@for dir in $(DIRS); do \
		$(MAKE) -C $$dir --no-print-directory fclean || exit 1; \
	done

.PHONY: re
re: fclean all

.PHONY: test
test:
	@for dir in $(DIRS); do \
		echo "$(GREEN)[$${dir}]$(RESET)"; \
		$(MAKE) -C $$dir --no-print-directory test || exit 1; \
	done
