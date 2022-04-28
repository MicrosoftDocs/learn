An Azure Digital Twins solution relies on external resources for data inputs and downstream services for analysis, storage, etc. Therefore, understanding how to implement support for upstream and downstream resources is important.

## Data ingress (upstream resources)

Data can be ingested into Azure Digital Twins through external compute resources such as an Azure Function.

### Ingress scenario

IoT Hub is a common source for data input to Azure Digital Twins.

Consider a scenario that includes the following items:

 -  A thermostat device in IoT Hub, with a known device ID
 -  A digital twin to represent the device, with a matching ID
 -  When IoT hub receives telemetry containing temperature values from the device, you need to set a temperature Property of the corresponding digital twin.

> [!NOTE]
> This example uses a straightforward ID match between the device ID and a corresponding digital twin's ID, but it is possible to provide more sophisticated mappings from the device to its twin (such as with a mapping table).

:::image type="content" source="../media/m11-l03-adt-telemetry-ingestion-iot-hub-64bbcc4b.png" alt-text="Diagram that shows using IoT Hub as a source for data input to an Azure Digital Twins environment.":::


In this case, an Azure Function receives the data from IoT hub's built-in Event Grid endpoint and uses the Azure Digital Twins APIs to set properties on a digital twin contained within an Azure Digital Twins instance. The Azure Function could also pass temperature telemetry to a Telemetry field of the digital twin.

## Data egress

To provide data to downstream resources, Azure Digital Twins uses digital twin change notification events as a trigger to route data to an Azure Digital Twins endpoint where the information can be accessed and used to accomplish a desired action.

### Egress scenario (in-service updates)

Although Azure Digital Twins relationships connect digital twins as parent and child, properties of a child are not automatically passed up to a parent in the case when a corresponding property is defined.

Consider a scenario that includes the following items:

 -  An Azure Digital Twins environment contains Room digital twins (such as Room\_01, Room\_02, etc.) and Thermostat digital twins (such as thermo\_0001).
 -  The Room digital twins have a rel\_has\_thermostat relationship and each Room has a Thermostat (establishing a Parent-Child relationship).
 -  The Thermostat digital twins have Property and Telemetry fields for temperature data that is coming from IoT hub.
 -  Room digital twins have a Property for currentTemp.
 -  When a Thermostat digital twin Property changes, you need to update the currentTemp Property of the Room digital twin (the Room digital twin that is the parent of that Thermostat digital twin).

:::image type="content" source="../media/m11-l03-adt-service-update-process-d64af8fb.png" alt-text="Diagram that shows using Event Grid and an Azure Function to update properties of an Azure Digital Twins environment.":::


Whenever a Digital Twin Change Notification event occurs for a Thermostat digital twin, the following process is invoked:

 -  Data is routed to an Event Grid endpoint.
 -  The Event Grid uses an Event Subscription to specify an Azure Function "listener“, creates a new event message using the Azure Digital Twins notification, and uses the new event to pass the required information to the function.
 -  The Azure Function extracts the event massage data and uses it to obtain the twin’s ID and Relationship information, uses the Relationship to find the parent Room digital twin, and then updates the currentTemp Property by applying a patch.

### Egress scenario (downstream services)

Azure Digital Twins feeds data to downstream services by using event notifications and routing.

Consider a scenario that includes the following items:

 -  An Azure Digital Twins environment contains Room digital twins (such as Room\_01, Room\_02, etc.) and Thermostat digital twins (such as thermo\_0001).
 -  The Room digital twins have a rel\_has\_thermostat relationship and each Room has a Thermostat.
 -  Room digital twins also have a Property for currentTemp.
 -  The Thermostat digital twins have Property and Telemetry fields for temperature data coming from IoT hub.
 -  You need to analyze the temperature Telemetry data using Azure Time Series Insights.

:::image type="content" source="../media/m11-l03-adt-downstream-tsi-3f1a5ca4.png" alt-text="Diagram that shows using an Event Hubs namespace and an Azure Function to send Azure Digital Twins data to Time Series Insights.":::


Whenever a Digital Twin Telemetry Messages event notification occurs for a Thermostat digital twin, the following process is invoked:

1.  Data is routed to an Event Hubs endpoint.
2.  The Event Hubs processes events and triggers an Azure Function.
3.  The Azure Function creates a new event for TSI, adds a partition key, and then publishes the new event to another Event Hubs.
4.  Azure TSI (subscribed to events from the second Event Hubs) processes the incoming events to perform the required data analysis.
