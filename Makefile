NAME := do-spaces
REGISTRY := codejamninja
VERSION := 0.0.1
IMAGE := $(REGISTRY)/$(NAME)

include docker.mk

%:
	@
