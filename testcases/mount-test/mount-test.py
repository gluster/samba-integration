#!/usr/bin/env python3

# Test mounts a cifs share, creates a new file on it, writes to it, deletes the file and unmounts

import testhelper
import os, sys

test_string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'

if (len(sys.argv) != 2):
    print("Usage: %s <test-info.yml>" % (sys.argv[0]))
    exit(1)

test_info_file = sys.argv[1]
test_info = testhelper.read_yaml(test_info_file)

tmp_root = testhelper.get_tmp_root()
mount_point = testhelper.get_tmp_mount_point(tmp_root)
mount_params = testhelper.get_default_mount_params(test_info)

flag_share_mounted = 0
flag_file_created = 0
try:
    print("\n")
    for i in range(testhelper.get_num_shares(test_info)):
        mount_params["share"] = testhelper.get_share(test_info, i)
        print("Testing //%s/%s" % (mount_params["host"],
                                         mount_params["share"]))
        testhelper.cifs_mount(mount_params, mount_point)
        flag_share_mounted = 1
        test_file = testhelper.get_tmp_file(mount_point)
        flag_file_created = 1
        with open(test_file, 'w') as f:
            f.write(test_string)
        os.unlink(test_file)
        flag_file_created = 0
        testhelper.cifs_umount(mount_point)
        flag_share_mounted = 0
except:
    print("Error while executing test")
    raise
finally:
    if (flag_file_created == 1):
        os.unlink(test_file)
    if (flag_share_mounted == 1):
        testhelper.cifs_umount(mount_point)
    os.rmdir(mount_point)
    os.rmdir(tmp_root)


