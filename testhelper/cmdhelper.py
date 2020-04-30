import os

def cifs_mount(mount_params, mount_point, opts="vers=2.1"):
    """Use the cifs module to mount a share.

    Parameters:
    mount_params: Dict containing mount parameters
    mount_point: Directory location to mount the share.
    opts: Additional options to pass to the mount command

    Returns:
    int: return value of the mount command.
    """
    mount_options = opts + ",username=" + mount_params["username"] + ",password=" + mount_params["password"]
    share = "//" + mount_params["host"] + "/" + mount_params["share"]
    cmd = "mount -t cifs -o " + mount_options + " " + share + " " + mount_point
    ret = os.system(cmd)
    assert ret == 0, "Error mounting: ret %d cmd: %s\n" % (ret, cmd)
    return ret

def cifs_umount(mount_point):
    """Unmount a mounted filesystem.

    Parameters:
    mount_point: Directory of the mount point.

    Returns:
    int: return value of the umount command.
    """
    cmd = "umount -fl %s" % (mount_point)
    ret = os.system(cmd)
    assert ret == 0, "Error mounting: ret %d cmd: %s\n" % (ret, cmd)
    return ret
