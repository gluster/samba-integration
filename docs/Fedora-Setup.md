The following instructions are for fresh install of Fedora 33.
I will be running all the commands as a non-privileged user part of groups
libvirt - to allow user to create virtual machines using libvirtd
and wheel -  to allow sudo access.

Modify the steps accordingly for your setup.

Ensure the following packages are installed
> $ sudo dnf install qemu-kvm qemu-img git vagrant vagrant-libvirt ansible make libvirt-client

For Fedora 33, we have to enable the use_session variable for vagrant libvirt vms to run properly. To do this, create a file ~/.vagrant.d/Vagrantfile with the following content
```
Vagrant.configure("2") do |config|
   config.vm.provider :libvirt do |libvirt|
     libvirt.qemu_use_session = false
   end
end
```

Git clone the samba-integration git repository.
```
$ git clone https://github.com/gluster/samba-integration.git
```

Build the test environment with the following command
```
$ cd samba-integration/
$ make
```

The first run will take longer than usual as Vagrant downloads the CentOS8 image from its repository. Subsequent runs will use the image from cache and the setup will be quicker.

To run the CentOS7 version of test vms
```
$ cd samba-integration/
$ EXTRA_VARS="use_distro=centos7" make
```

If you encounter failures bringing up the vagrant vms, you can check for more details by switching into the vagrant directory and manually bring up the machine.
```
$ cd samba-integration/vagrant
$ vagrant up
```
Clean up with a 'make clean' command when done.

The most common fault seen is because of the location of the default storage pool which could lead to permission issues. In this case, edit the default storage pool and switch to a directory which can be accessed by your user.

Before you can reinstall the cluster setup, you will want to clear up the existing machines.
```
$ cd samba-integration/
$ make clean
```
This clears up all the vms and temporary files created by the tool and the system is ready for a rebuild
