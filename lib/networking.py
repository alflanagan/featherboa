"""
Functions/classes for wireless network communications.
"""

from secrets import WIFI_PASSWORD, WIFI_SSID

from wifi import Network, radio


def get_network_list():
    """
    Get a list of all available wireless networks.

    returns: list of networks, properties are:
      'authmode', 'bssid', 'channel', 'country', 'rssi', 'ssid'
    """
    netlist = radio.start_scanning_networks()
    return netlist


def get_network_by_ssid(ssid: str):
    """
    Get a network by its SSID.

    returns: Network object
    """
    netlist = get_network_list()
    for network in netlist:
        if network.ssid == ssid:
            return network
    return None

def connect_home_network():
    radio.connect(WIFI_SSID, WIFI_PASSWORD)
    print(f"Connected to {WIFI_SSID}")