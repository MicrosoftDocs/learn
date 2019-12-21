In this unit we will use the Azure portal to create a new device management configuration and apply it to our single simulated device.

## Start de simulator

In the same terminal you setup the application for the simulated device, start the simulator typing the following command (replacing "\<device connection string\>" with the connection string you got at the end of unit 2):

``` 
dotnet run <device connection string> 
```

You should see the following output in the terminal (where "mydevice" is the device ID you used when creating the device identity):

``` 
    mydevice: Device booted
    mydevice: Current firmware version: 1.0.0
```

## Create the device management configuration

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. Go to the IoT Hub blade. You can find your IoT Hub by typing in the search bar (on top) the name you used when creating it in unit 2.
1. In the IoT Hub, find the Automatic Device Management blade and select "IoT Device COnfiguration", then select "Add Device Configuration"

    :::image type="content" source="../media/devicemanagement-1.png" alt-text="IoT Devive Configuration":::
    
1. Enter an ID for the configuration such as "firmwareupdate" then click on "Next: Twins settings >"

    :::image type="content" source="../media/devicemanagement-2.png" alt-text="Configuration ID":::
    
1. For the Device Twin Property field, enter the following:

    ```
    properties.desired.firmware
    ```
    
1. In the Device Twin Property Content field type the following then click on "Next: Metrics >"

    ``` json
    {
        "fwVersion":"1.0.1",
        "fwPackageURI":"https://MyPackage.uri",
        "fwPackageCheckValue":"1234"
    }
    ```
    
    :::image type="content" source="../media/devicemanagement-3.png" alt-text="Device Twin configuration":::
    
1. In the Metrics blade we will define the metrics the Device Management will use to monitor progress. Enter the below metrics then click on "Next: Target devices >"

    ``` SQL
    oldfirmware
        SELECT deviceId FROM devices
        WHERE properties.reported.firmware.fwUpdateStatus='current' AND properties.reported.firmware.currentFwVersion='1.0.0'

    downloading
        SELECT deviceId FROM devices
        WHERE properties.reported.firmware.fwUpdateStatus = 'downloading'
        
    verifying
        SELECT deviceId FROM devices
        WHERE properties.reported.firmware.fwUpdateStatus = 'verifying'
        
    applying
        SELECT deviceId FROM devices
        WHERE properties.reported.firmware.fwUpdateStatus = 'applying'
        
    uptodate
    SELECT deviceId FROM devices
        WHERE properties.reported.firmware.fwUpdateStatus='current' AND properties.reported.firmware.currentFwVersion='1.0.1'
    ```
    
    :::image type="content" source="../media/devicemanagement-4.png" alt-text="Metrics":::
    
1. In the "Priority" field, type "10" and in the "Target Condition" field, type in the following query, replacing "\<your device id\>" with the device Id you used to create the device in unit 2, then click on "Next: Review + Create >"

    :::image type="content" source="../media/devicemanagement-5.png" alt-text="Target Devices":::
    
1. On the next blade you should see the validation succeed for your new configuration. Click on "Create".

    :::image type="content" source="../media/devicemanagement-6.png" alt-text="Validation":::
    
