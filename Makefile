prep.dirs:
	@ansible-playbook --inventory localhost, ./ansible/prep.dirs.yml

tarball:
	@ansible-playbook --inventory localhost, ./ansible/make.tarball.yml

srpm:
	@ansible-playbook --inventory localhost, ./ansible/build.srpm.yml
