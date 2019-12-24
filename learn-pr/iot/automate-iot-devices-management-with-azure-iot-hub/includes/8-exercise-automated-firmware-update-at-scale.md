In this unit we will apply what we learned in the previous units to configure a firmware update on several groups of devices, illustrating a real life scenario. While we used the Azure Portal to setup a simple firmware update configuration for a single device, will use the Azure CLI for this unit in order to learn another method to work with Azure IoT Automatic Device Management.

## Prepare new configurations using the Azure CLI

Working in the same terminal you used to run the device simulator,
<TODO>


## Create new device identities and run simulators using the Azure CLI

Let's start by creating a set of device identities with different sets of tags. This operation would in practice be done when new devices are deployed. Let's use the Azure CLI to rapidly add 10 new device Identities and start simulators.
We will create a script file that we will execute from the shell in order to create the device identities and starting the simulators.

1. In the same folder you created the device simulator app, create a script file called *createdevices.bat*.

1. Copy and paste the following script in your script file:

    ``` CMD
    @echo off
    set iothubname="\<iot hub name\>"
    for /L %%G in (1, 1, 10) do (    
        REM create new device ID
        echo.Creating device ID simulateddevice%%G
        az iot hub device-identity create --hub-name %iothubname% --device-id simulateddevice%%G
    
        REM Set tag value for customer name (alternating between 2 customers names)
        echo.Adding customer tag in device twin
        if %%G gtr 5 (
            az iot hub device-twin update --device-id simulateddevice%%G --hub-name %iothubname% --set tags="{\"customer\":{\"name\":\"Smith\"}}"
        ) else (
            az iot hub device-twin update --device-id simulateddevice%%G --hub-name %iothubname% --set tags="{\"customer\":{\"name\":\"Lewis\"}}"
        )
    
        REM Start the device simulator
        echo.Starting device simulator
        for /F tokens^=4^ delims^=^" %%a in ('az iot hub device-identity show-connection-string --hub-name %iothubname% --device-id simulateddevice%%G') do start dotnet run %%a
    )
    ```
1. Replace "\<iot hub name\>" with your IoT Hub Name
1. Save the script file
1. In the terminal, run the script **createdevices.bat**

You should see a series of commands passing by creating the device IDs in the IoT Hub, assigning device twin tags and starting simulators for 10 separate devices. Half of the devices are set with a tag indicating they have been installed at customer Smith, while the rest has a tag indicating they are at Lewis'.

