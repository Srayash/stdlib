
# VARIABLES #

# Define the command for `node`:
NODE ?= node

# Define the command for `cat`:
CAT ?= cat
CAT_FLAGS ?=

# Define the path to the Codecov executable:
CODECOV ?= bash <(curl -s https://codecov.io/bash)

# Define the command-line options to be used when reporting coverage statistics:
CODECOV_FLAGS ?= \
	-F $(CI_SERVICE) \
	-F $(shell echo $(KERNEL) | tr '[:upper:]' '[:lower:]') \
	-F $(shell $(NODE) --version | tr '\.' '_' | (printf 'node_' && $(CAT)))

ifdef COVERAGE_NAME
	CODECOV_FLAGS := $(CODECOV_FLAGS) -F $(COVERAGE_NAME)
endif


# TARGETS #

# Report coverage statistics.
#
# This target sends coverage statistics to [Codecov][1].
#
# [1]: https://codecov.io/

coverage-codecov:
	$(QUIET) $(CAT) $(CAT_FLAGS) $(LCOV_INFO) | $(CODECOV) $(CODECOV_FLAGS) || echo "Failed to upload coverage reports to Codecov. :("

.PHONY: coverage-codecov
