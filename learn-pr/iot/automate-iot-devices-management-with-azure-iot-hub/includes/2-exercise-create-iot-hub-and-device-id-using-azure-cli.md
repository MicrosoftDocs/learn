In this unit, we'll first create an IoT Hub, and add a single device to that hub. Then we will record the connection strings we need for the coding sections of this module.

## Create a custom IoT Hub

1. Make sure you've activated the sandbox, using the button above. The sandbox will give you access to free Azure resources for the duration of this module.
1. In the below we are using the Azure IoT extension for Azure CLI which is already installed in the sandbox. If you want to use the extension for your developments, you can find instructions on how to install it [here](https://github.com/Azure/azure-iot-cli-extension).
1. Run this command to create a new IoT Hub instance
    >[!IMPORTANT]
    >Your hub names are publicly discoverable, so take this into account when entering names. Hub names must also be unique, as they form part of the Azure URL. You can use a name like *cheesecavesmanager-anID*

    ``` Azure CLI
    az iot hub create --name {your iot hub name} --resource-group <rgn>[sandbox resource group name]</rgn> --sku S1
    ```

## Create an IoT Hub device identity

1. Now that the hub is created, let's add a new device ID to be used to securely connect our device simulator. Run the following command:

    ``` Azure CLI
    az iot hub device-identity create --hub-name {your iot hub name} --device-id {your device id}
    ```

2. Let get the connection string we will need for our device simulator. Ener Run the following command and write down the output

    ``` Azure CLI
    az iot hub device-identity show-connection-string --hub-name {your iot hub name} --device-id {your device id}
    ```

You've now completed the preparatory work for this module, the next steps are all coding and testing. Before we advance though, a quick knowledge check!