Two steps are required to deploy a pre-built module to an edge device:

* Choose an IoT Edge module from a container registry
* Select the IoT Edge device to receive the module

For our scenario, we want to use a module simulating temperature data.

* Open the Microsoft Artifact Registry and filter for IoT Edge modules
* Search for the module **Simulated Temperature Sensor**
* Choose the IoT Edge device to receive this module

Use the Azure portal to define the stages to deploy the module.

1. **Add modules**: Enter the URI for the **Simulated Temperature Sensor** module.
1. **Specify routes**: Routing specifies how messages are passed between modules and IoT Hub. In this case, we select all messages from all modules to go to IoT Hub.
1. **Review Deployment**: This allows you to preview the deployment manifest JSON file that defines all the modules deployed to your IoT Edge device.

## What is a deployment manifest?

A deployment manifest is a JSON document that describes which modules to deploy, how data flows between the modules and the module twins' desired properties. The deployment manifest tells your device which modules to install and how to configure them to work together. All IoT Edge devices must be configured with a deployment manifest

> [!NOTE]
> When you submit a new deployment to an IoT Edge device, **nothing is pushed to your device**. Instead, the device queries IoT Hub regularly for any new instructions. If the device finds an **updated deployment manifest**, it uses the found information to **pull the module images** from the cloud and starts running the modules locally.

## View generated data

The "Simulated Temperature Sensor" module creates sample data you can use for testing. The module also generates environment data, i.e., data for the machine and the environment around the machine. For example, this sensor might be in a server room, a factory floor, or a wind turbine. The message includes ambient temperature and humidity, machine temperature and pressure, and a timestamp.  

## Clean up resources

To avoid changes, delete Azure resources as needed, including the device that you created, the resource group. Ensure that the resources deleted won't be needed again.
