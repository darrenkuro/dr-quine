# ------------------------ Project Metadata
COLLEEN	:=	Colleen
GRACE	:=	Grace
SULLY	:=	Sully

# ------------------------ Toolchain & Flags
NODE	:=	node
RM		:=	rm -rf

# ------------------------ Build Settings
.DEFAULT_GOAL	:= all

# ------------------------ Rules & Targets
.PHONY: all
all: test

.PHONY: clean
clean:
	@printf "Removing: Generated files..."
	@$(RM) $(GRACE)_kid.js $(SULLY)_[0-5].js
	@echo " [OK]"

.PHONY: fclean
fclean: clean

.PHONY: re
re: fclean all

.PHONY: test
test:
	@$(NODE) $(COLLEEN).js | diff - $(COLLEEN).js && echo "TESTING:  Colleen [OK]"
	@$(NODE) $(GRACE).js; diff $(GRACE).js $(GRACE)_kid.js && echo "TESTING:  Grace [OK]"
	@$(NODE) $(SULLY).js; \
	i=0; \
	while [ $$i -le 5 ]; do \
		test -f "$(SULLY)_$$i.js" || { echo "Missing $(SULLY)_$$i.js"; exit 1; }; \
		i=$$((i + 1)); \
	done
	@diff $(SULLY).js $(SULLY)_5.js && echo "TESTING:  Sully [OK]"
	@$(MAKE) --no-print-directory fclean

.DELETE_ON_ERROR:   # Delete target build that's incomplete
