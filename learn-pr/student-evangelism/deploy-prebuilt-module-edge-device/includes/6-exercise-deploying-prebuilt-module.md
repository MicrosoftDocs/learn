To deploy the Simulated temperature sensor module from the Azure Marketplace, use the following steps:

1. In the Azure portal, enter Simulated Temperature Sensor into the search and open the Marketplace result.

2. Choose an IoT Edge device to receive this module. On the Target Devices for IoT Edge Module page, provide the following information: Subscription: select the subscription that contains the IoT hub you're using; IoT Hub: select the name of the IoT hub you're using; IoT Edge Device Name:  as selected before  

3. Select Create.

4. Using the three-step wizard, define exactly how to deploy the module. In the **Add Modules** step of the wizard, the SimulatedTemperatureSensor module should be is autopopulated.  In the **Specify Routes step** of the wizard, you define how messages are passed between modules and to IoT Hub. If this setting is not autopopulated to $upstream, add the following code:

   ```
    {
    	"routes": {
        	       "route": "FROM /messages/* INTO $upstream"
        	       }
    	}
   ```


In the Review Deployment step of the wizard, preview the JSON file that defines all the modules that get deployed to your IoT Edge device. Ensure that the  SimulatedTemperatureSensor module is included.  

5. Select your device from the list of IoT Edge devices to see its details. On the device details page, scroll down to the Modules section. Three modules should be listed: $edgeAgent, $edgeHub, and SimulatedTemperatureSensor. If one or more of the modules are listed as specified in deployment but not reported by the device, your IoT Edge device is still starting them. Wait a few moments and select Refresh at the top of the page.

6. Open the command prompt on your IoT Edge device again, or use the SSH connection from Azure CLI. Confirm that the module deployed from the cloud is running on your IoT Edge device using the command **sudo iotedge list**

7. View the messages being sent from the temperature sensor module using the command **sudo iotedge logs SimulatedTemperatureSensor -f.** Note that IoT Edge commands are case-sensitive when referring to module names.

8. Clean up resources