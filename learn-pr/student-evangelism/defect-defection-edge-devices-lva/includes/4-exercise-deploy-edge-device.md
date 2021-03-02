## Create cloud resources

1. Add the Azure IoT extension to the Cloud Shell instance.

   ```
   az extension add --name azure-iot
   ```

   > [!NOTE] This module uses the newest version of the Azure IoT extension, called `azure-iot`. The legacy version is called `azure-cli-iot-ext`. You should only have one version installed at a time. You can use the command `az extension list` to validate the currently installed extensions.
   >
   > To see what extensions you have installed, use `az extension list`.
   >
   > Use `az extension remove --name azure-cli-iot-ext` to remove the legacy version of the extension.


2. Create a resource group to manage all the resources you use for this module. Give a name to your resource group.

   ```
   az group create --name {resource_group_name} --location westus2
   ```

## Create an IoT hub

Create a free **F1** hub in the resource group. Replace `{hub_name}` with a unique name for your IoT hub. It might take a few minutes to create an IoT Hub.

   ```
   az iot hub create --resource-group {resource_group_name} --name {hub_name} --sku F1 --partition-count 2
   ```

> [!NOTE] If you get an error because there's already one free hub in your subscription, change the SKU to **S1**. Each subscription can only have one free IoT hub. If you get an error that the IoT Hub name isn't available, it means that someone else already has a hub with that name. Try a new name.

## Register an IoT Edge device

Register an IoT Edge device with your newly created IoT hub.

1. Create a device named **myEdgeDevice** in your hub.

   ```
   az iot hub device-identity create --device-id myEdgeDevice --edge-enabled --hub-name {hub_name}
   ```

   > [!NOTE] If you get an error about iothubowner policy keys, make sure that your Cloud Shell is running the latest version of the azure-iot extension.

2. View the connection string for your device, which links your physical device with its identity in IoT Hub. It contains the name of your IoT hub, the name of your device, and then a shared key that authenticates connections between the two. We'll refer to this connection string again in the next section when you set up your IoT Edge device.

   ```
   az iot hub device-identity connection-string show --device-id myEdgeDevice --hub-name {hub_name} --output table
   ```


3. Make a note of the device connection string, which looks like:

   ```
   HostName={YourIoTHubName}.azure-devices.net;DeviceId=myEdgeDevice;SharedAccessKey={YourSharedAccessKey}
   ```

## Configure your IoT Edge device

Click on the **Deploy** button to create a virtual machine with Azure IoT Edge runtime pre-installed (via cloud-init) using ARM template. During the runtime configuration, you provide a device connection string. This is the string that you retrieved from the Azure CLI. This string associates your physical device with the IoT Edge device identity in Azure.

[![img](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fazure%2Fiotedge-vm-deploy%2Fmaster%2FedgeDeploy.json)

## Open network port 8181

1. Go to https://portal.azure.com/#home. Click on Virtual Machines.

   ![Diagram - Go to Azure Portal to create Virtual Machine](https://github.com/linkernetworks/azure-intelligent-edge-patterns/raw/develop/factory-ai-vision/assets/go%20to%20azure%20portal_1.png)

2. On the list of devices, click on the device that you would like to deploy.

   ![Diagram - Create Virtual Machine and go to networking](https://github.com/linkernetworks/azure-intelligent-edge-patterns/raw/develop/factory-ai-vision/assets/go%20to%20azure%20portal_2.png)
   
3. Go to Networking.
   ![Diagram - Create Virtual Machine and go to networking](https://github.com/linkernetworks/azure-intelligent-edge-patterns/raw/develop/factory-ai-vision/assets/go%20to%20azure%20portal_3.png)

4. Click on 'Add Inbound Port Rule'.

   ![Diagram - Create Virtual Machine and go to networking](https://github.com/linkernetworks/azure-intelligent-edge-patterns/raw/develop/factory-ai-vision/assets/go%20to%20azure%20portal_4.png)

5. Fill out 'Destination port ranges' and 'Name'. After this, you will see a pop up telling you that it’s creating security rule ‘Port_8181’.

   ![Diagram - Create Virtual Machine and go to networking](https://github.com/linkernetworks/azure-intelligent-edge-patterns/raw/develop/factory-ai-vision/assets/go%20to%20azure%20portal_5.png)

   ![Diagram - Create Virtual Machine and go to networking](https://github.com/linkernetworks/azure-intelligent-edge-patterns/raw/develop/factory-ai-vision/assets/go%20to%20azure%20portal_6.png)

   ![Diagram - Create Virtual Machine and go to networking](https://github.com/linkernetworks/azure-intelligent-edge-patterns/raw/develop/factory-ai-vision/assets/go%20to%20azure%20portal_7.png)