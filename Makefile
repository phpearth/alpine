.PHONY: help build run package generate-index abuild-generate-private-key abuild-generate-public-key clean sh upload
.DEFAULT_GOAL := help

help: ## Output usage documentation
	@echo "Usage: make COMMAND [args]\n\nCommands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: ## Build necessary Docker image for building packages
	@docker image build -t phpearth-abuild -f .docker/abuild/Dockerfile .docker/abuild

run: ## Run a command in a new Docker container. Usage: make run a=[...]
	make build
	@docker container run -it --rm -v `pwd`/build:/build -v `pwd`/public:/public phpearth-abuild $(a)

package: ## Usage: make package [p="7.0|7.1|7.2|all|<package-name1> <package-name2> ..."]
	make run a="package $(p)"

generate-index: ## Generate index file APKINDEX.tar.gz usage: make generate-index
	make run a="generate-index"

abuild-generate-private-key: ## Generate new private key
	make run a="openssl genrsa -out phpearth.rsa.priv 4096 --build --force-recreate"

abuild-generate-public-key: ## Generate new public key
	make run a="openssl rsa -in phpearth.rsa.priv -pubout -out /public/phpearth.rsa.pub"

clean: ## Remove pkg, src, tmp and log folders when building packages for Alpine
	@rm -rf build/v3.7/*/pkg build/v3.7/*/src build/v3.7/*/tmp log/*

sh: ## Run shell
	make run a=sh

upload: ## Upload build packages to Linux repos server
	@rsync -avz --del public/ repos.php.earth:~/repos/alpine/
