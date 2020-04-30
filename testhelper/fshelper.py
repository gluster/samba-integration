import os

TMP_DIR = "/tmp/"

def get_tmp_root():
    """Returns a temporary directory for use

    Parameters:
    none

    Returns:
    tmp_root: Location of the temporary directory.
    """
    tmp_root = TMP_DIR + "/" + str(os.getpid())
    i=0
    while (os.path.exists(tmp_root)):
        tmp_root = tmp_root + str(i)
        i = i + 1
    os.mkdir(tmp_root)
    return tmp_root

def get_tmp_mount_point(tmp_root):
    """Return a mount point within the temporary directory

    Parameters:
    tmp_root: Directory in which to create mount point.

    Returns:
    mnt_point: Directory location in which you can mount a share.
    """
    i = 0
    mnt_point = tmp_root + "/mnt_" + str(i)
    while (os.path.exists(mnt_point)):
        i = i + 1
        mnt_point = tmp_root + "/" + str(i)
    os.mkdir(mnt_point)
    return mnt_point

def get_tmp_file(tmp_root):
    """Return a temporary file within the temporary directory

    Parameters:
    tmp_root: Directory in which to create temporary file.

    Returns:
    tmp_file: Location of temporary file.
    """
    i = 0
    tmp_file = tmp_root + "/tmp_file_" + str(i)
    while (os.path.exists(tmp_file)):
        i = i + 1
        tmp_file = tmp_root + "/tmp_file_" + str(i)
    f = open(tmp_file, 'w')
    f.close()
    return tmp_file

def get_tmp_dir(tmp_root):
    """Return a temporary directory within the temporary directory

    Parameters:
    tmp_root: Directory in which to create temporary directory.

    Returns:
    tmp_dir: Location of temporary directory.
    """
    i = 0
    tmp_dir = tmp_root + "/tmp_dir_" + str(i)
    while (os.path.exists(tmp_dir)):
        i = i + 1
        tmp_dir = tmp_root + "/tmp_dir_" + str(i)
        os.mkdir(tmp_dir)
    return tmp_dir
