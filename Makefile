refspec = master

prep.dirs:
	@ansible-playbook --inventory localhost, ./ansible/prep.dirs.yml

tarball:
	@ansible-playbook --inventory localhost, ./ansible/make.tarball.yml --extra-vars "refspec=$(refspec)"

srpm:
	@ansible-playbook --inventory localhost, ./ansible/build.srpm.yml --extra-vars "refspec=$(refspec)"


rpms.centos8:
	@ansible-playbook --inventory localhost, ./ansible/build.rpms.centos8.yml --extra-vars "refspec=$(refspec)"

prep.vm.centos8:
	@ansible-playbook --inventory localhost, ./ansible/prep.vm.centos8.yml

del.vm.centos8:
	@ansible-playbook --inventory localhost, ./ansible/del.vm.centos8.yml

test.rpms.centos8: prep.vm.centos8
	@ansible-playbook --inventory ./ansible/vagrant_ansible_inventory.centosstream8 ./ansible/test.rpms.centos8.yml --extra-vars "refspec=$(refspec)"

rpms.centos9:
	@ansible-playbook --inventory localhost, ./ansible/build.rpms.centos9.yml --extra-vars "refspec=$(refspec)"

prep.vm.centos9:
	@ansible-playbook --inventory localhost, ./ansible/prep.vm.centos9.yml

del.vm.centos9:
	@ansible-playbook --inventory localhost, ./ansible/del.vm.centos9.yml

test.rpms.centos9: prep.vm.centos9
	@ansible-playbook --inventory ./ansible/vagrant_ansible_inventory.centosstream9 ./ansible/test.rpms.centos9.yml --extra-vars "refspec=$(refspec)"


vers = 36

rpms.fedora:
	@ansible-playbook --inventory localhost, ./ansible/build.rpms.fedora.yml --extra-vars "version=$(vers) refspec=$(refspec)"

prep.vm.fedora:
	@ansible-playbook --inventory localhost, ./ansible/prep.vm.fedora.yml --extra-vars "version=$(vers)"

del.vm.fedora:
	@ansible-playbook --inventory localhost, ./ansible/del.vm.fedora.yml --extra-vars "version=$(vers)"

test.rpms.fedora: prep.vm.fedora
	@ansible-playbook --inventory ./ansible/vagrant_ansible_inventory.fedora$(vers) ./ansible/test.rpms.fedora.yml --extra-vars "version=$(vers) refspec=$(refspec)"
