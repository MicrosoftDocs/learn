In this module, you'll learn how to integrate Azure IoT Hub with Azure Event Grid to trigger a workflow in a business scenario when a new IoT device is added to a solution.

Azure IoT Hub is a cloud service that can handle large volumes of telemetry sent from remote devices. The remote devices typically contain a number of sensors (temperature, humidity, location, velocity, to name a few). These sensors send out telemetry on a regular basis. An IoT Hub allows ingesting data in the cloud to process it in a number of ways, including storing it, or running a back-end app on the data. The IoT Hub also communicates new settings back to the devices. Azure IoT Hub can scale to handle millions of devices.

Azure Event Grid allows you to easily build applications with event-based architectures. First, select the Azure resource you would like to subscribe to, and then give the event handler or WebHook endpoint to send the event to. Event Grid has built-in support for events coming from Azure services, like Azure Storage Blobs and Event Hub. Event Grid also has support for your own events, using custom topics.

Azure IoT Hub integrates with Azure Event Grid so that you can send event notifications to other services and trigger downstream processes and workflows. Configure your business applications to listen for IoT Hub events so that you can react to critical events in a reliable, scalable, and secure manner. For example, build an application that updates a database, creates a work ticket, and delivers an email notification every time a new IoT device is registered to your IoT hub.

## Learning Objectives

In this module you will:

* Create an IoT Hub
* Create a Logic App that sends an email
* Configure Azure IoT Hub Event Subscription
* Create new devices triggering a Logic App which sends an email when alert is flagged by device

## Prerequisites

* An introductory knowledge of the purpose of Azure IoT
* Ability to navigate Azure IoT portal
* An outlook.com email address

## The Scenario

Suppose you manage a company that offers a solution to maintain and monitor cheese caves' temperature and humidity at optimal levels. You have been working with gourmet cheese making companies for a long time and established long-term trust with these customers who value the quality of your product.

Tracking details about thermostats installation is key to ensuring security and quality for your application. Each time a new thermostat is setup by an installer, you want your records to be updated, as well as the right people to be notified.

Your solution is built with Azure IoT Hub to securely connect and manage the thermostats.
Let's see how you can leverage the integration of Azure IoT Hub with Azure Event Grid to automate workflows and trigger a notification when a new device is added to your solution.
