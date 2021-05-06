In this unit, we will apply what we learned in previously to configure a firmware update on several groups of devices, illustrating a real life scenario.

To create, manage and monitor Automatic Device Management configurations with Azure IoT Hub, you can use the portal like you did in previous exercises, but in order to integrate the device management operations into your IoT application and process, dealing with multiple configurations in parallel and automate part of the process, you will want to use a more programmatic method. The IoT extension for the Azure CLI allows you to easily create, update, monitor, and delete configurations as you can see in the [documentation](https://docs.microsoft.com/azure/iot-hub/iot-hub-automatic-device-management-cli).
We want to prepare a firmware update campaign to update all devices installed at 2 of our customers: Lewis and Smith. But as explained in the previous unit, we don't want to take the risk of disrupting cheese aging processes for too long and we can't afford a failure of all devices at the same time.
We will go through the following steps:

1. Create new device identities, set up their device twin tag, and start simulators
1. Create a first new Automatic Device Management configuration for the first batch of devices.
1. Monitor the deployment of the new configuration, then, when successful, create the second configuration.

## Create new device identities and run simulators using the Azure CLI

Let's start by creating a set of device identities with different sets of tags. This operation would in practice be done when new devices are deployed. Let's use the Azure CLI to rapidly add 10 new device Identities and start simulators.
We will create a script file that we will execute from the shell in order to create the device identities and starting the simulators.

1. In the Azure shell, and in the same folder you created the device simulator app, create, and open a script file called *createdevices.sh* typing the following command:


    ```azurecli
    code createdevices.sh
    ```

1. Copy and paste the following script in your script file:

    ```bash
    #!/bin/bash
    iothubname="<iot hub name>"
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        # Create a new device Id
        echo Creating device Id simulateddevice$i
        az iot hub device-identity create --hub-name $iothubname --device-id simulateddevice$i
    
        # Set tag value for customer name (alternating between 2 customers names)
        echo Adding customer tag in device twin
        if [ $i -gt 5 ]
        then
            az iot hub device-twin update --device-id simulateddevice$i --hub-name $iothubname --set tags="{\"customer\":{\"name\":\"Smith\"}}"
        else
            az iot hub device-twin update --device-id simulateddevice$i --hub-name $iothubname --set tags="{\"customer\":{\"name\":\"Lewis\"}}"
        fi
    
        # Start the device simulator
        connectionString=$(az iot hub device-identity show-connection-string --hub-name $iothubname --device-id simulateddevice$i)
        connectionString=${connectionString#*: \"}
        connectionString=${connectionString%\"*}
        echo Starting device simulator $i with connection string $connectionString
        dotnet run "$connectionString" &
    done
    ```
1. Replace "\<iot hub name\>" with your IoT Hub Name
1. Save the script file and close the editor.
1. In the terminal, run the script **createdevices.sh**:

    ```bash
    sh createdevices.sh
    ```

You should see a series of commands passing by creating the device IDs in the IoT Hub, assigning device twin tags, and starting simulators for 10 separate devices. Half of the devices are set with a tag indicating they have been installed at customer Smith, while the rest has a tag indicating they are at Lewis'.

## Create new Automatic Device Management configurations using the Azure CLI

As an administrator of the IoT solution, you could use the Azure portal to create the device management configurations (as done in previous units), but to automate things at scale it is simpler to create and use [Azure CLI scripts](https://docs.microsoft.com/azure/iot-hub/iot-hub-automatic-device-management-cli).

1. In the same folder, you created the device simulator app, create an automatic configuration content file called *firmwareupdatecontent.json*.

    ```bash
    code firmwareupdatecontent.json
    ```

1. Copy and paste the below in *firmwareupdatecontent.json*:

    ``` JSON
        {
           "content":{
                "deviceContent":{
                    "properties.desired.firmware":{
                        "fwVersion":"1.0.1",
                        "fwPackageURI":"https://MyPackage.uri",
                        "fwPackageCheckValue":"1234"
                    }
                }
            }
        }
    ```

1. Save the file and close the editor.
1. In the same folder, you created the previous file, create two other automatic configuration metrics files called *firmwareupdatemetricslewis.json*.

    ```bash
    code firmwareupdatemetricslewis.json
    ```

1. Copy and paste the below in *firmwareupdatemetricslewis.json*:

    ``` JSON
        {
            "metrics":{
                "queries":{
                    "fwupdated":"select deviceid from devices where configurations.[[firmwareupdatelewis]].status='Applied' and properties.reported.firmware.currentFwVersion='1.0.1'"
                }
            }
        }
    ```

1. Save the file and close the editor.
1. In the same folder, you created the previous file, create two other automatic configuration metrics files called *firmwareupdatemetricssmith.json*.

    ```bash
    code firmwareupdatemetricssmith.json
    ```

1. Copy and paste the below in *firmwareupdatemetricssmith.json*:

    ``` JSON
        {
            "metrics":{
                "queries":{
                    "fwupdated":"select deviceid from devices where configurations.[[firmwareupdatesmith]].status='Applied' and properties.reported.firmware.currentFwVersion='1.0.1'"
                }
            }
        }
    ```

1. Save the file and close the editor.
1. Now that we have our configuration content ready, we want to create and monitor the first configuration. Once the first one will terminate successfully, we will create and monitor the second one.

    Working in the same terminal you used to run the device simulator, run the following commands (replacing {your iot hub name} with your hub name):

    ```bash
        az iot hub configuration create --config-id "firmwareupdatelewis" \
         --content firmwareupdatecontent.json \
         --hub-name {your iot hub name}\
         --target-condition "tags.customer.name='Lewis'"\
         --priority 10 \
         --metrics firmwareupdatemetricslewis.json
    ```

    > [!NOTE]
    > Remember the trick to use a text editor to prepare the commands before pasting them in the Azure Shell terminal 

1. The firmware update campaign started and you should see the five devices installed at the Lewis' start the firmware update. We will now monitor the progress of the configuration to make sure everything went well before starting the second one. In the terminal, run the following command (replacing {your iot hub name} with your hub name):

    ```bash
        az iot hub configuration show-metric --config-id firmwareupdatelewis \
         --metric-id fwupdated --hub-name {your iot hub name} --metric-type user 
    ```

    This command will list all the devices on which the firmware update has been successfully applied. You should see 5 of them. If that's not the case, check the progress on each device simulator output and try the monitoring command again.

1. Once the first part of the firmware update campaign was successful, you can start the second one running the following command in the terminal:

    ```bash
        az iot hub configuration create --config-id "firmwareupdatesmith" \
         --content firmwareupdatecontent.json \
         --hub-name {your iot hub name}\
         --target-condition "tags.customer.name='Smith'"\
         --priority 10 \
         --metrics firmwareupdatemetricssmith.json
    ```

    And the following (eventually several times) to monitor progress.

    ```bash
        az iot hub configuration show-metric --config-id firmwareupdatesmith \
         --metric-id fwupdated --hub-name {your iot hub name} --metric-type user 
    ```

Congratulations, you successfully updated all devices' firmware at both customers' location without disrupting their production.
