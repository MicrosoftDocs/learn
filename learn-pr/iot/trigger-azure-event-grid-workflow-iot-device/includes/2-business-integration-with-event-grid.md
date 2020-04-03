Before jumping into the integration of Azure IoT Hub with Event Grid to learn how it will help triggering business workflows easily, let's first take a look at the Azure Event Grid service.

Azure Event Grid allows you to easily build applications with event-based architectures. First, select the Azure resource you would like to subscribe to, and then give the event handler or WebHook endpoint to send the event to. Event Grid has built-in support for events coming from Azure services, like storage blobs and resource groups. Event Grid also has support for your own events, using custom topics.

You can use filters to route specific events to different endpoints, multicast to multiple endpoints, and make sure your events are reliably delivered.

Azure Event Grid is deployed to maximize availability by natively spreading across multiple fault domains in every region, and across availability zones (in regions that support them). For a list of regions that are supported by Event Grid, see [Products available by region](https://azure.microsoft.com/global-infrastructure/services/?products=event-grid&regions=all).

[![Business Integration - Event Grid Functional Model](../media/business-integration-eventgrid.png) ](../media/business-integration-eventgrid.png#lightbox)

This image shows how Event Grid connects sources and handlers, and isn't a comprehensive list of supported integrations.

## How will we use Event Grid in our scenario?

When a new thermostat is installed at a customer's to monitor their cheese cave, we need to notify the operations manager that they should expect new data and events from this new device in the application.
Event Grid supports many different services as event sources, including Azure IoT Hub. From IoT Hub we will post events on Event Grid about a new devices being added to the solution.
To trigger the workflow we want, we will simply configure an event handler that will be notified by Event Grid when our IoT Hub instance posts messages about new devices.
We chose to use Azure Logic Apps as the event handler. Azure Logic Apps is a cloud service that helps you schedule, automate, and orchestrate tasks, business processes, and workflows when you need to integrate apps, data, systems, and services across enterprises or organizations. Logic Apps simplifies how you design and build scalable solutions for app integration, data integration, system integration, enterprise application integration (EAI), and business-to-business (B2B) communication, whether in the cloud, on premises, or both. One of the Logic Apps connectors allows to simply send emails to specific recipients.

[![IoT Hub Integration with Event Grid and Logic Apps](../media/iothub-eventgrid-logicapps.png)](../media/iothub-eventgrid-logicapps.png#lightbox)

## Learn more about Event Grid and Logic Apps

You can learn more about Azure Event Grid and Azure Logic Apps, visiting their respective documentations:
* [Azure Event Grid documentation](https://docs.microsoft.com/azure/event-grid/)
* [Azure Logic Apps documentation](https://docs.microsoft.com/azure/logic-apps/)

## Next Steps

In next unit, we will setup and configure these Azure resources.
