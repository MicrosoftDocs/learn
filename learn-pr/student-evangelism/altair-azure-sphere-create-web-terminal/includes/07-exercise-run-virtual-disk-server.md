In this exercise, you'll install and run the Altair emulator virtual disk server.

Before you begin, ensure that Python version 3 is installed on your computer. You can install Python 3 from [Python.org](https://www.python.org?azure-portal=true).

1. From a terminal window, install the paho-mqtt Python library by running the following command:

    ```bash
    pip3 install paho-mqtt
    ```

1. Go to the *AltairPY_virtual_disk_server* folder.

1. Start the Python virtual disk server by running either of the following commands:

    * For Windows, run:

      ```bash
      python PyDiskSvr.py -b test.mosquitto.org -c <YOUR DEVICE CHANNEL ID FROM AZURE IOT CENTRAL>
      ```

    * For Linux, run:

      ```bash
      python3 PyDiskSvr.py -b test.mosquitto.org -c <YOUR DEVICE CHANNEL ID FROM AZURE IOT CENTRAL>
      ```

1. Leave the PyDiskSvr Python application running in the background.


