This exercise provides an overview of setting up the collection, processing, and storage of IoT telemetry generated, by using an Azure IoT Central application. 

In this exercise, you'll:

- Create an Azure IoT Central application
- Create an Azure function that logs an HTTP request payload
- Configure and validate IoT telemetry rules of an Azure IoT Central application

## Prerequisites

To perform this exercise, you need:

- An Azure subscription.
- A Microsoft account or an Azure AD account with the Global Administrator role in the Azure AD tenant that's associated with the Azure subscription and with the Owner or Contributor role in the Azure subscription.
- To have completed the exercise unit **Set up Azure Cosmos DB**.

## Create an Azure IoT Central application

1. Start a web browser and navigate to the [Welcome to IoT Central](https://apps.azureiotcentral.com/?azure-portal=true) page.
1. On the **Welcome to IoT Central** page, select the avatar icon in the upper right corner.
1. When prompted, sign in to access the Azure subscription you'll be using in this module.
1. On the **Welcome to IoT Central** page, expand the vertical menu, and then select the **My apps** menu entry.
1. On the **My apps** page, select **+ New application**.
1. On the **Build your IoT application** page, ensure that the **Retail** tab is selected, review the available application, and in the **In-store analytics - condition monitoring** tile, select **Create app**.

   :::image type="content" source="../media/6-iot-central-create-app-using-template.png" alt-text="Screenshot of the built-in templates on the Build your IoT application page in the IoT Central Application portal.":::

1. On the **New application** page, configure the following settings, and then select **Create**.

   | Setting | Configuration |
   | --- | --- |
   | Application Name | Enter **adatum-iot-sample-application**. |
   | Application URL | Enter a unique name consisting of lower-case letters, digits, or dashes, and starting with a letter. |
   | Pricing plan | Select **Free**. |

   :::image type="content" source="../media/6-iot-new-application.png" alt-text="Screenshot of the New application page in the IoT Central Application portal.":::

   > [!NOTE]
   > This will display the **Dashboard** page. This might take a few minutes. Review telemetry and analytics of the sample Azure IoT Central application.

1. On the **Dashboard** page of the IoT Central Application portal, in the vertical menu, select **Devices**.
1. On the **Devices** page, in the **Thermostat** section, select **Thermostat-Zone1**.
1. On the **Devices** page, on the **Thermostat-Zone1** pane, review the content of the **Dashboard** tab.

   :::image type="content" source="../media/6-iot-device-thermostat-zone-1-dashboard.png" alt-text="Screenshot of the Dashboard tab of the Thermostat-Zone1 device pane in the IoT Central Application portal.":::

1. On the **Devices** page, on the **Thermostat-Zone1** pane, select the **Raw data** tab header, and review the content of the **Raw data** tab.

   :::image type="content" source="../media/6-iot-device-thermostat-zone-1-raw-data.png" alt-text="Screenshot of the Raw data tab of the Thermostat-Zone1 device pane in the IoT Central Application portal.":::

## Create an Azure function that logs an HTTP request payload

In this task, you'll create an Azure Function app that implements the HTTP webhook functionality. You'll apply this functionality to forward the telemetry data from the Azure IoT Central application by creating an application rule.

1. Start a web browser, navigate to the [Azure portal](https://portal.azure.com/?azure-portal=true), and sign in to access the Azure subscription you'll be using in this module.
1. Use the **Search resources, services, and docs** text box at the beginning of the Azure portal page to search for **Function App**.
1. On the **Function App** blade, select **+ Create**.
1. On the **Basics** tab of the **Create Function App** blade, configure the following settings, and then select **Next: Hosting >**

   | Setting | Configuration |
   | --- | --- |
   | Subscription | Select the name of the Azure subscription you'll be using in this module. |
   | Resource Group | Create a new resource group named **function-app-RG**. |
   | Function App name | Enter a unique name that consists of lower-case letters, digits, or dashes, and starts with a letter. |
   | Publish | Select **Code**. |
   | Runtime stack | Select **.NET**. |
   | Version | Select **3.1**. |
   | Region | Select the Azure region closest to the location of your lab environment, preferably matching the location you chose for the Azure IoT Central deployment. |

   :::image type="content" source="../media/6-azure-function-app-create-basics.png" alt-text="Screenshot of the Basics tab of the Create Function App blade in the Azure portal.":::

1. On the **Hosting** tab of the **Create Function App** blade, accept the default settings, and then select **Next: Monitoring >**.
1. On the **Monitoring** tab of the **Create Function App** blade, accept the default settings, and then select **Review + create**.
1. On the **Review + create** tab of the **Create Function App** blade, select **Create**.

   > [!NOTE]
   > Wait for the Azure Function app provisioning to complete. This might take about two minutes.

1. Within the browser window displaying the Azure portal with the Azure Function app provisioning status blade, select **Go to resource**.
1. On the Azure Function app blade, select **Functions**, and then select **+ Add**.
1. On the **Add function** blade, specify the following settings, and then select **Add**.

   | Setting | Configuration |
   | --- | --- |
   | Development environment | **Develop in portal** |
   | Template | **HTTP trigger** |
   | New Function | **HttpTrigger1** |
   | Authorization level | **Function** |

   :::image type="content" source="../media/6-azure-function-app-function-add.png" alt-text="Screenshot of the Add function blade of the Azure Function app in the Azure portal.":::

1. On the **HttpTrigger1** blade, in the vertical menu bar on the left side, in the **Developer** section, select **Integration**.

   :::image type="content" source="../media/6-azure-function-integration.png" alt-text="Screenshot of the Integration function blade of the Azure Function app in the Azure portal.":::

1. On the **HttpTrigger1 \| Integration** blade, in the rectangle labeled **Outputs**, select **+ Add output**.
1. On the **Create Output** blade, configure the following settings, and then select **OK**:

   | Setting | Configuration |
   | --- | --- |
   | Binding type | Select **Azure Cosmos DB**. |
   | Document parameter name | Replace the default value **outDoc**. |
   | Database name | Enter the name of the database you created in the previous exercise, **iotdb**. |
   | Collection Name | Enter **iotcollection**. |
   | If true, creates the Cosmos DB database | Select **Yes**. |
   | Cosmos DB account connection | Select **New**. In the **New Cosmos DB connection** popup window, ensure that the **Azure Cosmos DB Account** option is selected. In the **Cosmos DB account connection** drop-down list, select the entry representing the Cosmos DB account you created in the previous exercise, and then select **OK** twice. |
   | Partition key (optional) | Enter **/pk/timestamp/deviceid**. |

   :::image type="content" source="../media/6-azure-function-cosmos-db-output.png" alt-text="Screenshot of the Create Output blade of the HttpTrigger1 Integration blade of an Azure function in the Azure portal.":::

   > [!NOTE]
   > When choosing an optimal partition key, it's important to consider the usage patterns and the 20 GB logical partition size limit. You could, for example, create a synthetic partition key consisting of a combination of **deviceId** and **date**.

1. On the **HttpTrigger1 \| Integration** blade, in the vertical menu bar, in the **Developer** section, select **Code + Test**.
1. On the **HttpTrigger1 \| Code + Test** blade, replace the existing code with the following content, and then select **Save** to save your changes:

   ```csharp
   #r "Newtonsoft.Json"

   using Microsoft.Azure.WebJobs.Host;
   using Newtonsoft.Json;
   using Newtonsoft.Json.Linq;
   using Microsoft.Extensions.Logging;
   using Microsoft.AspNetCore.Mvc;

   public static void Run(HttpRequest req, out object outDoc, ILogger log)
   {
     log.LogInformation($"C# Queue trigger function processed: {req.Body}");

     string requestBody = new StreamReader(req.Body).ReadToEnd();
     dynamic iotDataJson = JObject.Parse(requestBody);
     dynamic iotData = JsonConvert.DeserializeObject<dynamic>(iotDataJson.ToString());

     log.LogInformation($"{iotData}");

     outDoc = new {
       pk = iotData.device.id + "-" + iotData.timestamp.ToString("yyyyMMdd"),
       timestamp = iotData.timestamp,
       deviceId = iotData.device.id,
       temperature = iotData.device.telemetry.Thermostat_1o.temp.value
     };
   }
   ```

   :::image type="content" source="../media/6-azure-function-app-function-code-test.png" alt-text="Screenshot of the Code + Test blade of the HttpTrigger1 blade of the Azure Function app in the Azure portal displaying the code.":::

   > [!NOTE]
   > The function logs the JSON-based payload of the HTTP request and constructs individual JSON elements to be stored in an individual document of the target Cosmos DB collection corresponding to the function output you configured. You could use the **pk** element, which consists of the concatenated deviceId property and date of the collected telemetry data point, as the partition key.

1. On the **HttpTrigger1 \| Code + Test** blade, select **Get function URL** for the function key and record its value.

   :::image type="content" source="../media/6-azure-function-app-function-url.png" alt-text="Screenshot of the Code + Test blade of the HttpTrigger1 blade of the Azure Function app in the Azure portal, with the Get function URL pop-up window.":::

## Configure and validate IoT telemetry rules of an Azure IoT Central application

1. Switch back to the web browser window displaying the **Devices** page of Azure IoT Central application you created previously in this exercise.
1. In the IoT Central Application portal, in the vertical menu, select **Rules**.
1. On the **Rules** page, select **+ New**, and configure the following settings:

   | Setting | Configuration |
   | --- | --- |
   | Rule name | Enter **Adatum IoT telemetry rule**. |
   | Device template | Select **Thermostat**. |
   | Time aggregation | Ensure that the settings are turned **Off**. |
   | Telemetry | Select **Temperature**. |
   | Operator | Select **is greater than**. |
   | Enter a value | Enter **0**. |
   | Action | Select **+ Webhook**. |
   | Display name | Enter **Azure function webhook**. |
   | Callback URL | Paste the value of the Azure function URL you recorded in the previous task of this exercise. |

   :::image type="content" source="../media/6-iot-custom-application-rule-1.png" alt-text="Screenshot of the first part of the sample Azure IoT Central application rule.":::

   :::image type="content" source="../media/6-iot-custom-application-rule-2.png" alt-text="Screenshot of the second part of the sample Azure IoT Central application rule.":::

   > [!NOTE]
   > The value of the temperature telemetry is intentionally artificially low to invoke the webhook functionality and trigger the function. In real-life scenarios, you'd adjust it to correspond to the condition that warrants the data collection that you intend to store in the target Cosmos DB collection.

1. On the **Rules** page, select **Done**, and then select **Save**.
1. Switch back to the web browser window displaying the **HttpTrigger1 \| Code + Test** blade in the Azure portal.
1. In the vertical menu, in the **Developer** section, select the **Monitor** entry. On the **HttpTrigger1 \| Code + Test** blade, select the **Logs** tab.
1. Verify that the **logs** pane displays the messages generated in response to the HTTP trigger originating from the Azure IoT Central application webhook you configured previously in this task.
1. Switch to the web browser window displaying the **Data Explorer** blade of the Cosmos DB account you provisioned in the previous exercise.
1. On the **Data Explorer** blade of the Cosmos DB account, in the **SQL API** section, select the **Refresh** button (in the form of a circular arrow), expand the **iotdb** node and its **iotcollection**, select the **Items** node, and then select the first document in the list of items.
1. Verify that the **details** pane of the **Items** tab in the **Data Explorer** window displays the telemetry data generated by devices registered with the Azure Central IoT application and processed by the Azure function, including **pk**, **timestamp**, **deviceId**, and **temperature**.

   :::image type="content" source="../media/6-azure-cosmos-db-iot-collection-items.png" alt-text="Screenshot of the Azure Cosmos DB items representing telemetry data generated by devices registered with Azure IoT Central and processed by the Azure function.":::

## Results

Congratulations! You completed the second exercise of this module. In this exercise, you created an Azure IoT Central application.
