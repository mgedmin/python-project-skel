# help.mk version 2.0 (2020-10-11)
#
# Helpful Makefile rules for 'make help'
# https://github.com/mgedmin/python-project-skel

# Tweaking the look of 'make help'; most of these are awk literals and need the quotes
HELP_INDENT = ""
HELP_PREFIX = "make "
HELP_WIDTH = 24
HELP_SEPARATOR = " \# "
HELP_SECTION_SEP = "\n"

.PHONY: help
help:
	@grep -Eh -e '^[a-zA-Z0-9_ -]+:.*?##: .*$$' -e '^##:' $(MAKEFILE_LIST) \
	    | awk 'BEGIN {FS = "(^|:[^#]*)##: "; section=""}; \
	          /^##:/ {printf "%s%s\n%s", section, $$2, $(HELP_SECTION_SEP); section=$(HELP_SECTION_SEP)} \
	          /^[^#]/ {printf "%s\033[36m%-$(HELP_WIDTH)s\033[0m%s%s\n", \
	                   $(HELP_INDENT), $(HELP_PREFIX) $$1, $(HELP_SEPARATOR), $$2}'
