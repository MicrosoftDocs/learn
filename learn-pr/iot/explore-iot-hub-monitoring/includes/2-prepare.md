In this module, you implement monitoring to track the number of connected devices, the number of telemetry messages sent, and send connection events to a log. In addition, you create an alert that is triggered when the number of connected devices drops below one. To test the system, you connect a single device and stream telemetry, then disconnect the device to generate an alert.

In this module, you complete the following activities:

* Configure the module prerequisites (the required Azure resources).
* Create an app that simulates an IoT device sending messages to the IoT Hub.
* Run the app to generate telemetry.
* Enable diagnostic logs.
* Enable metrics.
* Set up alerts for those metrics.
* Exit the app to raise an alert.
* Observe the metrics and check the diagnostic logs.

## Setup

As part of this module, the following resources are created:

* IoT Hub
* Blob Storage
* Azure Monitor
* Device simulator program

:::image type="content" source="../media/architecture.png" alt-text="Diagram showing the module resource architecture.":::

### Cloud resources

1. Start by selecting the **Activate sandbox** button. The sandbox automatically creates an Azure resource group for you that is displayed on this web page. You create more resources for this project using the following steps. The resource group name is substituted automatically where it's used within the code steps.

1. Once the sandbox is activated, sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. On the Azure portal homepage, select **Create a resource**.

1. From the **Categories** menu, select **Internet of Things**, and then select **IoT Hub**.

1. In the **Basics** tab, complete the fields as follows:

   | Property | Value |
   | ----- | ----- |
   | **Subscription** | Select **Concierge Subscription**. |
   | **Resource group** | Select the **<rgn>[sandbox resource group name]</rgn>** resource group. |
   | **IoT hub name** | Enter a name for your hub. This name must be globally unique, with a length between 3 and 50 alphanumeric characters. The name can also include the dash (`'-'`) character.<br><br>**Note:** IoT Hubs are publicly discoverable as DNS endpoints, so avoid using any sensitive or personally identifiable information in the name. |
   | **Region** | Select the region closest to you, where you want your hub to be located. |

1. Accept the defaults values for the rest of the fields and select **Review + create** to continue creating your hub.

1. Review the IoT hub details and make sure there are no errors to fix, then select **Create** to start the deployment of your new IoT hub. Your deployment is in progress a few minutes while the hub is being created. Once the deployment is complete, select **Go to resource** to open the new IoT hub.

1. Once your IoT hub is provisioned, in your IoT Hub navigation menu, select **Devices**, then select **Add Device** to add a device in your IoT hub.

1. In **Device ID**, enter **sensor-th-2001**. Leave **Auto-generate keys** checked so that the primary and secondary keys are generated automatically. Leave Authentication type as **Symmetric key**. Select **Save**. This action creates a device identity for your IoT hub.

1. After the device is created, select **sensor-th-2001** from the list in the **Devices** pane. Select **Refresh** if necessary to refresh the device list. Select the **Copy to clipboard** button to copy the value of **Primary connection string**. This connection string is used by device code to communicate with the IoT Hub. Copy this value into a text editor such as Notepad.

    > [!NOTE]
    > By default, the keys and connection strings are masked because they're sensitive information. If you click the eye icon, they're revealed. It's not necessary to reveal them to copy them with the copy button.

### Development resources

To simulate your IoT devices provisioning through Device Provisioning Service, you run a C# application on your development machine. Have the following prerequisites ready on your development machine:

* [Visual Studio Code](https://code.visualstudio.com/download)
* [.NET SDK 6.0 or later](https://dotnet.microsoft.com/download)
