INVENTORY := ./vagrant_ansible_inventory

local:
	@ansible-playbook --inventory localhost, local.yml

setup.prep: local
	@ansible-playbook --inventory=$(INVENTORY) setup.prep.yml

setup.cluster: setup.prep
	@ansible-playbook --inventory=$(INVENTORY) setup.run.yml

.PHONY: local setup.prep setup.cluster
