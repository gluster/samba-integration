[![Build Status](https://ci.centos.org/buildStatus/icon?job=gluster_nightly-samba-rpm-builds)](https://ci.centos.org/view/Gluster/job/gluster_nightly-samba-rpm-builds/)

# Samba CentOS/Fedora RPM Builds

This repository contains automation to create RPMs for CentOS 7/8 and Fedora
from Samba repository. In order to allow building from a variety of git refspecs,
the following make target format is used:

`$ make < rpms.centos7 | rpms.centos8 | rpms.fedora > [ vers=< fedora-version > refspec=< branch-name | tag-name | h:<git-commit-hash> > ]`

Few examples:

- `$ make rpms.centos8 refspec=v4-14-test`
- `$ make rpms.centos7 refspec=h:a0862d6d6de`
- `$ make rpms.fedora vers=34 refspec=samba-4.14.4`

As of now 4.12, 4.13, 4.14, 4.15 and master branches are supported. In the
absence of *refspec* argument, the master branch is built by default. The above
format is also applicable for other `make` targets. The *vers* argument is only
valid for Fedora related make targets and in its absence, the default version is
set to *34*.

The RPMs contain the Samba file server pieces, including the glusterfs and
glusterfs_fuse vfs modules. They do not contain the active directory domain
controller.

This is automatically run as nightly jobs (initially) for CentOS 7/8 and Fedora
34/35 under the centos-ci [Gluster space](https://ci.centos.org/view/Gluster/) and
published as [yum repositories](http://artifacts.ci.centos.org/gluster/nightly-samba/).
