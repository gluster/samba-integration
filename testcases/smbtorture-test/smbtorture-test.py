#!/usr/bin/env python3

# Run smbtorture tests

import testhelper
import sys, os
import yaml

script_root = os.path.dirname(os.path.realpath(__file__))
smbtorture_exec = "/bin/smbtorture"
filter_subunit_exec = "/usr/bin/python3 " + script_root + "/selftest/filter-subunit"
format_subunit_exec ="/usr/bin/python3 " + script_root + "/selftest/format-subunit"

output = testhelper.get_tmp_file("/tmp")

def smbtorture(mount_params, test, output):
    smbtorture_options_str = "--fullname --option=torture:progress=no --option=torture:sharedelay=100000 --option=torture:writetimeupdatedelay=500000"
    smbtorture_cmd = "%s %s --format=subunit --target=samba3 --user=%s%%%s //%s/%s %s 2>&1" % (
                                            smbtorture_exec,
                                            smbtorture_options_str,
                                            mount_params["username"],
                                            mount_params["password"],
                                            mount_params["host"],
                                            mount_params["share"],
                                            test
                                         )

    filter_subunit_options_str = "--fail-on-empty --prefix='samba3.'"
    filter_subunit_filters = "--expected-failures=" + script_root + "/selftest/knownfail"
    filter_subunit_filters = filter_subunit_filters + " --expected-failures=" + script_root + "/selftest/knownfail.d"
    filter_subunit_filters = filter_subunit_filters + " --flapping=" + script_root + "/selftest/flapping"
    filter_subunit_filters = filter_subunit_filters + " --flapping=" + script_root + "/selftest/flapping.d"
    filter_subunit_cmd = "%s %s %s" % (filter_subunit_exec, filter_subunit_options_str, filter_subunit_filters)

    format_subunit_cmd = "%s --immediate" % (format_subunit_exec)

    cmd = "%s|%s|%s > %s" % (
                                smbtorture_cmd,
                                filter_subunit_cmd,
                                format_subunit_exec,
                                output
                            )
    ret = os.system(cmd)
    return ret == 0

if (len(sys.argv) != 3):
    print("Usage: %s <test-info.yml> <smbtorture-tests-info.yml>" % (sys.argv[0]))
    exit(1)

test_info_file = sys.argv[1]
test_info = testhelper.read_yaml(test_info_file)
mount_params = testhelper.get_default_mount_params(test_info)

smbtorture_tests_info_file = sys.argv[2]

with open(smbtorture_tests_info_file) as f:
    smbtorture_info = yaml.safe_load(f)

print("")
for torture_test in smbtorture_info:
    print("\t{:<20}".format(torture_test)),
    ret = smbtorture(mount_params, torture_test, output)
    if (ret == False):
        print("{:>10}".format("[Failed]"))
        print("\n")
        with open(output) as f:
            print(f.read())
        assert False
    print("{:>10}".format("[OK]"))
