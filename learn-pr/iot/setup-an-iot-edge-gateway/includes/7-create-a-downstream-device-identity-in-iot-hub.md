In this module, you will create a new IoT Device identity in Azure IoT Hub for the downstream IoT device. This device identity will be configured so that the Azure IoT Edge Gateway is a parent device for this downstream device.

## Create a Downstream Device Identity in IoT Hub

1. If necessary, log in to your Azure portal using your Azure account credentials.

    If you have more than one Azure account, ensure that you are logged in with the account that is tied to the subscription that intend to use for this course.

1. On your Resource group tile, click **AZ-220-HUB-_{YOUR-ID}_** to navigate to the Azure IoT Hub.

1. On the IoT Hub summary blade, click **IoT devices** under the Explorers section. This section of the IoT Hub blade allows you to manage the IoT Devices connected to the IoT Hub.

1. Click the **New** button to begin adding a new IoT Device Identity to the IoT Hub.

1. On the **Create a device** blade, enter `DownstreamDevice1` into the **Device ID** field. This is the device identity used for authentication and access control.

1. Select **Symmetric key** for the **Authentication type**, and leave the **Auto-generate keys** box checked. This will have IoT Hub automatically generate the Symmetric keys for authenticating the device.

1. Under **Parent device** click the **Set a parent device** link to begin configuring this downstream device to communicate with IoT Hub through the IoT Edge Gateway.

1. On the **Set an Edge device as a parent device** blade, select the **AZ-220-VM-EDGEGW-_{YOUR-ID}_** Device ID in the list of IoT Edge Devices.

1. Click **OK** to select the parent device.

1. Click **Save** to create the IoT Device identity for the downstream device.

1. Once the `DownstreamDevice1` IoT Device Identity is created, click on the Device ID in the list. This will open the details view for this device.

1. On the IoT Device summary pane, copy the **Primary Connection String** for the **DownstreamDevice1** IoT Device, and save it for reference later.

Congratulations, that's the end of the module! In the next module, we will connect a downstream device to an IoT Edge Gateway.