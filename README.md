# Samba-Gluster Integration Test Environment

The purpose of this project is to provide a generic mechanism to set up a
gluster-ctdb-samba cluster as a test environment. The mechanism is built on
vagrant-libvirt and ansible, and should be able to run on any host that has
support for these pieces of software. It is pulling the latest upstream bits
from Gluster and Samba (master branches) for setting up the cluster.

In the case of Gluster, the latest nightly RPM builds from master are pulled.
In the future, we might support options for choosing to consume pre-built RPMS
or building from a given software branch.
