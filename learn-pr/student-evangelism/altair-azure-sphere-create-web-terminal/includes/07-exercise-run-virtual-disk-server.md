In this exercise, you'll install and run the Altair emulator virtual disk server.

## Start the Virtual Disk Server

From a terminal window:

1. Ensure Python version 3 is installed on your computer. You can install Python 3 from [Python.org](https://www.python.org?azure-portal=true)
1. Install the paho-mqtt Python library.

    ```bash
    pip3 install paho-mqtt
    ```

1. Navigate to **AltairPY_virtual_disk_server** folder.

1. Start the Python Virtual Disk Server

    On Windows, start as follows:

    ```bash
    python PyDiskSvr.py -b test.mosquitto.org -c <YOUR DEVICE CHANNEL ID FROM IOT CENTRAL>
    ```

    On Linux, start as follows:

    ```bash
    python3 PyDiskSvr.py -b test.mosquitto.org -c <YOUR DEVICE CHANNEL ID FROM IOT CENTRAL>
    ```

1. Leave the PyDiskSvr Python application running in the background.


