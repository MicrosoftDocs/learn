To fully test our one refrigerated truck device, it helps to break down the testing into a number of discreet checks:

* The Node.JS app connects to Azure IoT Central.
* The Node.JS app connects to Azure Maps.
* The telemetry functions send data on the specified interval, and that data is picked up correctly by IoT Central.
* The command to send the truck to a specified customer works as expected.
* The command to recall the truck works as expected.
* Change customer and conflict events are transmitted correctly.
* The truck successfully finds a route from the base to the customer, delivers the contents, and returns to base.

In addition to this list, there are edge-cases we could also investigate, such as what happens when the truck's contents start to melt. However, as we have left this up to chance in our simulation (note the use of random numbers in our code in the previous unit) we can perhaps leave this out of our first round of testing.

To begin the testing, make sure the IoT Central app is up and running, and run the Node.JS app (**Start without Debugging** from Visual Studio, or xxxx from Visual Studio Code).

### The Node.JS app connects to Azure IoT Central

### The Node.JS app connects to Azure Maps

### The telemetry functions send data on the specified interval, and that data is picked up correctly by IoT Central

### The command to send the truck to a specified customer works as expected

### The command to recall the truck works as expected

### Change customer and conflict events are transmitted correctly

### The truck successfully finds a route from the base to the customer, delivers the contents, and returns to base
