Azure IoT Central lets you connect IoT Edge devices to an application and manage them from your custom dashboards.

Suppose you work as an IoT solution developer for a retail company. The company plans to deploy environmental monitoring devices to its stores. You were asked to design a solution that enables central monitoring and command and control while minimizing the extra infrastructure requirements in each store. The solution must be robust if there are connectivity outages, and should minimize the amount of data sent from each store. To enable this scenario, you plan to deploy an IoT Edge device in each store to manage the local sensors and filter the data sent to Azure IoT Central.

To test the solution before deploying it to your stores, you run the IoT Edge modules on a Linux virtual machine in the cloud. When you're happy with the solution, you can install the IoT Edge modules on a device of your choice.

In this module:

- You configure an Azure IoT Central application with a device template that defines the capabilities of the IoT Edge device.
- You add some dashboards that enable an operator to view telemetry from the IoT Edge device, set properties, and control it with commands.
- You deploy an IoT Edge device to a virtual machine and connect the device to your Azure IoT Central application.
- You use an Azure function to add filtering capabilities to the IoT Edge device once the basic scenario is working.

After you complete this module, you'll be able to implement an IoT application pattern that includes edge devices to manage local devices and filter data.

[!INCLUDE [azure-optional-exercise-subscription-prerequisite](../../../includes/azure-optional-exercise-subscription-prerequisite.md)]
