The Azure IoT Edge runtime is what turns a device into an IoT Edge device. The runtime can be deployed on devices as small as a Raspberry Pi or as large as an industrial server. Once a device is configured with the IoT Edge runtime, we can deploy containerized workloads based on deployment configurations defined our Azure IoT Hub.

The following steps are to be completed on an [NVIDIA Jetson Embedded Device](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/) provisioned with [JetPack 4.5.1 GA](https://developer.nvidia.com/jetpack-sdk-451-archive) and assumes that you have completed the steps described in the previous modules `Setup and Configuration of an NVIDIA DeepStream Development Environment` and `Introduction to DeepStream 6.0 Graph Composer with Microsoft Azure`.

1. To manually provision your NVIDIA Jetson device, you need to provide it with a device connection string that you can create by registering a new IoT Edge device in your IoT hub.

    Create a new device connection string by following the documentation for "[Register and IoT Edge device in IoT Hub](/azure/iot-edge/how-to-register-device)". You only need to follow the steps in "Option 1: Register with symmetric keys" and may skip the instructions in "Option 2: Register with X.509 certificates". Follow the steps to register your device and be sure to use a descriptive name.  For example, if using a Jetson Xavier device, use a name like "jetson-xavier-01".  After you have competed the steps to register your device, you will want to familiarize with the process described in "View registered devices and retrieve connection strings".

1. Now that we have obtained a connection string, we will follow the steps to install the Azure IoT Edge runtime onto the NVIDIA Jetson embedded device.  Follow the instructions in the documentation for "[Install or uninstall Azure IoT Edge for Linux](/azure/iot-edge/how-to-install-iot-edge)".  

    You should follow the steps mentioned in "Option 1: Authenticate with symmetric keys" and may skip the instructions in "Option 2: Authenticate with X.509 certificates".  You can also ignore the instructions in "Uninstall IoT Edge".

1. You can verify that all steps have been completed by running the following commands in a terminal on the NVIDIA Jetson Embedded device:

    ```Bash
    sudo iotedge list
    ```

    When the IoT Edge Runtime is successfully started for the first time, this command should display output indicating that only the `edgeAgent` module is running.  

1. It is important to note that before we run our containerized DeepStream Graph workload, it will require that we grant access to the X11 display environment when running from a container due to the workload using an output sink of type EGL (`type`= 2).  Execute the following commands from a terminal on the NVIDIA Embedded device to enable access to the X11 services:

    ```Bash
    sudo xhost +
    ```

When you have verified that IoT Edge has been appropriately installed and configured and enabled container access to X11 services on the device, we can now proceed with steps to deploy the `deepstream_test4_jetson:v1` module that was published to our Azure Container Registry in the previous section.
