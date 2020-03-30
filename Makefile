prep.dirs:
	@ansible-playbook --inventory localhost, ./ansible/prep.dirs.yml

tarball:
	@ansible-playbook --inventory localhost, ./ansible/make.tarball.yml

srpm:
	@ansible-playbook --inventory localhost, ./ansible/build.srpm.yml

rpms.centos8:
	@ansible-playbook --inventory localhost, ./ansible/build.rpms.centos8.yml
