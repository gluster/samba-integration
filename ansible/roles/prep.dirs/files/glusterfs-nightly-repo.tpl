config_opts['yum.conf'] += """

[gluster-nightly-master]
name=Gluster Nightly builds (master branch)
baseurl=http://artifacts.ci.centos.org/gluster/nightly/master/$releasever/$basearch
enabled=1
gpgcheck=0
"""
