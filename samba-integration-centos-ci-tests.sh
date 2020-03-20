#!/bin/bash

# Set up a centos7 machine with the required environment to
# run the tests from https://github.com/gluster/samba-integration.git
# and run the tests.

# if anything fails, we'll abort
set -e

# TODO: disable debugging
set -x

GIT_REPO_NAME="samba-integration"
GIT_REPO_URL="https://github.com/gluster/${GIT_REPO_NAME}.git"

# enable additional sources for yum
# (SCL repository for Vagrant, epel for ansible)
yum -y install centos-release-scl epel-release

# Install additional packages
#
# note: adding sclo-vagrant1-vagrant explicitly seems to fix
#   issues where libvirt fails to bring up the vm with errors like this:
#   "Call to virDomainCreateWithFlags failed: the CPU is incompatible with host
#    CPU: Host CPU does not provide required features: svm" (or vmx)
#
yum -y install \
	qemu-kvm \
	qemu-kvm-tools \
	qemu-img \
	sclo-vagrant1-vagrant \
	sclo-vagrant1-vagrant-libvirt \
	git \
	make \
	python-py \
	python-virtualenv \
	ansible

# Vagrant needs libvirtd running
systemctl start libvirtd

# Log the virsh capabilites so that we know the
# environment in case something goes wrong.
virsh capabilities

rm -rf tests
mkdir tests
cd tests
git clone "${GIT_REPO_URL}"
cd "${GIT_REPO_NAME}"

# by default we clone the master branch, but maybe this was triggered through a PR?
if [ -n "${ghprbPullId}" ]
then
	git fetch origin "pull/${ghprbPullId}/head:pr_${ghprbPullId}"
	git checkout "pr_${ghprbPullId}"
	
	git rebase "${ghprbTargetBranch}"
	if [ $? -ne 0 ] ; then
	    echo "Unable to automatically rebase to branch '${ghprbTargetBranch}'. Please rebase your PR!"
	    exit 1
	fi
fi

# Prefetch the centos/7 vagrant box.
# We use the vagrant cloud rather than fetching directly from centos
# in order to get proper version metadata & caching support.
# (The echo is becuase of "set -e" and that an existing box will cause
#  vagrant to return non-zero.)
scl enable sclo-vagrant1 -- \
	vagrant box add "https://vagrantcloud.com/centos/7" --provider "libvirt" \
	|| echo "Warning: the vagrant box may already exist OR an error occured"

# time to run the tests:

# TODO: add real tests to execute
true
#echo make "${TEST_TARGET}" | scl enable sclo-vagrant1 bash

# END
