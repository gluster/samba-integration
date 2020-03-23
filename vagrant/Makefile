INVENTORY := ./vagrant_ansible_inventory

local:
	@ansible-playbook --inventory localhost, local.yml

setup.prep: local
	@ansible-playbook --inventory=$(INVENTORY) setup.prep.yml

.PHONY: local setup.prep
