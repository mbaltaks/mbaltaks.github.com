# All projects standard build protocol makefile
# https://jefframnani.com/project-build-protocol/
# https://github.com/github/scripts-to-rule-them-all

.PHONY: bootstrap cibuild console server setup test update
.PHONY: update_packages


bootstrap:
	script/bootstrap

cibuild:
	script/cibuild

console:
	script/console

server:
	script/server

setup:
	script/setup

test:
	script/test

update:
	script/update

update_packages:
	script/update_packages
