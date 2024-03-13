This module walks you through setting up an automatic data flow from a simulated IoT device into Azure Digital Twins. Then, you combine this data with business logic to update digital twin properties, keeping your twin graph up-to-date with your simulated environment.

Picture a sample scenario where you're a developer working to digitally represent a smart building. The building contains many rooms and each room is equipped with a smart thermostat, capable of sending temperature readings to the cloud. You've created the models and twins for the scenario in Azure Digital Twins, and now you need to set up the data flow to capture incoming thermostat readings and keep the graph synchronized to the state of your building. This will complete your digital twin representation, which can then be used to support queries and dashboards that building managers can use to monitor temperatures across the building at a glance.

In this module, you'll identify and set up Azure resources that can carry messages from a simulated device into Azure Digital Twins, including IoT Hub and an Azure function. You'll run the simulated device and test out the data flow. Then, you'll add on to the data flow, using Event Grid and another Azure function to propagate device messages from one twin to another in the Azure Digital Twins graph. You'll run the simulated device again and query Azure Digital Twins to test the full data flow.

After completing this module, you'll be able to identify which Azure services are used to send IoT data to Azure Digital Twins, and describe how data flows from an IoT device through these services into the twin graph. You'll also be able to identify the components of the Azure functions used to ingest device data and propagate data through Azure Digital Twins.

## Resources needed for hands-on exercises

This module includes hands-on exercises. To complete all the exercises, you need the following resources:
* An Azure subscription. If you don't have one, you can [create one for free now](https://azure.microsoft.com/free).
    - In your account, you need subscription-level permission to manage access to Azure resources (such as the *Owner* role). If you don't have this permission, you need cooperation from someone that does have that permission, who can run some commands on your behalf.
* Microsoft Visual Studio installed on your machine. You can download [Visual Studio Community](https://visualstudio.microsoft.com/downloads/) for free.
    - Make sure your installation includes the **Azure development** workload.
* .NET Core installed on your machine. You can download it for free at [.NET Core downloads](https://dotnet.microsoft.com/download/dotnet).