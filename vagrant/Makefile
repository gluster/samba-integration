INVENTORY := ./vagrant_ansible_inventory

local:
	@ansible-playbook --inventory localhost, local.yml

hosts.update.only:
	@ansible-playbook --inventory=$(INVENTORY) hosts.update.yml

setup.prep.only:
	@ansible-playbook --inventory=$(INVENTORY) setup.prep.yml

setup.prep: local hosts.update.only setup.prep.only

setup.prep.copy:
	@ansible-playbook --inventory=$(INVENTORY) --start-at-task "copy ansible playbooks to setup machine" setup.prep.yml

setup.test.only:
	@ansible-playbook --inventory=$(INVENTORY) setup.test.yml

setup.cluster.only:
	@vagrant ssh setup -c "make -C /home/vagrant/ansible setup.cluster"

setup.cluster: setup.prep setup.test.only setup.cluster.only

.PHONY: local hosts.update.only setup.prep.only setup.prep setup.test.only setup.cluster.only setup.cluster
