
Azure IoT Hub is a cloud service that can handle large volumes of telemetry sent from remote devices. The remote devices typically contain a number of sensors (temperature, humidity, location, speed, to name a few), and send out telemetry on a regular basis. An IoT Hub can process this data in a number of ways, including storing it, or running a backend app on the data, and perhaps communicating new settings back to the devices (to enable optimal operation).

In this module, you will learn about IoT Hub by implementing a system to monitor and control sensors in a wine cellar.

## Learning objectives

In this module you will:
  - Create an Azure IoT Hub custom app, using the IoT Hub portal
  - Create a Node.js app to send device telemetry to the custom IoT Hub
  - Create a second Node.js app to handle the backend service, and control the device through direct methods
  - Understand the role of Device Twins, in maintaining remote device properties
  - Understand the role of Direct Methods, in communicating remote device settings

## The scenario

Suppose you run a restaurant that is very proud of its wine cellar, and is very careful to maintain the perfect temperature and humidity of the cellar. There are sensors in the cellar that report on the temperature and humidity, and a remote operator that can set a cooling fan, and a humidifier, to new settings if needed to maintain the perfect environment for storing wine.

