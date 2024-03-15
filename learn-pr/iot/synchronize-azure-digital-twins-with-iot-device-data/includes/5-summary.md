In this module, you synchronized an Azure Digital Twins representation with data from a simulated smart building.

First, you set up the sample scenario of a developer with an Azure Digital Twins instance representing a smart building, which contains thermostats and rooms. Then, you deployed Azure resources, wrote Azure function code, and connected these resources together to enable data flow from a thermostat device into Azure Digital Twins. You tested this data flow with a simulated thermostat device, and verified that the matching *Thermostat67* twin in Azure Digital Twins was updating its *Temperature* value based on device readings.

Then, you deployed more Azure resources, wrote a second Azure function, and connected these new resources together to enable data flow from one twin in Azure Digital Twins to its parent. You tested this flow by running the device simulator again, and verifying that when the *Thermostat67* twin was updated, the twin for the room containing that thermostat (*Room21*) was updated to match.

Completing this data flow has enabled you as the sample scenario developer to have a fully-connected, digital representation of your smart building. The properties of the digital representation are synchronized with the state of your real building, enabling you to answer questions about your environment quickly and efficiently through queries. These queries can also be used to enable alerts, and build dashboards for building managers to monitor temperatures across the building at a glance.

[!INCLUDE [Instructions to clean up Azure Digital Twins resources](../../includes/clean-up-azure-digital-twins.md)]

You might want to delete the device simulator project you downloaded to your machine in Unit 2, and the Azure functions project you created in Unit 3. You might also want to delete the following installations, if you downloaded them specifically for this module:
* Visual Studio
* .NET
