## Using the Azure Cloud Shell  

To start Azure Cloud Shell,  
Go to [**https://shell.azure.com**](https://shell.azure.com)

![An illustration is showing how to connect azure cloud shell.](../media/cloud-shell.png)

You also need to add the Azure IoT extension to the cloud shell instance Azure CLI using the following command.

```azurecli
az extension add --name azure-cli-iot-ext
```

![An illustration is showing that adding azurecli extension.](../media/cli-iot-ext.png)

## Creating a resource group

Create a resource group called IoTEdgeResources using the following command.

```azurecli
az group create --name IoTEdgeResources --location eastus2
```

![An illustration is showing that creating resource group](../media/resource-group.png)

## Creating a virtual machine to act as your device.  

Accept the terms of use and create the Microsoft-provided Azure IoT Edge on Ubuntu virtual machine. This virtual machine preinstalls everything you need to run IoT Edge on a device.

Create the virtual machine named EdgeVM using the following commands:  

```azurecli
az vm image accept-terms --urn microsoft_iot_edge:iot_edge_vm_ubuntu:ubuntu_1604_edgeruntimeonly:latest
```

![An illustration is showing that accepting license terms to create the virtual device.](../media/vm-accept-license.png)

```azurecli
az vm create --resource-group IoTEdgeResources --name EdgeVM --image microsoft_iot_edge:iot_edge_vm_ubuntu:ubuntu_1604_edgeruntimeonly:latest --admin-username azureuser --generate-ssh-keys
```

![An illustration is showing that creating the virtual device.](../media/create-vm.png)

It may take a few minutes to create and start the new virtual machine.

Note the public IP address (publicIpAddress) which is provided as part of the create command output. You'll use this to connect to the virtual machine in later steps.

## Create an IoT hub

The following code creates a free F1 hub in the resource group IoTEdgeResources. Replace {hub_name} with a unique name for your IoT Hub.


```azurecli
az iot hub create --resource-group IoTEdgeResources --name {hub_name} --sku S1
```

## Registering an IoT Edge device

Create a device identity for your IoT Edge device  

In the Azure cloud shell, enter the following command to create a device named myEdgeDevice in your hub.

Since IoT Edge devices behave and can be managed differently than typical IoT devices, declare this identity to be for an IoT Edge device with the --edge-enabled flag.

If you get an error about iothubowner policy keys, make sure that your cloud shell is running the latest version of the azure-cli-iot-ext extension.

```azurecli
az iot hub device-identity create --hub-name {hub_name} --device-id myEdgeDevice --edge-enabled
```

![An illustration is showing that creating device identity.](../media/create-device-id.png)

## Retrieving the connection string for your device

To retrieve the connection string for your device, which links your physical device with its identity in IoT Hub use the command.

```azurecli
az iot hub device-identity show-connection-string --device-id myEdgeDevice --hub-name {hub_name}
```

![An illustration is showing the connection string.](../media/show-conn-string.png)

Copy the value of the connectionString key from the JSON output and save it. This value is the device connection string. You'll use this connection string to configure the IoT Edge runtime in the next section.

## Configuring your IoT Edge device

You need to configure your device with the device connection string that you retrieved in the previous section. You can do this remotely without having to connect to the virtual machine. Run the following command, replacing {device_connection_string} with your own string.

```azurecli
az vm run-command invoke -g IoTEdgeResources -n EdgeVM --command-id RunShellScript --script "/etc/iotedge/configedge.sh '{device_connection_string}'"
```

![An illustration is showing how to set up connection string to the virtual device.](../media/setup-conn-string.png)

## Viewing the IoT Edge runtime status

Use the following command to connect to your virtual machine. Replace {azureuser} if you used a different username than the one suggested in the prerequisites. Replace {publicIpAddress} with your machine's address.

```bash
ssh azureuser@{publicIpAddress}
```

![An illustration is showing that connecting to the virtual device.](../media/connect-vm.png)

![An illustration is showing where to find publicIpAddress.](../media/public-ip-address.png)

## Checking if the IoT Edge device is configured

You'll check to see that the IoT Edge security daemon is running as a system service by using iotedge commands. You need elevated privileges to run iotedge commands.  

You run the following commands to test the status of the IoT Edge device.

```bash
sudo systemctl status iotedge
```

![An illustration is showing status of Azure IoT Edge Deamon.](../media/deamon-status.png)


```bash
journalctl -u iotedge
```

```bash
sudo iotedge list
```
![An illustration is showing the list of modules running on the virtual device.](../media/iotedge-module-list.png)

Your IoT Edge device is now configured. It's ready to run cloud-deployed modules.
