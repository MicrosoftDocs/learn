In this module, you create a simulated device that sends vibration telemetry to your IoT hub. With simulated data arriving at the IoT hub, you implement an IoT Hub message route and Azure Stream Analytics job that can be used to process device messages. In both cases, data is delivered to a Blob Storage container that is used to verify successful implementation. 

## Setup

As part of this module, the following resources are created:

* Azure IoT Hub
* Azure Stream Analytics
* Azure Blob Storage
* A simulated device in C#

### Cloud resources

Before you begin the exercises, you need an IoT hub. Creating the IoT hub can take several minutes.

1. Start by clicking the **Activate sandbox** button. The sandbox automatically creates an Azure resource group for you that is displayed on this web page. You create more resources for this project using the following steps. The resource group name is substituted automatically where it's used within the code steps.

1. Once the sandbox is activated, sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. On the Azure homepage, select **Create a resource**.

1. From the **Categories** menu, select **Internet of Things**, and then select **IoT Hub**.

1. In the **Basics** tab, complete the fields as follows:

   | Property | Value |
   | ----- | ----- |
   | **Subscription** | Select the sandbox **Concierge Subscription**. |
   | **Resource group** | Select the <rgn>[sandbox resource group name]</rgn> resource group. |
   | **IoT hub name** | Enter a name for your hub. This name must be globally unique, with a length between 3 and 50 alphanumeric characters. The name can also include the dash (`'-'`) character.<br><br>**Note:** IoT hubs are publicly discoverable as DNS endpoints, so avoid using any sensitive or personally identifiable information in the name. |
   | **Region** | Select the region, closest to you, where you want your hub to be located. |

1. Accept the defaults values for the rest of the fields and select **Review + create** to continue creating your hub.

1. Review the IoT hub details and make sure there are no errors to fix, then select **Create** to start the deployment of your new hub. Your deployment will be in progress a few minutes while the hub is being created.

1. Once the deployment is complete, select **Go to resource** to open the new hub.

1. In your IoT hub navigation menu, open **Devices**, then select **Add Device** to add a device in your IoT hub.

1. In **Device ID**, enter **sensor-v-3000**. Leave **Auto-generate keys** checked so that the primary and secondary keys are generated automatically. Leave **Authentication type** as **Symmetric key**. Select **Save**. This action creates a device identity in your IoT hub.

1. After the device is created, open the device from the list in the **Devices** pane. Select the **Copy to clipboard** button to copy the value of **Primary connection string**. This connection string is used by device code to communicate with the IoT hub. Copy this value into a Notepad window.

    > [!NOTE]
    > By default, the keys and connection strings are masked because they're sensitive information. If you click the eye icon, they're revealed. It's not necessary to reveal them to copy them with the copy button.

### Development resources

To simulate your IoT device, you run a C# applications on your development machine. Have the following prerequisites ready on your machine:

* [Visual Studio Code](https://code.visualstudio.com/download)
* [.NET SDK 6.0 or later](https://dotnet.microsoft.com/download)
