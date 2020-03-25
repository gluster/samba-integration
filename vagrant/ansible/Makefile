INVENTORY := ./vagrant_ansible_inventory

setup.test:
	@ansible-playbook -i $(INVENTORY) ./test.local.yml
	@ansible-playbook -i $(INVENTORY) ./test.yml

setup.cluster:
	@ansible-playbook -i $(INVENTORY) ./setup-cluster.yml

.PHONY: setup.cluster
