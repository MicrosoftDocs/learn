


## Starting the Virtual Disk Server

Applications running on CP/M will have read/write access to drive B: enabling you can save files with the virtual disk server running. The virtual disk server can run on your desktop, a local computer, such as a Raspberry Pi, or in a cloud-based Azure Virtual Machine.

Disk sectors reads and writes for drive B: are redirected over MQTT to the Mosquitto MQTT Broker and then to a back-end Python-based virtual disk server. Disk sectors are also cached on one of the real-time cores to significantly improve read/write performance on the Altair emulator.

![Altair Web Terminal Architecture ](../media/altair-web-terminal.png)

### Run the Python Virtual Disk Server

From terminal window:

1. Ensure Python3 is installed on your computer. You can install it from [Python.org](www.python.org)
1. Navigate to **AltairPY_virtual_disk_server** folder.
1. Start the Python Virtual Disk Server

    On Windows start as follows:

    ```bash
    python PyDiskSvr.py -b test.mosquitto.org -c <YOUR DEVICE CHANNEL ID FROM IOT CENTRAL>
    ```
    
    On Linux start as follows:

    ```bash
    python3 PyDiskSvr.py -b test.mosquitto.org -c <YOUR DEVICE CHANNEL ID FROM IOT CENTRAL>
    ```
    
1. Leave the PyDiskSvr Python application running in the background.

