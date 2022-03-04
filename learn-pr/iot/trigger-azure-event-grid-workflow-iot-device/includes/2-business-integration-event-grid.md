Let's take a look at the Azure Event Grid service before we jump into its integration with Azure IoT Hub.

You can use Azure Event Grid to build applications with event-based architectures. Event Grid has built-in support for events that come from Azure services, like storage blobs and resource groups. Event Grid also has support for your own events, through custom topics.

You can use filters to route specific events to different endpoints, multicast to multiple endpoints, and make sure your events are reliably delivered.

Azure Event Grid is deployed to maximize availability. It natively spreads across multiple fault domains in every region, and across availability zones (in regions that support them). For a list of regions that Event Grid supports, see [Products available by region](https://azure.microsoft.com/global-infrastructure/services/?products=event-grid&regions=all).

[![Business integration - Event Grid functional model.](../media/business-integration-event-grid.png) ](../media/business-integration-event-grid.png#lightbox)

This image shows how Event Grid connects sources and handlers. It isn't a comprehensive list of supported integrations.

## Using Event Grid in our scenario

When a new thermostat is installed to monitor a customer's cheese cave, we want to notify the operations manager that they should expect new data and events in the application.

Event Grid supports many different services as event sources, including Azure IoT Hub. From IoT Hub, we'll post events on Event Grid about the addition of a new device to the solution.

To trigger the workflow we want, we'll configure an event handler that Event Grid will notify when our IoT Hub instance posts messages about new devices.

We chose to use Azure Logic Apps as the event handler. Logic Apps is a cloud service that helps you schedule, automate, and orchestrate tasks, business processes, and workflows when you need to integrate apps, data, systems, and services across enterprises or organizations. 

Logic Apps simplifies how you design and build scalable solutions for app integration, data integration, system integration, enterprise application integration (EAI), and business-to-business (B2B) communication. These solutions can be in the cloud, on premises, or both. One of the Logic Apps connectors sends emails to specific recipients.

[![IoT Hub integration with Event Grid and Logic Apps.](../media/iot-hub-event-grid-logic-apps.png)](../media/iot-hub-event-grid-logic-apps.png#lightbox)

## More information about services

You can learn more about Event Grid and Logic Apps:

* [Azure Event Grid documentation](/azure/event-grid/)
* [Azure Logic Apps documentation](/azure/logic-apps/)

## Next steps

In the next units, we'll create and configure these Azure resources.