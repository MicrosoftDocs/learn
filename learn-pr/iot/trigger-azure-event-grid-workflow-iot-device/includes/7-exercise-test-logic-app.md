# Create new devices

Test your logic app by creating a new device to trigger an event notification email.

1. From your IoT hub, select **IoT Devices**.

2. Select **+ New**.

3. For **Device ID**, enter `CheeseCave1_Building1_Thermostat`.

4. Select **Save**.

   Creating this device will trigger the Logic App and send and email that contains the event details.

5. To test the event subscription filters, you can add multiple devices with different device IDs. For example - try these examples:

   * CheeseCave1_Building1_Thermostat
   * CheeseCave1_Building1_Light
   * CheeseCave2_Building1_Thermostat
   * CheeseCave2_Building2_Light

   If you added the four examples, your list of IoT devices should look like the following image:

    [![IoT Hub device list](../media/iot-hub-device-list.png)](../media/iot-hub-device-list.png#lightbox)

6. Once you've added a few devices to your IoT hub, check your email to see which ones triggered the logic app. Did you receive the emails you expected?

## Next Steps

You've nearly completed this module. Just a summary and a knowledge check to go!
