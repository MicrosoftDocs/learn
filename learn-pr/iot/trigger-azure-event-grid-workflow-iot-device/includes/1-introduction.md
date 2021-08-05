In this module, you'll learn how to integrate Azure IoT Hub with Azure Event Grid to trigger a workflow in a business scenario when a new IoT device is added to a solution.

Azure IoT Hub is a cloud service that can handle large volumes of device telemetry sent from remote devices. The remote devices typically contain a number of sensors (temperature, humidity, location, and velocity, to name a few). These sensors send out telemetry on a regular basis. An IoT hub allows ingesting data in the cloud to process it in a number of ways, including storing it or running a back-end app on it. The IoT hub also communicates new settings back to the devices. Azure IoT Hub can scale to handle millions of devices.

You can use Azure Event Grid to build applications with event-based architectures. Event Grid has built-in support for events coming from Azure services, like Azure Blob storage and Azure Event Hubs. Event Grid also has support for your own events, through custom topics.

With Azure IoT Hub and Azure Event Grid integration, you can send event notifications to other services and trigger downstream processes and workflows. Configure your business applications to listen for IoT Hub events and react to critical events in a reliable, scalable, and secure manner. For example, build an application that updates a database, creates a work ticket, and delivers an email notification every time a new IoT device is registered to your IoT hub.

[![IoT Hub integration with Event Grid and Logic Apps.](../media/iot-hub-event-grid-logic-apps.png)](../media/iot-hub-event-grid-logic-apps.png#lightbox)

## Learning objectives

In this module, you will:

* Create an IoT hub
* Create a logic app that sends an email
* Configure an Azure IoT Hub event subscription
* Create new devices that trigger a logic app, which sends an email to an operator when a new device is added to the solution

## Prerequisites

* Introductory knowledge of the purpose of Azure IoT
* Ability to navigate the Azure IoT portal
* Outlook.com email address (you can create one for this module)

## The scenario

Suppose you manage a company that offers a solution to monitor and maintain cheese caves' temperature and humidity at optimal levels. You've been working with gourmet cheese-making companies for a long time. You've established long-term trust with these customers, who value the quality of your product.

Tracking details about thermostat installation is key to ensuring security and quality for your application. Each time a new thermostat is installed, you want your records to be updated and the right people to be notified.

Your solution is built with Azure IoT Hub to securely connect and manage the thermostats. Let's see how you can use the integration of Azure IoT Hub with Azure Event Grid to automate workflows and trigger a notification when a new device is added to your solution.
