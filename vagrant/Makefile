INVENTORY := ./vagrant_ansible_inventory

local:
	@ansible-playbook --inventory localhost, local.yml

setup.prep.only:
	@ansible-playbook --inventory=$(INVENTORY) setup.prep.yml

setup.prep: local setup.prep.only

setup.test.only:
	@ansible-playbook --inventory=$(INVENTORY) setup.test.yml

setup.cluster.only:
	@ansible-playbook --inventory=$(INVENTORY) setup.run.yml

setup.cluster: setup.prep setup.test.only setup.cluster.only


.PHONY: local setup.prep.only setup.prep setup.test.only setup.cluster.only setup.cluster
