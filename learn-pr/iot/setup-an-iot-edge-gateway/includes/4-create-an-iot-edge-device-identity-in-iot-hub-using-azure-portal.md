In this module, you will create a new IoT Edge Device identity in Azure IoT Hub for the IoT Edge Transparent Gateway.

## Create an IoT Edge Device Identity in IoT Hub using Azure Portal

1. If necessary, log in to your Azure portal using your Azure account credentials.

    If you have more than one Azure account, be sure that you are logged in with the account that is tied to the subscription that you will be using for this course.

1. On your Resource group tile, click **AZ-220-HUB-_{YOUR-ID}_** to navigate to the Azure IoT Hub.

1. On the IoT Hub summary blade, click **IoT Edge** under the Automatic Device Management section. This section of the IoT Hub blade allows you to manage the IoT Edge devices connected to the IoT Hub.

1. Click the **Add an IoT Edge device** button to begin adding a new IoT Edge Device to the IoT Hub.

1. On the **Create a device** blade, enter `AZ-220-VM-EDGEGW-{YOUR-ID}` into the **Device ID** field. This is the device identity used for authentication and access control.

1. Select **Symmetric key** for the **Authentication type**, and leave the **Auto-generate keys** box checked. This will have IoT Hub automatically generate the Symmetric keys for authenticating the device.

1. Click **Save**.

1. Once the IoT Edge Device is added, click on the **Device ID** in the list of IoT Edge devices.

1. On the IoT Edge Device summary blade, copy the **Primary Connection String** and save it for later.

1. Notice the list of **Modules** configured for the IoT Edge Device contains the **$edgeAgent** and **$edgeHub** modules.

    The IoT Edge Agent (`$edgeAgent`) and IoT Edge Hub (`$edgeHub`) modules are a part of the IoT Edge Runtime. The Edge Hub is responsible for communication, and the Edge Agent deploys and monitors the modules on the device.

1. Click the **Set Modules** button at the top of the IoT Edge Device summary blade. This is used to add additional modules to the IoT Edge Device. At this time, you’ll use this to ensure the message routing is configured correctly for the IoT Edge Gateway device.

1. Leave all fields as they are in the **Modules** step, and click **Next: Routes >**.

1. Within the **Specify Routes**, the editor will display the configured default route for the IoT Edge Device. At this time, it should be configured with a route that sends all messages from all modules to Azure IoT Hub. If the route configuration doesn’t match this, then update it to match the following route:

    - Name: **route**
    - Value: `FROM /* INTO $upstream`

    The `FROM /*` part of the message route will match all device-to-cloud messages or twin change notifications from any module or leaf device. Then, the `INTO $upstream` tells the route to send those messages to the Azure IoT Hub.
 
    >[!NOTE]
    To learn more about configuring message routing within Azure IoT Edge, reference the Learn how to deploy modules and establish routes in IoT Edge documentation article.

1. Click the **Next: Review + create >** button.

1. On the **Review + create** step, click the **Create** button.

Congratulations, that's the end of the module! In the next module, we will setup an IoT Edge Gateway Hostname.