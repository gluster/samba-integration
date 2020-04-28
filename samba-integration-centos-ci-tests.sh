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
TEST_TARGET="test"
SCRIPT_GIT_BRANCH="centos-ci"
SCRIPT_NAME="$(basename $0)"
SCRIPT_PATH="$(realpath $0)"

#
# === Phase 1 ============================================================
#
# Install git, fetch the git repo and possibly restart updated script if
# we are detecting that we are running on a PR that changes this script.
#

yum -y install git

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
	
	git rebase "origin/${ghprbTargetBranch}"
	if [ $? -ne 0 ] ; then
	    echo "Unable to automatically rebase to branch '${ghprbTargetBranch}'. Please rebase your PR!"
	    exit 1
	fi

	# If the PR is on the branch that contains this script,
	# and the script has changed in the PR, make sure we
	# restart the PR version of the script to test the
	# proposed changes, since the centos-ci is running
	# the merged copy.
	if [ "${ghprbTargetBranch}" = "${SCRIPT_GIT_BRANCH}" ]; then
		if ! git diff --quiet ./"${SCRIPT_NAME}" "${SCRIPT_PATH}" ; then
			echo "Script changed in PR ==> starting over..."
			exec "./${SCRIPT_NAME}"
		fi
	fi
fi


#
# === Phase 2 ============================================================
#
# Prepare the system:
# - install packages
# - start libvirt
# - prefetch vm image
#

# enable additional sources for yum:
# - epel for ansible
yum -y install epel-release

# Install additional packages
#
yum -y install \
	qemu-kvm \
	qemu-kvm-tools \
	qemu-img \
	make \
	ansible \
	libvirt \
	libvirt-devel

# "Development Tools" and libvirt-devel are needed to run
# "vagrant plugin install"
yum -y group install "Development Tools"

# yum install fails if the package is already installed at the desired
# version, so we check whether vagrant is already installed at that
# version. This is important to check when the script is invoked a
# couple of times in a row to prevent it from failing. As a positive
# side effect, it also avoids duplicate downloads of the RPM.
#
if ! rpm -q vagrant-2.2.7
then
	yum -y install https://releases.hashicorp.com/vagrant/2.2.7/vagrant_2.2.7_x86_64.rpm
fi

vagrant plugin install vagrant-libvirt

# Vagrant needs libvirtd running
systemctl start libvirtd

# Log the virsh capabilites so that we know the
# environment in case something goes wrong.
virsh capabilities

# Prefetch the centos/7 vagrant box.
# We use the vagrant cloud rather than fetching directly from centos
# in order to get proper version metadata & caching support.
# (The echo is becuase of "set -e" and that an existing box will cause
#  vagrant to return non-zero.)
vagrant box add "https://vagrantcloud.com/centos/7" --provider "libvirt" \
	|| echo "Warning: the vagrant box may already exist OR an error occured"

#
# === Phase 3 ============================================================
#
# run the tests
#

make "${TEST_TARGET}"

# END
