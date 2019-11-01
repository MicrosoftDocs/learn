An IoT Hub will maintain, in the cloud, a _device twin_ for each device connected to it. A device twin is a JSON document containing state, configuration data, metadata, and similar information on each device. Device twins are designed for querying, and automatically synchronizing with the real IoT Hub device.

A device twin can maintain information on a device, that the device itself does not have access to. This kind of information is called **tags**. Tags might include information such as customer IDs, connectivity specifics, and location.

The device twin can also be queried, at any time, by the back-end app, to get current state information for the device. This will not involve a call to the device, as the device and twin will have synchronized on their own.

## Device twin sections

Much of the functionality of device twins is provided by Azure IoT, so not much code needs to be written to make use of them.

A device twin contains four types of information:

* Tags. Information on the device that is not visible to the device.
* Desired properties. The desired settings specified by the back-end app.
* Reported properties. The actual values of the settings on the device.
* Device identity properties. Read-only information identifying the device.

There is some overlap between the functionality of device twins, and direct methods. We could set desired properties using direct methods, which might seem an intuitive way of doing things. However, using direct methods would require the back end app to record those settings explicitly, if they ever needed to be accessed. Using device twins, this information is stored and maintained by default.

In the following unit we add code to set a few tags, and the desired temperature and humidity properties, for our cheese cave fan.