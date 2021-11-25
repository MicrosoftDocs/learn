When planning for an IoT solution, perhaps the first area of consideration is what hardware you will need (or already have). This issue is partly driven by the fact that data is the main driver behind implementing many IoT solutions, so figuring out what data you want to collect and how you want to collect it has a primary place in your architecture.

Although the hardware implemented in an IoT solution includes the network infrastructure devices used to provide, secure Internet communications, here we will focus on IoT device hardware.

## IP-enabled IoT devices

An IP-enabled device is, simply, a device that can establish a connection to a network (for many IoT devices, this network connection means the Internet) and have a unique identity on that network. "IP" stands for "Internet protocol" and defines the way messages are delivered over a network. A message in networking terms is just a packet of information and single packet could deliver part of a text message or a video file. Most data that is transferred over the Internet uses this communication protocol.

In terms of an IoT solution, an IP-enabled device is one that can connect directly to a network like the Internet, and use that connection to communicate with an IoT hub. Consumer device examples include home automation devices like doorbells and thermostats that use an Internet connection to communicate with a central server. But industrial-grade IoT devices can be IP-enabled as well. IP-enabled devices use specialized hardware to enable this functionality.

As you might expect, people deploy IP-enabled devices in scenarios where data needs to be collected, delivered, and analyzed in real-time, near real-time, or periodically.

## Non-IP enabled devices

A device does not need to be directly IP-enabled in order to be a part of an IoT solution. Some devices don't use IP to connect to other parts of an IoT solution but can use other protocols. These devices don't connect to the Internet by themselves, but their messages are routed to the Internet via other hardware like a field gateway (IoT Edge Device) which is described below. Non-IP-enabled devices can use industry-specific protocols (such as CoAP5, OPC), and short-range communication technologies (such as Bluetooth, ZigBee, etc.) to connect to other hardware.

For example, a home security system that includes window sensors and a controllable door lock, may provide local communication between sensors within the home and use a centralized field gateway device (that is IP-enabled and connected to the Internet) in order to communicate with a cloud service. A home owner can then use their smart phone to check the status of the windows and control the door lock.

Devices of this type can be useful in scenarios where data from two or more devices needs to be aggregated, cleaned-up, and possibly even analyzed before being sent to a cloud service. Since IP-enabled devices typically take more resources, low-powered or resource- (or space-) constrained devices can use protocols with lower resource consumption requirements that transmit to a device that doesn't have these constraints.

## Sensors

A sensor is a circuit (or device) that collects a specific type of data about the physical environment. As IoT continues to evolve, the list of available sensors continues to grow, often in ways that we would not have imagined five years earlier.

A **smart sensor** according to [the website](https://internetofthingsagenda.techtarget.com/definition/smart-sensor) *IoT Agenda* is "a device that takes input from the physical environment and uses built-in compute resources to perform predefined functions upon detection of specific input and then process data before passing it on." That is, the device itself processes the data to some degree before sending it to the next node in the IoT architecture.

Sensors can either be directly embedded within an IoT device, or implemented as an external piece of hardware that connects to the IoT device through a defined interface. Examples of simple sensor measurements include: Temperature, Humidity, Distance, and Light.

## IoT Edge devices and field gateways

In general terms, a field gateway is a specialized device-appliance or general-purpose software that acts as a communication enabler and, potentially, as a local device control system and device data processing hub. A field gateway can perform local processing and control functions that are directed back toward the child devices that are connected to it. For cloud-facing services, a field gateway can be used to filter or aggregate device telemetry and thus reduce the amount and/or frequency of data being transferred to the cloud backend.

A field gateway’s scope includes the field gateway itself and all devices that are attached to it. As the name implies, field gateways act outside dedicated data processing facilities and are often located near the devices.

A field gateway is different from a mere traffic router in that it has an active role in managing access and information flow. It is an application-addressed entity and network connection or session terminal. For example, gateways in this context may help with device provisioning, data filtering, batching and aggregation, buffering of data, protocol translation, and event rules processing. NAT devices or firewalls, in contrast, do not qualify as field gateways since they are not explicit connection or session terminals, but rather route (or deny) connections or sessions made through them.

## Other hardware

General networking hardware and specialized protocol gateway devices can also play a significant role in the device-side infrastructure.
