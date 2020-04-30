import yaml

def read_yaml(file):
    """Returns a dict containing the contents of the yaml file.

    Parameters:
    arg1: filename of yaml file

    Returns:
    dict: parsed contents of a yaml file
    """
    with open(file) as f:
        test_info = yaml.load(f, Loader=yaml.FullLoader)
    return test_info

def gen_mount_params(host, share, username, password):
    """Generate a dict of parameters required to mount a SMB share.

    Parameters:
    host: hostname
    share: exported share name
    username: username
    password: password for the user

    Returns:
    dict: mount parameters in a dict
    """
    ret = {
        "host" : host,
        "share" : share,
        "username" : username,
        "password" : password
    }
    return ret

def get_default_mount_params(test_info):
    """Pass a dict of type mount_params containing the first parameters to mount the share.

    Parameters:
    test_info: Dict containing the parsed yaml file.

    Returns:
    Dict: of type mount_params containing the parameters to mount the share.
    """
    return gen_mount_params(
        test_info["public_interfaces"][0],
        test_info["exported_sharenames"][0],
        test_info["test_users"][0]["username"],
        test_info["test_users"][0]["password"]
    )

def get_total_mount_parameter_combinations(test_info):
    """Get total number of combinations of mount parameters for each share.
    This is essentially "number of public  interfaces * number of test users"

    Parameters:
    test_info: Dict containing the parsed yaml file.

    Returns:
    int: number of possible combinations.
    """
    return len(test_info["public_interfaces"]) * len(test_info["test_users"])

def get_mount_parameter(test_info, share, combonum):
    """Get the mount_params dict for a given share and given combination number

    Parameters:
    test_info: Dict containing the parsed yaml file.
    share: The share for which to get the mount_params
    combonum: The combination number to use.
    """
    if (combonum > get_total_mount_parameter_combinations(test_info)):
        assert False, "Invalid combination number"
    num_public = combonum / len(test_info["test_users"])
    num_users = combonum % len(test_info["test_users"])
    return gen_mount_params(
        test_info["public_interfaces"][num_public],
        share,
        test_info["test_users"][num_users]["username"],
        test_info["test_users"][num_users]["password"]
    )

