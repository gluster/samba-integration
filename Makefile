prep.dirs:
	@ansible-playbook --inventory localhost, ./ansible/prep.dirs.yml

tarball:
	@ansible-playbook --inventory localhost, ./ansible/make.tarball.yml

srpm:
	@ansible-playbook --inventory localhost, ./ansible/build.srpm.yml

rpms.centos8:
	@ansible-playbook --inventory localhost, ./ansible/build.rpms.centos8.yml

rpms.centos7:
	@ansible-playbook --inventory localhost, ./ansible/build.rpms.centos7.yml

prep.vm.centos7:
	@ansible-playbook --inventory localhost, ./ansible/prep.vm.centos7.yml

del.vm.centos7:
	@ansible-playbook --inventory localhost, ./ansible/del.vm.centos7.yml

test.rpms.centos7: prep.vm.centos7
	@ansible-playbook --inventory ./ansible/vagrant_ansible_inventory.centos7 ./ansible/test.rpms.centos7.yml
