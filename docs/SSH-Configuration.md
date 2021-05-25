##Instructions on setting up your ssh configuration to allow for easy access to the test machines.##

Ensure you have your public ssh key(an any other public keys) added to autorized_files and call the fix_ssh.yml ansible playbook using the command
```
make fix_ssh
```
in the admin directory.

The host machine which has the test vms have the following entries.
```
192.168.123.5 client1
192.168.122.200 setup
192.168.122.100 storage0
192.168.122.101 storage1
```

If accessing from the host machines, you can simply ssh into the machines as listed in the /etc/hosts.

However in my case, I run my test cluster on a remote test machine which can be accessed over ssh. To enable easy access from my local desktop, I have the following setup.

The /etc/hosts on the remote host machine is as follows
```
192.168.123.5 t-client1
192.168.122.200 t-setup
192.168.122.100 t-storage0
192.168.122.101 t-storage1
```
Here an arbitrary string 't-' is prepended to the host names and its use will be evident shortly.

On my desktop, I have an entry for the remote host in /etc/hosts
192.168.21.66 t

I also have the following ssh configuration appended to .ssh/config
```
Host t
        Hostname t
        KeepAlive yes
        ControlMaster yes
        ControlPath /tmp/t_ssh
        
Host t-*
        ProxyCommand ssh -S /tmp/t_ssh exec nc %h %p
        StrictHostKeyChecking no
        UpdateHostKeys yes
```
To initiate a ssh connection to the test machines on the remote host, I first connect to the remote host over ssh using hostname 't'. This opens a control path /tmp/t_ssh. Subsequently connections to test machines eg: t-storage0 uses this control path to open a ssh connection to storage0 on the remote host.
