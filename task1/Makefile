# Current version
# VERSION ?= 1.0.0

.DEFAULT_GOAL:=help

PATH  := $(PATH):$(PWD)/bin
SHELL := env PATH=$(PATH) /bin/bash
OS    = $(shell uname -s | tr '[:upper:]' '[:lower:]')
ARCH  = $(shell uname -m | sed 's/x86_64/amd64/')
OSOPER   = $(shell uname -s | tr '[:upper:]' '[:lower:]' | sed 's/darwin/apple-darwin/' | sed 's/linux/linux-gnu/')
ARCHOPER = $(shell uname -m )

.PHONY: help clean plan build destroy plan-demo build-demo destroy-demo plan-production build-production destroy-production demo production

help:  ## Display this help
		@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

all: build

clean: ## Cleanup the project folders
		$(info Make: Cleaning up things)
		find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;
		find . -type f -name ".terraform.lock.hcl" -exec rm -rf {} \;
		find . -type d -name ".terraform" -prune -exec rm -rf {} \;

plan: ## Plan AWS Infrastructure
		$(info Make: Plan AWS Infrastructure)
		(cd deployment/accounts && terragrunt run-all plan)

plan-demo: ## Plan AWS Infrastructure for Demo
	$(info Make: Plan AWS Infrastructure for Demo)
	(cd deployment/accounts/demo && terragrunt run-all plan)

plan-production: ## Plan AWS Infrastructure for Production
	$(info Make: Plan AWS Infrastructure for Production)
	(cd deployment/accounts/production && terragrunt run-all plan)

build: ## Install AWS Infrastructure
		$(info Make: Apply AWS Infrastructure)
		(cd deployment/accounts && terragrunt run-all apply)

build-demo: ## Install AWS Infrastructure for Demo
	$(info Make: Apply AWS Infrastructure for Demo)
	(cd deployment/accounts/demo && terragrunt run-all apply)

build-production: ## Install AWS Infrastructure for Production
	$(info Make: Apply AWS Infrastructure for Production)
	(cd deployment/accounts/production && terragrunt run-all apply)

destroy: ## Destroy AWS Infrastructure
		$(info Make: Destroy AWS Infrastructure.)
		(cd deployment/accounts && terragrunt run-all destroy)

destroy-demo: ## Destroy AWS Infrastructure for Demo
	$(info Make: Destroy AWS Infrastructure for Demo.)
	(cd deployment/accounts/demo && terragrunt run-all destroy)

destroy-production: ## Destroy AWS Infrastructure for Production
	$(info Make: Destroy AWS Infrastructure for Production.)
	(cd deployment/accounts/production && terragrunt run-all destroy)

demo: plan-demo build-demo

production: plan-production build-production