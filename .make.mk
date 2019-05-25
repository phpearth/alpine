.RECIPEPREFIX +=
.DEFAULT_GOAL := help
.PHONY: *

# Alpine distribution verion
version = v3.9

help:
  @echo "\033[33mUsage:\033[0m\n  make [target] [arg=\"val\"...]\n\n\033[33mTargets:\033[0m"
  @grep -hE '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[32m%-15s\033[0m %s\n", $$1, $$2}'

build: ## Build necessary Docker image for building packages
  @docker image build -t phpearth-abuild:$(version) -f .docker/abuild/Dockerfile .docker/abuild

run: ## Run a command in a new Docker container; make run a=[...]
  make build
  @docker container run -it --rm -v `pwd`/packages:/$(version)/ -v `pwd`/public:/public phpearth-abuild:$(version) $(a)

package: ## Usage: make package [p="7.1|7.2|7.3|all|<package-name1> <package-name2> ..."]
  @test "$(p)"
  make run a="package -p \"$(p)\""

generate-index: ## Generate index file APKINDEX.tar.gz usage: make generate-index
  make run a="generate-index"

private-key: ## Generate new private key
  make run a="openssl genrsa -out phpearth.rsa.priv 4096 --build --force-recreate"
  mv packages/phpearth.rsa.priv .docker/abuild/home/packager/.abuild/

public-key: ## Generate new public key
  make run a="openssl rsa -in /home/packager/.abuild/phpearth.rsa.priv -pubout -out /public/phpearth.rsa.pub"

clean: ## Remove pkg, src, and tmp folders when building packages for Alpine
  @rm -rf packages/*/pkg packages/*/src packages/*/tmp

sh: ## Run shell
  make run a=sh

upload: ## Upload build packages to Linux repos server
  @rsync -avz --del public/$(version)/ repos.php.earth:~/repos/alpine/$(version)/
