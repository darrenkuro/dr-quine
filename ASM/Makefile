# ------------------------ Project Metadata
COLLEEN	:=	Colleen
GRACE	:=	Grace
SULLY	:=	Sully

# ------------------------ Toolchain & Flags
CC		:=	cc
AS		:=	nasm
ASFLAGS	:=	-f elf64
RM		:=	rm -rf

# ------------------------ Build Settings
.DEFAULT_GOAL	:= all

# ------------------------ Rules & Targets
.PHONY: all
all: $(COLLEEN) $(GRACE) $(SULLY)

.PHONY: clean
clean:
	@printf "Removing: Generated files..."
	@$(RM) $(COLLEEN).o $(GRACE).o $(SULLY).o $(GRACE)_kid.s $(SULLY)_[0-5].s $(SULLY)_[0-5].o $(SULLY)_[0-5]
	@echo " [OK]"

.PHONY: fclean
fclean: clean
	@printf "Removing: Binary files..."
	@$(RM) $(COLLEEN) $(GRACE) $(SULLY)
	@echo " [OK]"

.PHONY: re
re: fclean all

%: %.s
	@printf "Building: %s..." "$@"
	@$(AS) $(ASFLAGS) $< -o $@.o && $(CC) -o $@ $@.o
	@echo " [OK]"

.PHONY: test
test: all
	@./$(COLLEEN) | diff - $(COLLEEN).s && echo "TESTING:  Colleen [OK]"
	@./$(GRACE); diff $(GRACE).s $(GRACE)_kid.s && echo "TESTING:  Grace [OK]"
	@./$(SULLY); \
	i=0; \
	while [ $$i -le 5 ]; do \
		test -f "$(SULLY)_$$i.s" || { echo "Missing $(SULLY)_$$i.s"; exit 1; }; \
		i=$$((i + 1)); \
	done
	@diff $(SULLY).s $(SULLY)_5.s && echo "TESTING:  Sully [OK]"
	@$(MAKE) --no-print-directory fclean

.DELETE_ON_ERROR:   # Delete target build that's incomplete
