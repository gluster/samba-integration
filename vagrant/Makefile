INVENTORY := ./vagrant_ansible_inventory

local:
	@ansible-playbook --inventory localhost, local.yml

nodes.update.only:
	@ansible-playbook --inventory=$(INVENTORY) nodes.update.yml

setup.prep.only:
	@ansible-playbook --inventory=$(INVENTORY) setup.prep.yml

setup.prep: local nodes.update.only setup.prep.only

setup.prep.copy:
	@ansible-playbook --inventory=$(INVENTORY) --start-at-task "copy ansible playbooks to setup machine" setup.prep.yml

setup.test.only:
	@ansible-playbook --inventory=$(INVENTORY) setup.test.yml

setup.cluster.only:
	@ansible-playbook --inventory=$(INVENTORY) setup.run.yml

setup.cluster: setup.prep setup.test.only setup.cluster.only

.PHONY: nodes.update.only local setup.prep.only setup.prep setup.test.only setup.cluster.only setup.cluster
