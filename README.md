# Samba CentOS/Fedora RPM Builds

[![status](<https://jenkins-samba.apps.ocp.ci.centos.org/buildStatus/icon?job=samba_build-rpms-fedora35-master&subject=master / Fedora 35>)](https://jenkins-samba.apps.ocp.ci.centos.org/job/samba_build-rpms-fedora35-master/) [![status](<https://jenkins-samba.apps.ocp.ci.centos.org/buildStatus/icon?job=samba_build-rpms-fedora35-v4-16-test&subject=v4-16-test / Fedora 35>)](https://jenkins-samba.apps.ocp.ci.centos.org/job/samba_build-rpms-fedora35-v4-16-test/) [![status](<https://jenkins-samba.apps.ocp.ci.centos.org/buildStatus/icon?job=samba_build-rpms-fedora35-v4-15-test&subject=v4-15-test / Fedora 35>)](https://jenkins-samba.apps.ocp.ci.centos.org/job/samba_build-rpms-fedora35-v4-15-test/)

[![status](<https://jenkins-samba.apps.ocp.ci.centos.org/buildStatus/icon?job=samba_build-rpms-fedora36-master&subject=master / Fedora 36>)](https://jenkins-samba.apps.ocp.ci.centos.org/job/samba_build-rpms-fedora36-master/) [![status](<https://jenkins-samba.apps.ocp.ci.centos.org/buildStatus/icon?job=samba_build-rpms-fedora36-v4-16-test&subject=v4-16-test / Fedora 36>)](https://jenkins-samba.apps.ocp.ci.centos.org/job/samba_build-rpms-fedora36-v4-16-test/) [![status](<https://jenkins-samba.apps.ocp.ci.centos.org/buildStatus/icon?job=samba_build-rpms-fedora36-v4-15-test&subject=v4-15-test / Fedora 36>)](https://jenkins-samba.apps.ocp.ci.centos.org/job/samba_build-rpms-fedora36-v4-15-test/)

[![status](<https://jenkins-samba.apps.ocp.ci.centos.org/buildStatus/icon?job=samba_build-rpms-centos8-master&subject=master / CentOS 8>)](https://jenkins-samba.apps.ocp.ci.centos.org/job/samba_build-rpms-centos8-master/) [![status](<https://jenkins-samba.apps.ocp.ci.centos.org/buildStatus/icon?job=samba_build-rpms-centos8-v4-16-test&subject=v4-16-test / CentOS 8>)](https://jenkins-samba.apps.ocp.ci.centos.org/job/samba_build-rpms-centos8-v4-16-test/) [![status](<https://jenkins-samba.apps.ocp.ci.centos.org/buildStatus/icon?job=samba_build-rpms-centos8-v4-15-test&subject=v4-15-test / CentOS 8>)](https://jenkins-samba.apps.ocp.ci.centos.org/job/samba_build-rpms-centos8-v4-15-test/)

[![status](<https://jenkins-samba.apps.ocp.ci.centos.org/buildStatus/icon?job=samba_build-rpms-centos9-master&subject=master / CentOS 9>)](https://jenkins-samba.apps.ocp.ci.centos.org/job/samba_build-rpms-centos9-master/) [![status](<https://jenkins-samba.apps.ocp.ci.centos.org/buildStatus/icon?job=samba_build-rpms-centos9-v4-16-test&subject=v4-16-test / CentOS 9>)](https://jenkins-samba.apps.ocp.ci.centos.org/job/samba_build-rpms-centos9-v4-16-test/) [![status](<https://jenkins-samba.apps.ocp.ci.centos.org/buildStatus/icon?job=samba_build-rpms-centos9-v4-15-test&subject=v4-15-test / CentOS 9>)](https://jenkins-samba.apps.ocp.ci.centos.org/job/samba_build-rpms-centos9-v4-15-test/)

This repository contains automation to create RPMs for CentOS 8/9 and Fedora
from Samba repository. In order to allow building from a variety of git refspecs,
the following make target format is used:

`$ make < rpms.centos8 | rpms.centos9 | rpms.fedora > [ vers=< fedora-version > refspec=< branch-name | tag-name | h:<git-commit-hash> > ]`

Few examples:

- `$ make rpms.centos8 refspec=v4-14-test`
- `$ make rpms.centos9 refspec=h:a0862d6d6de`
- `$ make rpms.fedora vers=34 refspec=samba-4.14.4`

As of now 4.15 4.16 and master branches are supported. In the absence of
*refspec* argument, the master branch is built by default. The above format is
also applicable for other `make` targets. The *vers* argument is only valid for
Fedora related make targets and in its absence, the default version is
set to *36*.

The RPMs contain the Samba file server pieces, including the glusterfs and
glusterfs_fuse vfs modules. They do not contain the active directory domain
controller.

These are automatically run as nightly jobs for CentOS 8/9 and Fedora 35/36 on
[centos-ci](https://jenkins-samba.apps.ocp.ci.centos.org/view/RPMs) and published
as [yum repositories](http://artifacts.ci.centos.org/gluster/nightly-samba/).
