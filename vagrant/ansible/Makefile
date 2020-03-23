INVENTORY := ./vagrant_ansible_inventory

setup.cluster:
	@ansible-playbook -i $(INVENTORY) ./setup-cluster.yml

.PHONY: setup.cluster
