Telemetry is the output from sensors. There are many different types of sensors, though acceleration, humidity, location, pressure, temperature, and velocity are the most common.

The frequency of telemetry output is an important factor. A temperature sensor in a refrigeration unit may only have to report every minute, or less. An acceleration sensor on an aircraft may have to report every second.

An IoT device may contain one or more sensors, and have some computational power. There may be LED lights, and even a small screen, on the IoT device. However, the device is not intended for direct use by human operators. An IoT device is designed to receive its instructions from the cloud.

## Cheese cave device

In this module, we assume the IoT cheese cave monitoring device has temperature and humidity sensors. The device has a fan capable of both cooling or heating, and humidifying or de-humidifying. Every few seconds, the device sends current temperature and humidity values to the IoT Hub. This rapid frequency is unrealistic for a cheese cave (maybe every 15 minutes, or less, would be granular enough), except during code development when we want rapid activity!

We assume, in the next unit, that the fan can be in one of three states: on, off, and failed. The fan is initialized to the _off_ state. In a later unit, the fan is turned on by use of a _direct method_.

Another feature of our IoT device is that it can accept _desired_ values from the IoT Hub. The device can then adjust its fan to target these desired values. These values are coded in this module using a feature called _device twins_. Desired values will override any default settings for the device.

## Coding the sample

The coding in this module is broken down into three parts: sending and receiving telemetry, sending and receiving a direct method, and managing digital twins.

Let's start by writing two apps: one for the device to send telemetry, and one back-end service to run in the cloud, to receive the telemetry. You will be able to select the language you wish to prepare the code in (Node.js or C#), and the development environment (Visual Studio Code, or Visual Studio).