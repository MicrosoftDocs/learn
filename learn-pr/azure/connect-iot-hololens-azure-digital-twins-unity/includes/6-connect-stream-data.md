An Azure SignalR Service has been exposed as part of the ARM template that you deployed. This service and associated setup enables you to connect to Azure Digital Twins. A data pipeline has been created to retrieve data from digital twins, which is abstracted from the client app that runs in mixed reality.

## Azure SignalR Service overview

Azure SignalR Service simplifies the process of adding real-time web functionality to applications over HTTP. This real-time functionality allows the service to push content updates to connected clients, such as a single page web or mobile application. As a result, clients are updated without the need to poll the server or submit new HTTP requests for updates. Any scenario that requires pushing data from server to client in real time can use Azure SignalR Service. Traditional real-time features that often require polling from a server can also use Azure SignalR Service.

The Azure SignalR Service can be easily integrated with other Azure services, which opens up other possible scenarios. For example, Azure Functions can use the REST API to push notifications to the Azure SignalR Service, which then pushes data to connected clients in real time. The Azure SignalR Service, used with IoT Hub, can enable real-time sensor data to be transmitted to connected clients to support real-time monitoring scenarios.

Real-time scenarios often come with high-frequency data flows and large quantities of concurrent connections between the client and server. They require nontrivial infrastructure setup to get the functionality up and running at scale. Configuring this infrastructure at scale is difficult. The configuration usually requires application specific logic at various network layers. The Azure SignalR Service handles those issues, so you can focus on the application logic that delivers real-time connected experiences. You can scale real-time functionality dynamically while paying only for what you use. The service also inherits Azure SignalR Service capabilities for persistent connections over various transports.

Azure SignalR Service has been used in a wide variety of industries for any application type that requires real-time content updates. Here are some examples that are good to use Azure SignalR Service:

- **High frequency data updates:** gaming, voting, polling, and auction
- **Dashboards and monitoring:** company dashboard, financial market data, instant sales update, multi-player game leader board, and IoT monitoring
- **Real-time location on map:** logistic tracking, delivery status tracking, transportation status updates, and GPS apps
- **Real time targeted ads:** personalized real-time push ads and offers, and interactive ads
- **Collaborative apps:** coauthoring, whiteboard apps, and team meeting software
- **Push notifications:** social network, email, game, and travel alert
- **Real-time broadcasting:** live audio/video broadcasting, live captioning, translating, and events/news broadcasting
- **IoT and connected devices:** real-time IoT metrics, remote control, real-time status, and location tracking
- **Automation:** real-time trigger from upstream events

For your wind turbine use case, the communication layer between the Azure Digital Twins wind turbine data and your mixed reality device uses the Azure SignalR Service and a SignalR client embedded in the mixed-reality app.

To expose the data to your client app by using Azure Digital Twins, you need to connect to the Azure SignalR Service. The mixed-reality app that you're building implements a SignalR client to connect to the SignalR service. Establishing communication between the SignalR client and the Azure SignalR service requires the client to invoke the `negotiate` function in the SignalR service.

Configure your `DeviceSimulator` with your Azure Digital Twins connection parameters and authentication details captured in the previous exercise.

## Get app credentials

1. Open *DeviceSimulator.sln* in Visual Studio and configure the `DeviceSimulator` with the host name for the Azure Digital Twins resource type created by the ARM template.
1. Open the *Azure_config_settings.txt* text file that you created in the last exercise that contains the key Azure Digital Twins configuration parameters using a text editor. Alternatively, if your PowerShell session remains active, look for the output from your `get-content` command.
1. From the *Azure_config_settings.txt* file or from the output of your `get-content` command in PowerShell, locate the key/value pair for the `adtHostName` key and copy the value. It should look similar to:

   ```console
   https://myprojadtxxxxxxxxxx.api.eus.digitaltwins.azure.net
   ```

   :::image type="content" source="../media/query-azure-deployment-to-file.png" alt-text="Screenshot of the command-line interface running the get-content command prompt." lightbox="../media/query-azure-deployment-to-file.png":::

1. In your Visual Studio *DeviceSimulator* solution, open the *AzureIoTHub.cs* file in the editor by double-clicking the file from **Solution Explorer**. Paste the value for your `adtHostName` key/pair copied from Step 2 above into the **adtInstanceUrl** string variable.

   :::image type="content" source="../media/host-name-cs-expanded.png" alt-text="Screenshot of the Device Simulator solution with the Azure IoT Hub cs file open and host name and instance URL values added." lightbox="../media/host-name-cs.png":::

## Configure the device simulator with primary connection string

Configure the `DeviceSimulator` with the primary connection string for the IoT Hub created by the ARM template.

1. From the *Azure_config_settings.txt* file or from the output of your `get-content` command in PowerShell, locate the key/value pair for the `connectionString` key and copy the value. It should look similar to:

   ```console
   HostName=myprojHubxxxxxxxxxx.azure-devices.net;SharedAccessKeyName=iothubowner;SharedAccessKey= xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx”
   ```

1. In your Visual Studio `DeviceSimulator` solution, open the *AzureIoTHub.cs* file in the editor and paste your `connectionString` value copied in the previous step into the **iotHubConnectionString** string variable.

   :::image type="content" source="../media/host-name-cs-expanded.png" alt-text="Screenshot of the Device Simulator solution with the Azure IoT Hub cs file open and IoT Hub connection string value added." lightbox="../media/host-name-cs.png":::

## Configure the device simulator with authentication keys

Configure the **DeviceSimulator** with the authentication keys created by the ARM template.

1. Open the *AppCredentials.txt* text file that you created in the previous exercise.
1. In your Visual Studio *DeviceSimulator* solution, open the *PropUpdater.cs* file in the editor. Copy and paste the globally unique identifiers (GUIDs) from your text file to the *.cs* file. Use the following mappings from the *.cs* variables to the JSON data output in your text file:

   | AppCredentials.txt | PropUpdater.cs |
   |---|---|
   | appId | clientId |
   | password | clientSecret |
   | tenant | tenantId |

   :::image type="content" source="../media/prop-updater-expanded.png" alt-text="Screenshot of the Device Simulator solution with the PropUpdater.cs file open and client, secret, and tenant ID values added." lightbox="../media/prop-updater.png":::

1. Select **File** > **Save All** to save your work in Visual Studio.

Connect your Azure Digital Twins prefab in Unity to the digital twins so that you can receive simulated telemetry data from the `DeviceSimulator`.

## Add the Azure Digital Twins connection prefab

Add the Azure Digital Twins connection prefab asset to your Unity scene and configure.

1. Return to your Unity project.
1. Select the `ADTConnection` game object in the **Hierarchy**. If it's missing from your hierarchy, drag the **Assets** > **ADTPrefabs** > **ADTConnection** prefab asset to your scene hierarchy.

   :::image type="content" source="../media/hierarchy-adt.png" alt-text="Screenshot of the Unity Hierarchy with the main scene highlighted.":::

1. Open the text file that you created in the last exercise, *Azure_config_settings.txt*, in a text editor. The file contains the key Azure Digital Twins configuration parameters. Alternatively, if your PowerShell session remains active, look for the output from your `get-content` command.
1. From the *Azure_config_settings.txt* file or from the output of your `get-content` command in PowerShell, locate the key/value pair for the `signalRNegotiatePath` key and copy the value. It should look similar to:

   ```console
   https://myprojfuncappxxxxxxxxxx.azurewebsites.net/api/negotiate
   ```

1. Add this value to the **Url** parameter under **ADT Data Handler (Script)** with the **Function Url** obtained in Step 1. Include everything in the URL up to and including `…/api`. Don't include the last backslash nor the word *negotiate*.

   :::image type="content" source="../media/adt-function-url.png" alt-text="Screenshot of the Unity editor with the Azure Digital Twins connection prefab selected and the ADT data handler script added." lightbox="../media/adt-function-url.png":::

1. **Save** the scene.

Now that the Azure services are set up and the appropriate pointers are within your Unity scene, you can create a user interface (UI) to visualize the operations data.
