An Azure SignalR service has been exposed as part of the ARM template that you deployed. This service and associated setup enables you to connect to ADT.  A data pipeline has been created to retrieve data from ADT, which is abstracted from the client app that will be running on HoloLens 2.

To expose the data to your client app via ADT, you need to connect to the Azure SignalR service. The HoloLens 2 app that you're building implements a SignalR client to connect to the SignalR service.  Establishing communication between the SignalR client and the Azure SignalR service requires the client to invoke the **negotiate** function in the SignalR service.

Configure your **DeviceSimulator** with your ADT connection parameters and authentication details captured in the previous exercise.  

## Get app credentials

1. Open **DeviceSimulator.sln** in Visual Studio and configure the DeviceSimulator with the Host name for the ADT resource type created by the ARM template
2. Open the **Azure_config_settings.txt** text file that you created in the last exercise containing the key Azure ADT configuration parameters, using a text editor.  Alternatively, if your PowerShell session remains active, look for the output from your **get-content** command.
3. From the **Azure_config_settings.txt** file or from the output of your **get-content** command in PowerShell, locate the key/value pair for the **adtHostName** key and copy the value.  It should look something similar to: 

```console
https://myprojadtxxxxxxxxxx.api.eus.digitaltwins.azure.net
```

:::image type="content" source="../media/query-azure-deployment-to-file.png" alt-text="Screenshot of the command-line interface running the get-content command prompt.":::

4. In your Visual Studio **DeviceSimulator** solution, open the **AzureIoTHub.cs** file in the editor by double-clicking the file from the Solution Explorer pane, typically found on the right-hand side of the application screen.  Paste the value for your **adtHostName** key/pair copied from Step 2 above into the **adtInstanceUrl** string variable.  

:::image type="content" source="../media/host-name-cs.png" alt-text="Screenshot of the Device Simulator solution open in Visual Studio. The Azure IoT Hub dot cs file is open and host name and instance url values added.":::

## Configure the DeviceSimulator with the Primary connection string for the IoT Hub created by the ARM template

1. From the **Azure_config_settings.txt** file or from the output of your **get-content** command in PowerShell, locate the key/value pair for the **connectionString** key and copy the value.  It should look something similar to: 

```console
HostName=myprojHubxxxxxxxxxx.azure-devices.net;SharedAccessKeyName=iothubowner;SharedAccessKey= xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx”, “name”: “myprojHubxxxxxxxxxx
```

2. In your Visual Studio **DeviceSimulator** solution, open the **AzureIoTHub.cs** file in the editor and paste your connectionString value copied from Step 1 above into the **iotHubConnectionString** string variable.

:::image type="content" source="../media/host-name-cs.png" alt-text="Screenshot of the Device Simulator solution open in Visual Studio. The Azure IoT Hub dot cs file is open and iot hub connection string value is added.":::

## Configure the DeviceSimulator with the authentication keys created by the ARM template 

1. Open the **AppCredentials.txt** text file that you created in the previous exercise.  
2. In your Visual Studio **DeviceSimulator** solution, open the **PropUpdater.cs** file in the editor.  Copy and paste the Globally Unique IDs (GUIDs) from your text file to the .cs file based on the following mappings from the .cs variables to the JSON data output in your text file:

| AppCredentials.txt | PropUpdater.cs |
|---|---|
| appId | clientId |
| password | clientSecret |
| tenant | tenantId |

:::image type="content" source="../media/prop-updater.png" alt-text="Screenshot of the Device Simulator solution open in Visual Studio. The prop updater dot cs file is open and client id, client secret, and tenant id values are added but blurred out.":::

3. Save your work in Visual Studio by selecting **File > Save All**

Connect your ADT Prefab in Unity to the ADT so that you can receive simulated telemetry data from the DeviceSimulator.

## Add the ADT Connection Prefab Asset to your Unity Scene and configure

1. Return to your Unity project
2. Select the **ADTConnection** game object in the Hierarchy.  If it’s missing from your hierarchy, drag the **Assets > ADTPrefabs > ADTConnection** Prefab asset to your **Scene** hierarchy

:::image type="content" source="../media/hierarchy-adt.png" alt-text="Screenshot of the Unity Hierarchy with the main scene highlighted.":::

3. Open the text file that you created in the last exercise containing the key Azure ADT configuration parameters you **Azure_config_settings.txt** using a text editor.  Alternatively, if your PowerShell session remains active, look for the output from your **get-content** command.
4. From the **Azure_config_settings.txt** file or from the output of your **get-content** command in PowerShell, locate the key/value pair for the **signalRNegotiatePath** key and copy the value.  It should look something similar to 

```console
https://myprojfuncappxxxxxxxxxx.azurewebsites.net/api/negotiate
```

5. Add this value to the **Url** parameter under the **ADT Data Handler (Script)** Component with the **Function Url** obtained in Step 3.  Include everything in the Url up to and including ```…/api```.  Don't include the last backslash nor the word “negotiate”.

:::image type="content" source="../media/adt-function-url.png" alt-text="Screenshot of the Unity editor with the ADT connection prefab selected and the ADT data handler script added. Main scene is in play mode and shows the terrain prefab.":::

7. **Save** the scene

Now that the Azure services are set up and the appropriate pointers are within your Unity Scene, you'll create a User Interface to visualize the operations data.