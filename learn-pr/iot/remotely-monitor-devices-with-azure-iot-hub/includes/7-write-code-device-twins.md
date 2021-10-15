An IoT Hub will maintain a _device twin_  in the cloud for each device connected to it. A device twin is a JSON document containing state, configuration data, metadata, and similar information for each device. Device twins are designed for querying and synchronizing with the real IoT Hub device.

A device twin maintains information that the device itself does not have access to. These pieces of information are called **tags**. Tags might include information such as customer IDs, connectivity specifics, and location.

## Query device twins

The device twin can be queried at any time by the back-end app. This query will return the current state information for the device. Getting this data doesn't involve a call to the device, as the device and twin will have synchronized automatically.

Much of the functionality of device twins is provided by Azure IoT, so not much code needs to be written to make use of them.

A device twin contains four types of information:

* **Tags**: information on the device that isn't visible to the device.
* **Desired properties**: the desired settings specified by the back-end app.
* **Reported properties**: the reported values of the settings on the device.
* **Device identity properties**: read-only information identifying the device.

There's some overlap between the functionality of device twins and direct methods. We could set desired properties using direct methods, which might seem an intuitive way of doing things. However, using direct methods would require the back-end app to record those settings explicitly if they ever needed to be accessed. Using device twins, this information is stored and maintained by default.

In the following unit, we add code to set a few tags, and the desired temperature and humidity properties. Let's add fine control to the cheese cave fan!
