"""
Functions/classes for wireless network communications.
"""
import os

from adafruit_portalbase.wifi_esp32s2 import WiFi
from wifi import radio

# import adafruit_requests as requests
# from wifi_esp32s2 import WiFi
# cache secrets to prevent re-reading from filesystem (settings.toml)
WIFI_SSID = ""
WIFI_PASSWORD = ""


def get_ssid():
    global WIFI_SSID
    if WIFI_SSID:
        return WIFI_SSID
    WIFI_SSID = os.getenv("WIFI_SSID")
    return WIFI_SSID


def get_pwd():
    global WIFI_PASSWORD
    if WIFI_PASSWORD:
        return WIFI_PASSWORD
    WIFI_PASSWORD = os.getenv("WIFI_PASSWORD")
    return WIFI_PASSWORD


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
    radio.connect(get_ssid(), get_pwd())
    print(f"Connected to {get_ssid()}")


def setup():
    """
    Setup the ESP32-S2 for wireless network communication.
    """
    wifi = WiFi()
    wifi.connect(get_ssid(), get_pwd())
