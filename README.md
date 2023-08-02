# This repository has been split and the resulting repositories moved to 
## - [https://github.com/samba-in-kubernetes/sit-environment](https://github.com/samba-in-kubernetes/sit-environment)
## - [https://github.com/samba-in-kubernetes/sit-test-cases](https://github.com/samba-in-kubernetes/sit-test-cases)
## Please use the new repository locations for the latest updates on the projects.




# Samba-Gluster Integration Test Environment

The purpose of this project is to provide a generic mechanism to set up a
gluster-ctdb-samba cluster as a test environment. The mechanism is built on
vagrant-libvirt and ansible, and should be able to run on any host that has
support for these pieces of software. It is pulling the latest nightly RPM
builds from the upstream master branches of Gluster and Samba for setting
up the cluster.

In the future, we might support options for choosing to consume pre-built RPMS
or building from a given software branch.

Various branches and resources are playing together to enable this CI:

- [CentOS CI](https://jenkins-samba.apps.ocp.ci.centos.org/) - these are the resources where we run our tests and builds.
- [_master_ branch](https://github.com/gluster/samba-integration/) - this brings up the test environment and then run tests from the tests branch
- [_tests_ branch](https://github.com/gluster/samba-integration/tree/tests) - the actual test suites to run, invoked by `make test` in the master branch after environment setup (could be a different repo, but we started here for simplicity)
- [_samba-build_ branch](https://github.com/gluster/samba-integration/tree/samba-build) - this contains the specfile and ansible automation to build our nightly samba RPMs
- [CentOS CI jobs](https://github.com/anoopcs9/samba-centosci) - this contains the centos-ci job definition for gluster-integration, nightly samba builds
- [nightly samba rpms repository](http://artifacts.ci.centos.org/samba/pkgs/) - created by the nightly samba rpm build jobs
- [nightly gluster rpms repository](http://artifacts.ci.centos.org/gluster/nightly/) - created by nightly gluster rpm build jobs
