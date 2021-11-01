We're now ready to set up a downstream device that will be registered for communication with our IoT Edge Gateway.  This process is required for onboarding new sensors into the manufacturing line. 

We aren't sure the exact specs of the device at this time, but the research and development team tell us it will ensure that regulations are met during production runs.

[![Secret Sensor.](../media/kinect-preview.png)](../media/kinect-preview.png#lightbox)

In this unit, you'll create a new IoT Device identity in Azure IoT Hub for the downstream IoT device. This device identity will be configured so that the Azure IoT Edge Gateway is a parent device for this downstream device.

## Create a Downstream Device identity in IoT Hub

1. If necessary, sign in to your Azure portal using your Azure account credentials.

    If you've got more than one Azure account, ensure that you're signed in with the account for the subscription you intend to use for this course

1. On your Resource group tile, click **AZ-220-HUB-_{YOUR-ID}_** to navigate to the Azure IoT Hub.

1. On the IoT Hub summary blade, click **IoT devices** under the Explorers section. This section of the IoT Hub blade allows you to manage the IoT Devices connected to the IoT Hub.

1. Click the **New** button to begin adding a new IoT Device Identity to the IoT Hub.

1. On the **Create a device** blade, enter `DownstreamDevice1` into the **Device ID** field. This value is the device identity used for authentication and access control.

1. Select **Symmetric key** for the **Authentication type**, and leave the **Auto-generate keys** box checked. This option tells the IoT Hub to automatically generate the symmetric keys for authenticating the device.

1. Under **Parent device**, click the **Set a parent device** link to begin configuring this downstream device to communicate with IoT Hub through the IoT Edge Gateway.

1. On the **Set an Edge device as a parent device** blade, select the **AZ-220-VM-EDGEGW-_{YOUR-ID}_** Device ID in the list of IoT Edge Devices.

1. Click **OK** to select the parent device.

1. Click **Save** to create the IoT Device identity for the downstream device.

1. Once the `DownstreamDevice1` IoT Device Identity is created, click on the Device ID in the list. This option will open the details view for this device.

1. On the IoT Device summary pane, copy the **Primary Connection String** for the **DownstreamDevice1** IoT Device, and save it for reference later.

Congratulations, that's the end of the unit! In the next unit, we'll connect a downstream device to an IoT Edge Gateway.