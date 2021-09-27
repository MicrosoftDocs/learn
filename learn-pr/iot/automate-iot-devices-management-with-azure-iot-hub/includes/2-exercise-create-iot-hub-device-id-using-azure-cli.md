In this unit, we'll first create an IoT Hub, and add a single device to that hub. Then, we'll record the connection strings we need for the coding sections of this module.

## Create a new IoT Hub

1. Make sure you've activated the sandbox. The sandbox will give you access to free Azure resources for the duration of this module.

1. In the following steps, we're using the [Azure IoT extension for Azure CLI](https://github.com/Azure/azure-iot-cli-extension). To install the extension, enter following command in Azure Cloud Shell:

    > [!NOTE]
    > To paste code and commands in the Cloud Shell, you need to right click. and select **Paste**.

    ```azurecli
    az extension add --name azure-iot
    ```

1. Run the following  command to create a new IoT Hub instance.

    >[!IMPORTANT]
    >Your hub names are publicly discoverable, so take this into account when entering names. Hub names must also be unique, as they form part of the Azure URL. You can use a name like *cheesecavesmanager-anID*.

    ```azurecli
    az iot hub create --name {your iot hub name} --resource-group <rgn>[sandbox resource group name]</rgn> --sku S1
    ```

    > [!NOTE]
    > Across the module, you'll have to run commands like the previous one in Cloud Shell that might take some time to run. Be patient, as Azure creates and configures resources for you.

## Create an IoT Hub device identity

1. Now that the hub is created, let's add a new device ID to be used to securely connect our device simulator. Run the following command:

    ```azurecli
    az iot hub device-identity create --hub-name {your iot hub name} --device-id {your device id}
    ```

2. Let's get the connection string we'll need for our device simulator. Run the following command and write down the output:

    ```azurecli
    az iot hub device-identity connection-string show --hub-name {your iot hub name} --device-id {your device id}
    ```

You've now completed the preparatory work for this module. The next steps are all coding and testing. Before we advance though, a quick knowledge check!
