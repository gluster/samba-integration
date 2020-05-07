INVENTORY := ./vagrant_ansible_inventory
VSSH := ssh -F ssh-config-host

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
	@$(VSSH) setup "make -C /home/vagrant/ansible setup.cluster"

setup.cluster: setup.prep setup.test.only setup.cluster.only

setup.clients:
	@$(VSSH) setup "make -C /home/vagrant/ansible setup.clients"

setup.site: setup.cluster setup.clients

client1.test:
	@$(VSSH) client1 "sudo make -C /root/samba-integration-tests test"

.PHONY: local hosts.update.only setup.prep.only setup.prep setup.test.only setup.cluster.only setup.cluster setup.clients setup.site client1.test
