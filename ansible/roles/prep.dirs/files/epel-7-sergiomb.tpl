config_opts['yum.conf'] += """

[copr:copr.fedorainfracloud.org:sergiomb:SambaAD]
name=Copr repo for SambaAD owned by sergiomb
baseurl=https://download.copr.fedorainfracloud.org/results/sergiomb/SambaAD/epel-7-$basearch/
type=rpm-md
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://download.copr.fedorainfracloud.org/results/sergiomb/SambaAD/pubkey.gpg
repo_gpgcheck=0
enabled=1
enabled_metadata=1
 """
