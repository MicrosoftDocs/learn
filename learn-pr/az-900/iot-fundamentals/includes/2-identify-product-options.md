The Internet of Things (IoT) is the ability for devices to gather and then relay information for data analysis.  Smart devices are equipped with sensors that collect data.  A few common sensors that measure attributes of the physical world include:

- Environmental sensors that capture temperature and humidity levels
- Barcode, QR code, or OCR scanners
- Geo-location and proximity sensors
- Light, color, and infrared sensors
- Sound and ultrasonic sensors
- Motion and touch sensors
- Accelerometer and tilt sensors
- Smoke, gas, and alcohol sensors
- Error sensors to detect when there's a problem with the device
- Mechanical sensors that detect anomalies or deformations
- Flow, level, and pressure sensors for measuring gasses and liquids

Using Azure IoT services, devices that are equipped with these kinds of sensors and that can connect to the internet could send their sensor readings to a specific endpoint in Azure via a message, where the message's data is collected, aggregated, and can be converted into reports and alerts.  Or, all devices could be updated with new firmware to fix issues or add new functionality by sending software updates from Azure's IoT services to each device.

Let's suppose your company manufactures and operates smart refrigerated vending machines.  What kinds of information would you want to monitor?  You may want to ensure that each machine is operating without any errors, make sure the machine has not been compromised, you may want to make sure that its refrigeration system is keeping the contents within a certain temperature range, and you want to be notified when products reach a certain inventory level so you can restock the machine.  Assuming the hardware of your vending machine can collect and send this information in a standard message, the messages each machine sends can be received, stored, organized and displayed using Azure's IoT services.

The data collected from these devices could be combined with Azure's AI services to predict when machines need pro-active maintenance, or predict when inventories will need to be replenished and new product ordered from vendors.

There are many services that can assist and drive end-to-end solutions for IoT on Azure.

## Azure IoT Hub

Think: "Message receiver, an end point for device messages".

Azure IoT Hub is a managed service hosted in the cloud that acts as a central message hub for bi-directional communication between your IoT application and the devices it manages. You can use Azure IoT Hub to build IoT solutions with reliable and secure communications between millions of IoT devices and a cloud-hosted solution backend. You can connect virtually any device to your IoT Hub.

IoT Hub supports communications both from the device to the cloud and from the cloud to the device. It also supports multiple messaging patterns such as device-to-cloud telemetry, file upload from devices, and request-reply methods to control your devices from the cloud. IoT Hub monitoring helps you maintain the health of your solution by tracking events such as device creation, device failures, and device connections.

The IoT Hub is a platform as a service (PaaS) that you build your company's solutions on top of by writing custom code and calling methods on IoT Hub's API.

## Azure IoT Central

Think: "Pre-built GUI portal to monitor device health and control devices remotely."

Azure IoT Central builds on top of IoT Hub by adding a dashboard that allows you to connect, monitor, and manage your IoT devices.  The visual UI makes it easy to quickly connect new devices and watch as they begin sending telemetry or error messages.  You can watch the overall performance across all devices in aggregate, and set up alerts that send notifications when a specific device needs maintenance.  Finally, you can push hardware updates to the device.

To help you get up and running quickly, IoT Central provides starter templates for common scenarios across different industries, like retail, energy, healthcare, and government. You then customize the starter templates using a programmatic SDK via Node, Python, C#, or other popular programming languages.  IoT Central allows you to tailor the starter templates for the specific data that's sent from your devices, the reports you want to see, and the alerts you want to send.

Finally, you can use the UI to control your devices remotely.  This feature allows you to push a software update or modify a property of the device.  You could update the desired temperature for one or all of your refrigerated vending machines from directly inside of IoT Central.

## Azure Sphere

Think: "secure end-to-end platform".

Azure Sphere creates an end-to-end highly secure IoT solution for customers that encompasses everything from the hardware and operating system on the device, to the secure method of sending messages from the device to the message hub.  It has built-in communication and security features for internet-connected devices.

There are three parts to Azure Sphere:

- The first part is the Azure Sphere MCU (micro-controller unit) which is responsible for processing the operating system and signals from attached sensors.

- The second part is a customized Linux operating system (OS) that handles communication with the security service and can run the vendor's software.

- The third part is the Azure Sphere Security Service, also known as AS3.  Its job is to make sure the device has not been maliciously compromised. When the device attempts to connect to Azure, it first must authenticate itself (per-device) which it does using certificate-based authentication. If it authenticates successfully, AS3 checks to ensure that the device has not been tampered with. Once it has established a secure channel of communication, it will push any OS or (approved) customer developed software updates to the device.

Once the Azure Sphere system has validated the authenticity of the device and authenticated it, the device can then interact with other Azure IoT services, sending telemetry and error information.