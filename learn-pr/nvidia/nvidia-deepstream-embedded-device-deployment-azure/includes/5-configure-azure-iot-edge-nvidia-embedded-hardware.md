The Azure IoT Edge runtime is what turns a device into an IoT Edge device. The runtime can be deployed on devices as small as a Raspberry Pi or as large as an industrial server. When a device is configured with the IoT Edge runtime, you can deploy containerized workloads based on deployment configurations that are defined your IoT hub.

Complete the following steps on an [NVIDIA Jetson embedded device](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/?azure-portal=true) provisioned with [JetPack 4.6](https://developer.nvidia.com/jetpack-sdk-46).  You will also need to install the [DeepStream 6.0 package for Jetson](https://developer.nvidia.com/deepstream-6.0_6.0.0-1_arm64deb) to the device. We assume that you have completed the steps described in [Set up and configure an NVIDIA DeepStream development environment](/learn/modules/setup-configure-nvidia-deepstream-development/?azure-portal=true) and [Introduction to NVIDIA DeepStream Graph Composer with Azure](/learn/modules/introduction-nvidia-deepstream-graph-composer-azure/?azure-portal=true).

1. To manually provision your NVIDIA Jetson device, you must provide it with a device connection string that you create by registering a new IoT Edge device in your IoT hub.

    Create a new device connection string as described in the **Option 1: Register with symmetric keys** section in [Register an IoT Edge device in IoT Hub](/azure/iot-edge/how-to-register-device?azure-portal=true). 

    You may skip the instructions in the **Option 2: Register with X.509 certificates** section. Complete the steps to register your device, and be sure to use a descriptive name. For example, if you're using a Jetson Xavier device, use a name like `jetson-xavier-01`. When you registered your device, familiarize yourself with the process described in **View registered devices and retrieve connection strings**.

1. Now that you have obtained a connection string, complete the steps in [Install or uninstall Azure IoT Edge for Linux](/azure/iot-edge/how-to-install-iot-edge?azure-portal=true) and install the Azure IoT Edge runtime on the NVIDIA Jetson embedded device:

    Complete the steps described in **Option 1: Authenticate with symmetric keys**. (You can skip the instructions in **Option 2: Authenticate with X.509 certificates** and **Uninstall IoT Edge**.)

1. Verify that all steps have been completed by running the following commands in a terminal on the NVIDIA Jetson embedded device:

    ```bash
    sudo iotedge list
    ```

    When the IoT Edge runtime is successfully started for the first time, this command's output should indicate that only the `edgeAgent` module is running.

1. Because your containerized DeepStream Graph Composer workload uses an output sink of type EGL (`type`= 2), before you run the workload from a container, you must grant access to the X11 display environment. Run the following commands from a terminal on the NVIDIA embedded device for access to the X11 services:

    ```bash
    sudo xhost +
    ```

When you've verified that IoT Edge has been appropriately installed and configured and you've given container access to X11 services on the device, you can proceed with steps to deploy the `deepstream_test4_jetson:v1` module that you published to your container registry.
