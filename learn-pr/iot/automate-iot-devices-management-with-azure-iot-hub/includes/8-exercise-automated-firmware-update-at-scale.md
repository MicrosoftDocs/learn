In this unit we will apply what we learned in the previous units to configure a firmware update on several groups of devices, illustrating a real life scenario.
To create, manage and monitor Automatic Device Management configurations with Azure IoT Hub, you can use the portal like you did in previous exercises, but in order to integrate the device management operations into your IoT application, dealing with multiple configurations in parallel and automate part of the process, you will want to use a more programmatic method. The IoT extension for the Azure CLI allows you to easily create, update, monitor and delete configurations as you can see in the [documentation](https://docs.microsoft.com/azure/iot-hub/iot-hub-automatic-device-management-cli).
We want to prepare a firmware update campaign to update all devices installed at 2 of our customers: Lewis and Smith. But as explained in the previous unit, we don't want to not take the risk of disrupting cheesse aging processes for too long and we can't afford a failure of all devices at the same time.
We will go through the following steps:

1. Create new device identities, setup their device twin tag and start simulators
1. Create a first new Automatic Device Management configuration for the first batch of devices.
1. Monitor the deployment of the new configuration, then, when successful, create the second configuration.

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

## Create new Automatic Device Management configurations using the Azure CLI

Let's go through the following 
Working in the same terminal you used to run the device simulator,
<TODO>

