IoT Hub is a managed service, hosted in the cloud, that acts as a central message hub for bi-directional communication between your IoT application and the devices it manages. You can use Azure IoT Hub to build IoT solutions with reliable and secure communications between millions of IoT devices and a cloud-hosted solution backend. You can connect virtually any device to IoT Hub.

IoT Hub supports communications both from the device to the cloud and from the cloud to the device. IoT Hub supports multiple messaging patterns such as device-to-cloud telemetry, file upload from devices, and request-reply methods to control your devices from the cloud. IoT Hub monitoring helps you maintain the health of your solution by tracking events such as device creation, device failures, and device connections.

IoT Hub's capabilities help you build scalable, full-featured IoT solutions such as managing industrial equipment used in manufacturing, tracking valuable assets in healthcare, and monitoring office building usage.

## Secure your communications

IoT Hub gives you a secure communication channel for your devices to send data.

 -  Per-device authentication enables each device to connect securely to IoT Hub and for each device to be managed securely.
 -  You have complete control over device access and can control connections at the per-device level.
 -  The IoT Hub Device Provisioning Service automatically provisions devices to the correct IoT hub when the device first boots up.
 -  Multiple authentication types support different device capabilities:
     -  SAS token-based authentication to quickly get started with your IoT solution.
     -  X.509 CA authentication for simple, standards-based enrollment.

## Scale your solution

IoT Hub scales to millions of simultaneously connected devices and millions of events per second to support your IoT workloads.

## Route device data

Built-in message routing functionality gives you the flexibility to set up automatic, rules-based message fan-out:

 -  Use message routing to control where your hub sends device telemetry.
 -  There is no extra cost to route messages to multiple endpoints.
 -  No-code routing rules take the place of custom message dispatcher code.

## Integrate with other services

You can integrate IoT Hub with other Azure services to build complete, end-to-end solutions. For example, use:

 -  Azure Event Grid to enable your business to react quickly to critical events in a reliable, scalable, and secure manner.
 -  Azure Logic Apps to automate business processes.
 -  Azure Machine Learning to add machine learning and AI models to your solution.
 -  Azure Stream Analytics to run real-time analytic computations on the data streaming from your devices.

## Configure and control your devices

You can manage your devices connected to IoT Hub with an array of built-in functionality.

 -  Store, synchronize, and query device metadata and state information for all your devices.
 -  Set device state either per-device or based on common characteristics of devices.
 -  Automatically respond to a device-reported state change with message routing integration.

## Connect your devices

Use the Azure IoT device SDK libraries to build applications that run on your devices and interact with IoT Hub. Supported platforms include multiple Linux distributions, Windows, and real-time operating systems. Supported languages include C, C\#, Java, Python, and Node.js. IoT Hub and the device SDKs support a wide range of protocols for connecting devices, including HTTPS, AMQP, AMQP over WebSockets, MQTT, and MQTT over WebSockets.

## Quotas and limits

Each Azure subscription has default quota limits in place to prevent service abuse, and these limits could impact the scope of your IoT solution. The current limit on a per-subscription basis is 50 IoT hubs per subscription. You can request quota increases by contacting support.
