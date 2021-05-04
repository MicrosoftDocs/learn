An Azure SignalR service has been exposed as part of the ARM template that you deployed enables you to connect to ADT.  A data pipeline has been created to retrieve the data from ADT and is abstracted from the client app that will be running on HoloLens 2.

To expose the data via ADT to your client app, you only need to connect to the Azure SignalR service. The app you are building for the HoloLens implements a SignalR client to connect to the SignalR service.  Establishing communication between the SignalR client and the Azure SignalR service requires the client to invoke the negotiate function in the SignalR service.

As part of this module, 

- Open the Visual Studio solution downloaded/pulled in the previous exercise
1.	Open **DeviceSimulator.sln**

- Configure the DeviceSimulator with the Host name for the ADT resource type created by the ARM template
1.	Log into your [Azure Portal](https://portal.azure.com/)
2.	Locate and select the newly created Resource Group.  This can be found in your Resource Groups service listing.  The Resource Group name will be based on the **projectname** variable name you supplied while running the ARM Template in the previous exercise.  It will have a **-rg** appended to it. In our example going forward, we used *dtwindfarm* as the projectname 

<!-- :::image type="content" source="" alt-text=""::: -->

3.	Locate and select your Azure Digital Twins resource type.  It will be named after your projectname with some random characters appended to ensure uniqueness.  It will be the only Azure Digital Twins resource in your newly created Resource Group.

<!-- :::image type="content" source="" alt-text=""::: -->

4.	Copy the **Essentials > Host name**

<!-- :::image type="content" source="" alt-text=""::: -->

5.	In your Visual Studio **DeviceSimulator** solution, open the **AzureIoTHub.cs** file in the editor and paste your Host name value copied from Step 4 above into the **adtInstanceUrl** string variable.  Prepend https:// to your adtInstanceUrl variable at the beginning, so that it is a valid Url string.

<!-- :::image type="content" source="" alt-text=""::: -->

## Configure the DeviceSimulator with the Primary connection string for the IoT Hub created by the ARM template

1.	In your Azure portal, navigate to the IoT Hub resource type in your Resource group and select it.  There should only be one IoT Hub resource in the group

<!-- :::image type="content" source="" alt-text=""::: -->

2.	Select **Settings > Shared access policies**
3.	Click **iothubowner**
4.	Copy the **Primary connection string**
5.	In your Visual Studio **DeviceSimulator** solution, open the **AzureIoTHub.cs** file in the editor and paste your **Primary connection string** value copied from Step 4 above into the **iotHubConnectionString** string variable.

<!-- :::image type="content" source="" alt-text=""::: -->

## Configure the DeviceSimulator with the authentication keys created by the ARM template 

1.	Open the text file you created in the previous exercise during the **Create the App Registration step**.  
2.	In your Visual Studio **DeviceSimulator** solution, open the **PropUpdater.cs** file in the editor.  Copy and paste the data (GUIDs) from your text file to the .cs file based on the following mappings from the .cs variables to the JSON data output in your text file:
i.	clientId →  	appId
ii.	clientSecret →	password
iii.	tenantId →  	tenant

<!-- :::image type="content" source="" alt-text=""::: -->

3.	Save your work in Visual Studio by selecting **File > Save All**

## Add the ADT Connection Prefab Asset to your Unity Scene and configure with the Get Function Url from the Function App created by the ARM template

1.	Within your Resource Group in Azure that you created in previous exercises, locate your Function App and click it. It will be named after your **projectname** with **funcappxxxxxxxxxxx** appended to the end.

<!-- :::image type="content" source="" alt-text=""::: -->

2.	Select **Functions > Functions** from the left panel.  Select **Negotiate**.

<!-- :::image type="content" source="" alt-text=""::: -->

3.	Select **Get Function Url** and copy the Function Url.  It may take 10-20 seconds for this value to appear.
 
<!-- :::image type="content" source="" alt-text=""::: -->

4.	Return to your Unity project
5.	Select the **ADTConnection** game object in the Hierarchy.  If it’s missing from your hierarchy, drag the **Assets > ADTPrefabs > ADTConnection** Prefab Asset to your **MainScene** hierarchy

<!-- :::image type="content" source="" alt-text=""::: -->

6.	Add the Url under the **ADT Data Handler (Script)** Component with the Function Url obtained in Step 3.  Include everything in the Url up to and including **.../api**.  Do not include the last backslash nor the word “negotiate”.

<!-- :::image type="content" source="" alt-text=""::: -->

7. **Save** the scene

Now that the Azure services are set up and the appropriate pointers are within your Unity Scene, you will create a User Interface to visualize the operations data.
 
