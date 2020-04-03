[![Build Status](https://ci.centos.org/buildStatus/icon?job=gluster_nightly-samba-rpm-builds)](https://ci.centos.org/view/Gluster/job/gluster_nightly-samba-rpm-builds/)

# Samba CentOS RPM Builds

This repository contains automation to create RPMs for CentOS 7 and CentOS 8
from the Samba master branch. The RPMs contain the Samba file server pieces,
including the glusterfs and glusterfs_fuse vfs modules. They do not contain
the active directory domain controller.

This is automatically run in nightly jobs (initially) for CentOS 7 in the
[centos-ci](https://ci.centos.org/job/gluster_nightly-samba-rpm-builds/)
and published as a [yum repository](http://artifacts.ci.centos.org/gluster/nightly-samba/).
