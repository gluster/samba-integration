.PHONY: test

test:
	ghprbPullId='' ./samba-integration-centos-ci-tests.sh
