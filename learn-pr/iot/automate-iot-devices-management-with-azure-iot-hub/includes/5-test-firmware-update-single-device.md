In this unit, we will use the Azure portal to create a new device management configuration and apply it to our single simulated device.

## Start the simulator

In the Azure Shell, from the same folder you created the device simulator project, start the simulator typing the following command (replacing **\<device connection string\>** with the connection string you got at the end of unit 2):
> [!NOTE]
> In the instructions following and next units of this module you will have to enter long and customized commands. We recommend that you use a text editor to prepare your commands, replacing the place holders with your own names and keys then copy paste from there to the Azure Shell terminal.


```bash
dotnet run "<device connection string>"
```

You should see the following output in the terminal (where "mydevice" is the device ID you used when creating the device identity):

```bash
mydevice: Device booted
mydevice: Current firmware version: 1.0.0
```

## Create the device management configuration

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. Go to the IoT Hub page. You can find your IoT Hub by typing in the search bar (on top) the name you used when creating it in unit 2.
1. In the IoT Hub, find the "Automatic Device Management" page and select "IoT Device Configuration", then select "Add Device Configuration"
    
    [ ![IoT Device Configuration.](../media/device-management-1.png) ](../media/device-management-1.png#lightbox)
    
1. Enter an ID for the configuration such as "firmwareupdate" then click on "Next: Twins settings >"

    [ ![Configuration ID.](../media/device-management-2.png) ](../media/device-management-2.png#lightbox)
    
1. For the "Device Twin Property" field, enter the below. To define a desired property, you need to prefix the value in the field with "properties.desired". You can also add several desired properties but in our case we will only add one.

    ```json
    properties.desired.firmware
    ```
        
1. In the "Device Twin Property Content" field, type the following then click on "Next: Metrics >"

    ```json
    {
        "fwVersion":"1.0.1",
        "fwPackageURI":"https://MyPackage.uri",
        "fwPackageCheckValue":"1234"
    }
    ```

    [ ![Device Twin configuration.](../media/device-management-3.png) ](../media/device-management-3.png#lightbox)

1. In the "Metrics" section, we will define a custom metric to track the firmware update was effective. Create a new custom metric called "fwupdated" and type in the below criteria, then click on "Next: Target devices >"

    ```SQL
        SELECT deviceId FROM devices
           WHERE properties.reported.firmware.currentFwVersion='1.0.1'
    ```

    [ ![Metrics.](../media/device-management-4.png) ](../media/device-management-4.png#lightbox)

1. In the "Priority" field, type "10", and in the "Target Condition" field, type in the below query, replacing "\<your device id\>" with the device ID you used to create the device in unit 2, then click on "Next: Review + Create >". (Valid conditions specify either a deviceId (for example, deviceId='{id}'), one or more device twin tag criteria (for example, tags.environment = 'prod' AND tags.location = 'westus'), or reported property criteria)

    ```SQL
        deviceId='<your device id>'
    ```

    [ ![Target Devices.](../media/device-management-5.png) ](../media/device-management-5.png#lightbox)

1. On the next page, you should see the validation succeed for your new configuration. Click on "Create".

    [ ![Validation.](../media/device-management-6.png) ](../media/device-management-6.png#lightbox)

1. Once the configuration has been created, you will see it in the automatic device management page:

    [ ![New Configuration added.](../media/device-management-7.png) ](../media/device-management-7.png#lightbox)

## See the magic happen

IoT Hub will now look for devices matching the configuration's target devices criteria, and will apply the firmware update configuration automatically.
In the terminal, you started the device on, you should see the bellow traces indicating the progress of the firmware update process on the device itself:

[ ![Simulated Device executing FW update.](../media/simulated-device-1.png) ](../media/simulated-device-1.png#lightbox)

And on the "Device Management Configuration" you should see:

[ ![Configuration applied and successful.](../media/device-management-8.png) ](../media/device-management-8.png#lightbox)

You have validated that the firmware update process on your simulated device works. You can stop the device simulator by typing "q" and pressing the "Enter" key in the terminal.
