This folder contains ansible playbooks which are useful when manual access to the test machines are required. These are not run during automated testing.

The Makefile targets are as follows

##fix_ssh:
Fix the ssh on the test machines so that you can directly ssh into them. Before you can use this target, you will need to create authorized_keys file in the directory which will be copied to /root/.ssh/authorized_keys on the test machine.

##centos7_build_setup:
Install the required packages needed to setup a samba build environment on the storage* hosts. This is useful when instrumenting samba on these machines to check for a root cause for test failures

