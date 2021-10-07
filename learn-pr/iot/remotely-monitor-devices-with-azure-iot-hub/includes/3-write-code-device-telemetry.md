Telemetry is the output from sensors. Common types of sensors used in commercial applications include:

- Acceleration
- Humidity
- Location
- Pressure
- Temperature
- Velocity

Other sensors include radiation, motion-sensitivity, acoustics, air quality, heart rate, and more. They all pump out telemetry for some other process to consume.

The frequency of telemetry output is an important factor. A temperature sensor in a refrigeration unit may only have to report every minute, or less. An acceleration sensor on an aircraft may have to report at least every second.

An IoT device may contain one or more sensors and have some computational power. There may be LED lights--and even a small screen--on the IoT device. However, the device isn't intended for direct use by a human operator. An IoT device is designed to receive its instructions from the cloud.

## Control a cheese cave device

In this module, we assume the IoT cheese cave monitoring device has temperature and humidity sensors. The device has a fan capable of both cooling or heating, as well as humidifying or de-humidifying. Every few seconds, the device sends current temperature and humidity values to the IoT Hub. This rapid frequency is unrealistic for a cheese cave. Once per every 15 minutes, or less, would be granular enough for production. During development, though, we want rapid activity!

We assume in the next unit that the fan can be in one of three states: _on_, _off_, and _failed_. The fan is initialized to the off state. In a later unit, the fan is turned on by use of a _direct method_.

Another feature of our IoT device is that it can accept _desired_ values from the IoT Hub. The device can then adjust its fan to target these desired values. These values are coded in this module using a feature called _device twins_. Desired values will override any default settings for the device.

## Coding the sample

The coding in this module is broken down into three parts: sending and receiving telemetry, sending and receiving a direct method, and managing device twins.

Let's start by writing two apps: one for the device to send telemetry, and one back-end service to run in the cloud, to receive the telemetry. You'll be able to select your preferred language (Node.js or C#), and development environment (Visual Studio Code, or Visual Studio).
