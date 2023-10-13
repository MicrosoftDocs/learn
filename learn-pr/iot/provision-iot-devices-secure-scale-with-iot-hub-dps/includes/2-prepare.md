To prepare for the exercises, you're going through the steps required to create a resource group, IoT hub, and Device Provisioning Service (DPS). Then you'll link the IoT hub to the DPS instance. Next, you save resource group, IoT hub, and DPS instance identifiers for use in the exercises.

## Setup

As part of this module, the following resources will be created:

* Azure IoT Hub
* Azure IoT Device Provisioning Service (DPS)
* Two simulated devices in C#

### Cloud resources

To complete this guided project, you need an IoT hub and a Device Provisioning Service (DPS) instance that are linked to each other. Creating these service instance can take several minutes.

1. Start by **activating the Azure sandbox**. The sandbox automatically creates an Azure resource group for you that is displayed on the sandbox web page. You'll create additional resources for this project using the following steps; the resource group is substited automatically within steps that it is used.

1. Create a variable named **suffix** with a random number that you'll use for resource names that need to be globally unique.

   ```azurecli
   let suffix=$RANDOM*$RANDOM
   echo $suffix
   ```

1. Create an IoT hub in the resource group created by the Azure sandbox.

   ```azurecli
   az iot hub create --name hub-$suffix --resource-group <rgn>[sandbox resource group name]</rgn> --location westus
   ```


1. Create a Device Provisioning Service instance. Substitute the resource group number from steps 1 for [sandbox resource group name] in the following script.

   ```azurecli
   az iot dps create --name dps-$suffix --resource-group <rgn>[sandbox resource group name]</rgn> --location westus
   ```

1. Get the service connection string from your IoT hub, which you'll provide to the DPS instance to link the two resources.

   ```azurecli
   hubConnectionString=$(az iot hub connection-string show --hub-name hub-$suffix --key-type primary --query connectionString -o tsv)
   echo $hubConnectionString
   ```

1. Add your IoT hub as a linked hub to your DPS instance. Linking an IoT hub means that the DPS instance can provision devices to that IoT hub. Substitute the resource group number from steps 1 for [sandbox resource group name] in the following script.

   ```azurecli
   az iot dps linked-hub create --dps-name dps-$suffix --resource-group <rgn>[sandbox resource group name]</rgn> --connection-string $hubConnectionString --location westus
   ```

1. Once the deployment has completed, open a text editor tool. Use the text editor to store some configuration values associated with your Azure resources. In your text editor, save the following values to use in the next units:

   * Resource group name
   * IoT Hub connection string
   * DPS name
   * DPS scope ID

### Development resources

To simulate your IoT devices provisioning through Device Provisioning Service, you'll run two C# applications on your development machine. Have the following prerequisites ready on your development machine:

* [Visual Studio Code](https://code.visualstudio.com/download)
* [.NET SDK 6.0 or later](https://dotnet.microsoft.com/download)
