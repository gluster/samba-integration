INVENTORY := ./vagrant_ansible_inventory

ifdef EXTRA_VARS
	ANSIBLE_EXTRA_VARS := -e '${EXTRA_VARS}'
endif

setup.test:
	@ansible-playbook -i $(INVENTORY) ${ANSIBLE_EXTRA_VARS} ./test.local.yml

setup.cluster:
	@ansible-playbook -i $(INVENTORY) ${ANSIBLE_EXTRA_VARS} ./setup-cluster.yml

setup.clients:
	@ansible-playbook -i $(INVENTORY) ${ANSIBLE_EXTRA_VARS} ./setup-clients.yml

generate.report:
	@ansible-playbook -i $(INVENTORY) ${ANSIBLE_EXTRA_VARS} ./generate-report.yml

client.test:
	@ANSIBLE_STDOUT_CALLBACK=debug ansible-playbook -i $(INVENTORY) ${ANSIBLE_EXTRA_VARS} ./client-test.yml

setup.site: setup.cluster setup.clients client.test

.PHONY: setup.cluster setup.clients setup.site
