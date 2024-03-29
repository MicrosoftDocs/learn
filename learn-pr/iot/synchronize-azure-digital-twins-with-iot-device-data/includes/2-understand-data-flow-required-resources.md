In this unit, you set up the scenario and get ready to build the sample data flow.

## Understand scenario and data flow

The sample scenario for this module is a smart building, which contains many rooms equipped with smart thermostats. This module focuses on one room in the building (*Room 21*), and the thermostat in that room (*Thermostat 67*). This simplification is intended to make it easier to learn the process of connecting device data to Azure Digital Twins. In a larger building scenario, you could expand this process to populate more room and thermostat twins, using data from more real or simulated thermostats.

Here's a diagram showing the data flow through multiple Azure services that's used for this scenario.

:::image type="content" source="../media/2-3-4-building-scenario.png" alt-text="Graph showing data flowing from a device into Azure Digital Twins, then throughout Azure Digital Twins." border="true" lightbox="../media/2-3-4-building-scenario.png":::

Flow A ingests device data into Azure Digital Twins. Data flow follows this path:
1. The simulated device, *Thermostat 67*, produces temperature data.
1. The temperature data is sent to the cloud, arriving in IoT Hub.
1. IoT Hub routes the temperature data to a custom Azure function (*IoTHubToADT*).
1. The Azure function code uses the temperature data to update the *Temperature* property on the corresponding *Thermostat67* twin in Azure Digital Twins.

Next, Flow B propagates data through the digital twin graph. Data flow follows this path:
1. The *Thermostat 67* twin produces a notification that its *Temperature* property changed. Azure Digital Twins routes this notification data to Event Grid.
1. Event Grid sends the notification data to another custom Azure function (*ADTToADT*).
1. The Azure function code uses the notification data to update connected twins as appropriate. In this case, it updates the *Temperature* property on the *Room21* twin, setting the value to match the *Temperature* value on the *Thermostat67* twin that the room contains.

You set up these data flows in Units 3 and 4 of this module. But first, use the following steps to get the scenario ready by preparing an Azure Digital Twins instance and a device simulator. 

[!INCLUDE [Instructions to set up Azure Digital Twins instance](../../includes/set-up-azure-digital-twins.md)]

### Create scenario graph

Next, run the following Azure CLI commands to create the thermostat and room models, the *Thermostat67* and *Room21* twins, and a *contains* relationship from the room to the thermostat.

```azurecli
# Create models
az dt model create -n $INSTANCE_NAME --models '[{"@id":"dtmi:example:Thermostat;1","@type":"Interface","displayName":"Thermostat model","@context":"dtmi:dtdl:context;3","contents":[{"@type":"Property","name":"DisplayName","schema":"string"},{"@type":"Property","name":"FirmwareVersion","schema":"string"},{"@type":"Property","name":"Temperature","schema":"double"}]}, {"@id":"dtmi:example:Room;1","@type":"Interface","displayName":"Room model","@context":"dtmi:dtdl:context;3","contents":[{"@type":"Property","name":"DisplayName","schema":"string"},{"@type":"Property","name":"Temperature","schema":"double"},{"@type":"Relationship","name":"contains","displayName":"contains","target":"dtmi:example:Thermostat;1"}]}]'

# Create twins
az dt twin create -n $INSTANCE_NAME --dtmi "dtmi:example:Thermostat;1" --twin-id Thermostat67 --properties '{"DisplayName": "Thermostat 67","FirmwareVersion": "1.2.4","Temperature": 0.0}'
az dt twin create -n $INSTANCE_NAME --dtmi "dtmi:example:Room;1" --twin-id Room21 --properties '{"DisplayName": "Room 21","Temperature": 0.0}'

# Create relationship
az dt twin relationship create -n $INSTANCE_NAME --relationship-id room21_contains_thermostat67 --relationship contains --twin-id Room21 --target Thermostat67
```

In a real scenario with many rooms and devices, you'd continue to create more digital twins so that each entity in your environment is represented in your graph.

## Download device simulator

Get the device simulator code by navigating to the [Azure Digital Twins end-to-end sample project](/samples/azure-samples/digital-twins-samples/digital-twins-samples), and selecting the **Browse code** button underneath the title. 

This button takes you to the GitHub repo for the samples, which you can download as a .zip by selecting the **Code** button followed by **Download ZIP**.

:::image type="content" source="../media/2-download-repo-zip.png" alt-text="Screenshot of the digital-twins-samples repo on GitHub, highlighting the steps to download it as a zip." lightbox="../media/2-download-repo-zip.png":::

This downloads a .zip folder to your machine as *digital-twins-samples-main.zip*. Unzip the folder and extract the files.

The device simulator is located in the *digital-twins-samples-main/DeviceSimulator* folder. Only the contents of this folder are needed for this module; you can remove the other files and folders from your machine if you want.

Later in this module, you'll run the device simulator application to simulate data being emitted by a thermostat in the smart building scenario.