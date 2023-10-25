Here, we discuss the overall goals of the project and how to prepare resources for the exercises.

## Project overview

In this module, you begin by creating Azure resources that are required to complete this module, such as an instance of IoT Hub Device Provisioning Service (DPS) and an IoT hub. You then generate an X.509 root CA Certificate using OpenSSL within the Azure Cloud Shell, and use the root certificate to configure a Group Enrollment within the Device Provisioning Service (DPS). After that, you use the root certificate to generate two device certificates, which you use within a simulated device code to provision the devices to an IoT hub. While in your device code, you implement access to the device twin properties used to perform initial configuration of the device. You then test your simulated device. To finish up this module, you deprovision the entire group enrollment.

## Setup

As part of this module, the following resources are created:

* An Azure IoT hub
* An Azure IoT Device Provisioning Service (DPS) instance
* Two simulated devices in C#

### Cloud resources

To complete this guided project, you need an IoT hub and a Device Provisioning Service (DPS) instance that are linked to each other. Creating these service instances can take several minutes.

1. Start by clicking the **Activate sandbox** button. The sandbox automatically creates an Azure resource group for you that is displayed on this web page. You create more resources for this project using the following steps. The resource group name is substituted automatically where it's used within the code steps.

   > [!NOTE]
   > The sandbox Azure Cloud Shell will time out after 20 minutes of inactivity. The sandbox will still be available and the Cloud Shell can be reactivated, but command-line and environment variables will be lost. Your IoT Hub and Device Provisioning Service (DPS) instances are functional and available. Make sure you copy these values as instructed at the end of this page so that you can still reference and enter the values in upcoming Cloud Shell commands when necessary.

1. Install the Azure IoT extension for Azure CLI.

   ```azurecli
   az extension add --name azure-iot
   ```

1. Create a variable named **suffix** with a random number that you use for resource names that need to be globally unique.

   ```azurecli
   let suffix=$RANDOM*$RANDOM
   echo $suffix
   ```

1. Create an IoT hub in the resource group name created by the Azure sandbox.

   ```azurecli
   az iot hub create --name hub-$suffix --resource-group <rgn>[sandbox resource group name]</rgn> --location westus
   ```

1. Create a Device Provisioning Service (DPS) instance in the resource group created by the Azure sandbox.

   ```azurecli
   az iot dps create --name dps-$suffix --resource-group <rgn>[sandbox resource group name]</rgn> --location westus
   ```

1. Get the hub connection string from your IoT hub, which you provide to the DPS instance to link the two resources.

   ```azurecli
   hubConnectionString=$(az iot hub connection-string show --hub-name hub-$suffix --key-type primary --query connectionString -o tsv)
   echo $hubConnectionString
   ```

1. Add your IoT hub as a linked hub to your DPS instance. Linking an IoT hub means that the DPS instance can provision devices to that IoT hub.

   ```azurecli
   az iot dps linked-hub create --dps-name dps-$suffix --resource-group <rgn>[sandbox resource group name]</rgn> --connection-string $hubConnectionString
   ```

1. Once the deployment has completed, open a text editor tool. Use the text editor to store configuration values associated with your Azure resources in case your sandbox times out after 20 minutes. In your text editor, save the following names and values to use in the next unit pages.

   | Name    | Value |
   | -------- | ------- |
   | Resource group name  | Listed on this web page |
   | IoT hub connection string | Stored in `$hubConnectionString` |
   | IoT hub name | The value for `name` in the JSON data returned from the `az iot hub create` command you ran in step 3. For example, a value for  `"name"` is `"hub-586732230"`.    |
   | DPS name    | The value for `name` in the JSON data returned from the `az iot dps create` command you ran in step 4. For example, a value for  `"name"` is `"dps-586732230"`.    |
   | DPS ID scope | The value for `idScope` in the JSON data returned from the `az iot dps create` command you ran in step 4. For example, the value for `"idScope"` is `"0ne00B3761F"`.

### Development resources

To simulate your IoT devices provisioning through Device Provisioning Service, you run two C# applications on your development machine. Have the following prerequisites ready on your development machine:

* [Visual Studio Code](https://code.visualstudio.com/download)
* [.NET SDK 6.0 or later](https://dotnet.microsoft.com/download)
