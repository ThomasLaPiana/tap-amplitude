
#
# Default.
#

default: build

#
# Tasks.
#

# Run test.
test:
	TAP_SNOWFLAKE_USERNAME=andyjiang TAP_SNOWFLAKE_PASSWORD="EBzvHxUQeboU;yZ4szuu" TAP_SNOWFLAKE_ACCOUNT=hh09184 TAP_SNOWFLAKE_DATABASE=test TAP_SNOWFLAKE_WAREHOUSE=COMPUTE_WH nosetests --nocapture

# Build.
build: 
	@pip3 install .

# Dev.
dev:
	@python3 setup.py develop

# Docker
build-docker:
	@docker build . -t dev/tap-amplitude:latest

dev-docker: build-docker
	@docker run -it dev/tap-amplitude:latest /bin/bash

test-docker:
	@nosetests TAP_SNOWFLAKE_USERNAME=andyjiang TAP_SNOWFLAKE_PASSWORD="EBzvHxUQeboU;yZ4szuu" TAP_SNOWFLAKE_ACCOUNT=hh09184 TAP_SNOWFLAKE_DATABASE=test TAP_SNOWFLAKE_WAREHOUSE=COMPUTE_WH

# Tap
discover:
	@tap-amplitude --config config.json --discover

catalog:
	@tap-amplitude --config config.json --discover > catalog.json

sync:
	@tap-amplitude --config config.json --catalog catalog.json

#
# Phonies.
#

.PHONY: test build dev
.PHONY: build-docker dev-docker
.PHONY: discover catalog sync


