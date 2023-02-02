GIT_BRANCH_SLUG = $(shell git rev-parse --abbrev-ref HEAD | sed 's|/|-|g')

export IMAGE_NAME = osixia/baseimage
export IMAGE_TAG = local-$(GIT_BRANCH_SLUG)

DEBIAN_BULLSEYE_PATH = ./debian/bullseye
ALPINE_316_PATH = ./alpine/3.16

MAIN_IMAGE_PATH = $(DEBIAN_BULLSEYE_PATH)

.PHONY: copy-distribution-shared-files
copy-distribution-shared-files:
	@echo Copy from $(MAIN_IMAGE_PATH) to $(ALPINE_316_PATH)
	@cp -f $(MAIN_IMAGE_PATH)/Dockerfile $(ALPINE_316_PATH)/
	@cp -rf $(MAIN_IMAGE_PATH)/templates $(ALPINE_316_PATH)/
	@find $(MAIN_IMAGE_PATH)/tools -type f ! -name packages-* -exec cp -t $(ALPINE_316_PATH)/tools {} +

.PHONY: dagger-init
dagger-init:
	dagger project init
	dagger project update

.PHONY: build
build:
	dagger do build

.PHONY: build-debian
build-debian:
	dagger do build debian

.PHONY: build-alpine
build-alpine:
	dagger do build alpine
