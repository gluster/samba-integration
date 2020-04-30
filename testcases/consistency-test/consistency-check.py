#!/bin/python

# Test mounts a cifs share, creates a new file on it, writes to it, deletes the file and unmounts

import testhelper
import os, sys

test_string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'

def file_content_check(f, comp_str):
    read_data = f.read()
    return read_data == comp_str

if (len(sys.argv) != 2):
    print("Usage: %s <test-info.yml>" % (sys.argv[0]))
    exit(1)

test_info_file = sys.argv[1]
test_info = testhelper.read_yaml(test_info_file)

tmp_root = testhelper.get_tmp_root()
mount_point = testhelper.get_tmp_mount_point(tmp_root)
mount_params = testhelper.get_default_mount_params(test_info)
share = mount_params["share"]

# First open the default share and write a file with contents
# set to the test_string
flag_share_mounted = 0
flag_file_created = 0
try:
    testhelper.cifs_mount(mount_params, mount_point)
    flag_share_mounted = 1
    test_file = testhelper.get_tmp_file(mount_point)
    flag_file_created = 1
    with open(test_file, 'w') as f:
        f.write(test_string)
    testhelper.cifs_umount(mount_point)
    flag_share_mounted = 0

    for i in range(1, testhelper.get_total_mount_parameter_combinations(test_info)):
        mount_params = testhelper.get_mount_parameter(test_info, share, i)
        testhelper.cifs_mount(mount_params, mount_point)
        flag_share_mounted = 1
        with open(test_file, 'r') as f:
            assert file_content_check(f, test_string), "File content does not match"
        testhelper.cifs_umount(mount_point)
        flag_share_mounted = 0

except:
    print("Error while executing test")
    raise

finally:
    if (flag_file_created == 1):
        testhelper.cifs_mount(mount_params, mount_point)
        os.unlink(test_file)
        testhelper.cifs_umount(mount_point)
    if (flag_share_mounted == 1):
        testhelper.cifs_umount(mount_point)
    os.rmdir(mount_point)
    os.rmdir(tmp_root)
