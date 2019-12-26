## Submitting a new deployment to an IoT Edge device

To deploy a pre-built module to the edge device, you must first choose an IoT Edge module from the Azure Marketplace and also choose the IoT Edge device to receive the module

You can access the module **Simulated Temperature Sensor** by searching the marketplace accessed through the Azure portal. Once you identify this module, choose the IoT Edge device to receive this module. A three-step wizard helps to define the stages to deploy the module

In the first step (Add Modules), choose only the **Simulated Temperature Sensor** module

The second stage of the wizard is the (**specify routes**) stage. Routing specifies how messages are passed between modules and to IoT Hub.  In this case, we specify that all messages from all modules to go to IoT Hub. In the third step (**Review Deployment**), you can preview the JSON file that defines all the modules that get deployed to your IoT Edge device. When you submit a new deployment to an IoT Edge device, nothing is pushed to your device. Instead, the device queries IoT Hub regularly for any new instructions. If the device finds an updated **deployment manifest**, it uses the information about the new deployment to pull the module images from the cloud then starts running the modules locally.  The wizard creates a deployment manifest through the three steps. A deployment manifest is a JSON document that describes which modules to deploy, how data flows between the modules and desired properties of the module twins. The deployment manifest is used to tell your device which modules to install and how to configure them to work together. All IoT Edge devices must be configured with a deployment manifest

## View generated data

The Simulated Temperature Sensor module creates sample data that you can use for testing. The module also generates environment data, i.e. data for the machine and the environment around the machine. For example, this sensor might be in a server room, on a factory floor, or on a wind turbine. The message includes ambient temperature and humidity, machine temperature and pressure, and a timestamp.  

## Clean up resources

To avoid changes, delete Azure resources as needed, including the device that you created, the resource group. Ensure that the resources deleted won't be needed again.