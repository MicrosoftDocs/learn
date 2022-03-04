It is important to understand that when data is delivered to the IoT backend, the data processing flow can be implemented in various ways. Depending on scenarios and applications, data records can flow through different stages, combined in different order, and often processed by concurrent, parallel tasks.

These stages can be classified in four categories - storage, routing, analysis, and action/display:

 -  Storage includes in-memory caches, temporary queues, and permanent archives (for example, a database).
 -  Routing allows sending data records to one or more storage endpoints, analysis processes, and actions. Routing makes decisions on what data should go which target and when.
 -  Analysis is used to run data records through a set of conditions and can produce different output data records. For instance, input telemetry data encoded in one format may return output telemetry encoded in another format.
 -  Original input data records and analysis output records are typically stored and available to display, and may trigger actions such as emails, instant messages, incident tickets, CRM tasks, device commands, etc.

These processes can be combined in simple graphs, for instance to display raw telemetry received in real time, or more complex graphs executing multiple and advanced tasks, for example updating dashboards, triggering alarms, and starting business integration processes, etc.

For example, the following graph represents a simple scenario in which devices send telemetry records that are temporarily stored in Azure IoT Hub, and then are immediately displayed on a graph on screen for visualization:

:::image type="content" source="../media/m01-l02-data-flow-1-b3c3a3af.png" alt-text="Diagram that illustrates the data workflow from device to IoT Hub to display screen visualization.":::


The following graph represents another common scenario, in which devices send telemetry, store it short term in Azure IoT Hub, analyze the data to detect anomalies, then trigger actions such as an email, SMS text, instant message, etc.:

:::image type="content" source="../media/m01-l02-data-flow-2-1385659c.png" alt-text="Diagram that shows devices send telemetry, store it short term in Azure IoT Hub, analyze the data to detect anomalies, then trigger actions.":::


IoT architectures can also support multiple systems for accepting and processing data. For instance, while some devices may connect directly to the cloud for data processing (as illustrated by the path above), other devices may store and/or analyze data on premise within field/edge gateways prior to the cloud-provided services. In another scenario, protocol translation provided by an edge gateway may be required to connect legacy or constrained devices to the cloud (protocol translation can be used to connect devices that are not IP enabled). While the resulting graph is more complex, the logical building blocks are the same:

:::image type="content" source="../media/m01-l02-data-flow-3-0a8e4444.png" alt-text="Diagram that shows a data workflow that includes non-IP enabled devices communicating data to IoT Hub using a Gateway.":::
