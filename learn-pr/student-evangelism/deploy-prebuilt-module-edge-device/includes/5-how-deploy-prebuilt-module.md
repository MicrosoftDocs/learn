To deploy a prebuilt module to an edge device:

* Choose an IoT Edge module from a container registry
* Select the IoT Edge device to receive the module

In this scenario, use a module that simulates temperature data.

* Open the Microsoft Artifact Registry and filter for IoT Edge modules
* Search for the module **Simulated Temperature Sensor**
* Choose the IoT Edge device to receive this module

Use the Azure portal to define the stages for deploying the module.

1. **Add modules**: Enter the URI for the **Simulated Temperature Sensor** module.
1. **Specify routes**: Routing specifies how messages are passed between modules and IoT Hub. In this case, we select all messages from all modules to go to IoT Hub.
1. **Review Deployment**: This allows you to preview the deployment manifest JSON file that defines all the modules deployed to your IoT Edge device.

## What is a deployment manifest?

A deployment manifest is a JSON document that describes which modules to deploy, how data flows between the modules, and the module twins' desired properties. The deployment manifest tells your device which modules to install and how to configure them to work together. All IoT Edge devices must be configured with a deployment manifest.

> [!NOTE]
> When you submit a new deployment to an IoT Edge device, **nothing is pushed to your device** Instead, the device regularly queries IoT Hub for any new instructions. If the device finds an **updated deployment manifest**, it uses the information to **pull the module images** from the cloud and starts running the modules locally.

## View generated data

The "Simulated Temperature Sensor" module generates sample data for testing. The module also generates environment data, such as data for the machine and its surroundings. For example, this sensor could be in a server room, factory floor, or wind turbine. The message includes ambient temperature, humidity, machine temperature, pressure, and a timestamp.  

## Clean up resources

To prevent unintended changes, delete Azure resources as needed, including the device you created and the resource group. Make sure the resources you delete aren't needed again.
