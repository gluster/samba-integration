refspec = master

prep.dirs:
	@ansible-playbook --inventory localhost, ./ansible/prep.dirs.yml

tarball:
	@ansible-playbook --inventory localhost, ./ansible/make.tarball.yml --extra-vars "refspec=$(refspec)"

srpm:
	@ansible-playbook --inventory localhost, ./ansible/build.srpm.yml --extra-vars "refspec=$(refspec)"


rpms.centos7:
	@ansible-playbook --inventory localhost, ./ansible/build.rpms.centos7.yml --extra-vars "refspec=$(refspec)"

prep.vm.centos7:
	@ansible-playbook --inventory localhost, ./ansible/prep.vm.centos7.yml

del.vm.centos7:
	@ansible-playbook --inventory localhost, ./ansible/del.vm.centos7.yml

test.rpms.centos7: prep.vm.centos7
	@ansible-playbook --inventory ./ansible/vagrant_ansible_inventory.centos7 ./ansible/test.rpms.centos7.yml --extra-vars "refspec=$(refspec)"


rpms.centos8:
	@ansible-playbook --inventory localhost, ./ansible/build.rpms.centos8.yml --extra-vars "refspec=$(refspec)"

prep.vm.centos8:
	@ansible-playbook --inventory localhost, ./ansible/prep.vm.centos8.yml

del.vm.centos8:
	@ansible-playbook --inventory localhost, ./ansible/del.vm.centos8.yml

test.rpms.centos8: prep.vm.centos8
	@ansible-playbook --inventory ./ansible/vagrant_ansible_inventory.centos8 ./ansible/test.rpms.centos8.yml --extra-vars "refspec=$(refspec)"


vers = 33

rpms.fedora:
	@ansible-playbook --inventory localhost, ./ansible/build.rpms.fedora.yml --extra-vars "version=$(vers) refspec=$(refspec)"

prep.vm.fedora:
	@ansible-playbook --inventory localhost, ./ansible/prep.vm.fedora.yml --extra-vars "version=$(vers)"

del.vm.fedora:
	@ansible-playbook --inventory localhost, ./ansible/del.vm.fedora.yml --extra-vars "version=$(vers)"

test.rpms.fedora: prep.vm.fedora
	@ansible-playbook --inventory ./ansible/vagrant_ansible_inventory.fedora$(vers) ./ansible/test.rpms.fedora.yml --extra-vars "version=$(vers) refspec=$(refspec)"
