.PHONY: all
tf = ~/bin/terraform-0.11.8
get-credentials = ./get-credentials.sh

all: plan

init:
		@$(tf) init

nice:
		@clear
		@$(tf) fmt

plan:
		@$(tf) plan

destroy-plan:
		@$(tf) plan -destroy

out:
		@$(tf) output

get:
		@$(tf) get -update

apply:
		@$(tf) apply

show:
		@$(tf) show

destroy:
		@$(tf) destroy

credentials:
		@$(get-credentials)
