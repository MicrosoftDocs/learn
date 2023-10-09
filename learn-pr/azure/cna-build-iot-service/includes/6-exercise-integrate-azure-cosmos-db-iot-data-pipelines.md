This exercise provides an overview of setting up the collection, processing, and storage of IoT telemetry generated, by using an Azure IoT Central application. 

In this exercise, you'll:

- Create an Azure IoT Central application
- Create an Azure function that logs an HTTP request payload
- Configure and validate IoT telemetry rules of an Azure IoT Central application

## Prerequisites

To perform this exercise, you need:

- A Microsoft account or an Azure AD account with the Global Administrator role in the Azure AD tenant that's associated with the Azure subscription and with the Owner or Contributor role in the Azure subscription.
- To have completed the exercise unit **Set up Azure Cosmos DB**.
- An active Azure subscription. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?WT.mc_id=A261C142F) before you begin.

## Create an Azure IoT Central application

1. Navigate to the [Create IoT Central Application](https://portal.azure.com/#create/Microsoft.IoTCentral) page in the Azure portal. If prompted, sign in with your Azure account.

1. Enter the following information:

    | Field | Description |
    | ----- | ----------- |
    | Subscription | The Azure subscription you want to use. |
    | Resource group | The resource group you want to use.  You can create a new resource group or use an existing one. |
    | Resource name | A valid Azure resource name such as *adatum-iot-custom-application*. |
    | Application URL | A URL subdomain for your application such as *adatum-iot-custom-application*. The URL for an IoT Central application looks like `https://adatum-iot-custom-application.azureiotcentral.com`. |
    | Template | **In-store application - Condition Monitoring** |
    | Region | The Azure region you want to use. |
    | Pricing plan | Select one of the standard pricing plans. To learn about pricing, see [Azure IoT Central pricing](https://azure.microsoft.com/pricing/details/iot-central/). |

1. Select **Review + create**. Then select **Create**.

When the app is ready, you can navigate to it from the Azure portal:

:::image type="content" source="../media/6-view-app-portal.png" alt-text="Screenshot that shows the IoT Central application resource in the Azure portal. The application URL is highlighted.":::

> [!TIP]
> To list all the IoT Central applications you have access to, navigate to [IoT Central Applications](https://apps.azureiotcentral.com/myapps).

This will display the **Dashboard** page. This might take a few minutes. Review telemetry and analytics of the sample Azure IoT Central application:

1. On the **Dashboard** page of the IoT Central Application portal, in the vertical menu, select **Devices**.
1. In the **Thermostat** section, select **Thermostat-Zone1**.
1. On the **Thermostat-Zone1** pane, review the content of the **Dashboard** tab.

   :::image type="content" source="../media/6-iot-device-thermostat-zone-1-dashboard.png" alt-text="Screenshot of the Dashboard tab of the Thermostat-Zone1 device pane in the IoT Central Application portal.":::

1. Select the **Raw data** tab, and review the content.

   :::image type="content" source="../media/6-iot-device-thermostat-zone-1-raw-data.png" alt-text="Screenshot of the Raw data tab of the Thermostat-Zone1 device pane in the IoT Central Application portal.":::

## Create an Azure function that logs an HTTP request payload

In this task, you're creating an Azure Function app that implements the HTTP webhook functionality. Apply this functionality to forward the telemetry data from the Azure IoT Central application by creating an application rule.

1. Start a web browser, navigate to the [Azure portal](https://portal.azure.com/?azure-portal=true), and sign in to the Azure subscription you're using for this module.
1. Use the **Search resources, services, and docs** text box to search for **Function App**.
1. On the **Function App** pane, select **+ Create**.
1. On the **Basics** tab, configure the following settings, and then select **Review + create**.

   | Setting | Configuration |
   | --- | --- |
   | Subscription | Select the name of the Azure subscription you're using for this module. |
   | Resource Group | Create a new resource group named **function-app-RG**. |
   | Function App name | Enter a unique name that consists of lower-case letters, digits, or dashes, and starts with a letter. |
   | Publish | Select **Code**. |
   | Runtime stack | Select **.NET**. |
   | Version | Select **6**. |
   | Region | Select the Azure region closest to the location of your lab environment, preferably matching the location you chose for the Azure IoT Central deployment. |
   | Operating system | Windows |
   | Plan type | Consumption (serverless) |

   :::image type="content" source="../media/6-azure-function-app-create.png" alt-text="Screenshot of the Basics tab of the Create Function App pane in the Azure portal.":::

1. Select **Create**.

   > [!NOTE]
   > Wait for the Azure Function app provisioning to complete. This might take about two minutes.

1. When the Azure Function app deployment is complete, select **Go to resource**.
1. On the Azure Function app pane, select **Functions**, and then select **+ Create**.
1. On the **Add function** pane, specify the following settings, and then select **Create**.

   | Setting | Configuration |
   | --- | --- |
   | Development environment | **Develop in portal** |
   | Template | **HTTP trigger** |
   | New Function | **HttpTrigger1** |
   | Authorization level | **Function** |

   :::image type="content" source="../media/6-azure-function-app-function-add.png" alt-text="Screenshot of the Add function pane of the Azure Function app in the Azure portal.":::

1. On the **HttpTrigger1** pane, select **Integration** from the menu.

   :::image type="content" source="../media/6-azure-function-integration.png" alt-text="Screenshot of the Integration function pane of the Azure Function app in the Azure portal.":::

1. In the rectangle labeled **Outputs**, select **+ Add output**.
1. Configure the following settings, and then select **OK**:

   | Setting | Configuration |
   | --- | --- |
   | Binding type | Select **Azure Cosmos DB**. |
   | Document parameter name | Replace the default value **outDoc**. |
   | Database name | Enter the name of the database you created in the previous exercise, **iotdb**. |
   | Collection Name | Enter **iotcollection**. |
   | If true, creates the Cosmos DB database | Select **Yes**. |
   | Cosmos DB account connection | Select **New**. In the **New Cosmos DB connection** popup window, ensure that the **Azure Cosmos DB Account** option is selected. In the **Cosmos DB account connection** drop-down list, select the entry representing the Cosmos DB account you created in the previous exercise, and then select **OK** twice. |
   | Partition key (optional) | Enter **/pk/timestamp/deviceid**. |

   :::image type="content" source="../media/6-azure-function-cosmos-db-output.png" alt-text="Screenshot of the Create Output pane of the HttpTrigger1 Integration pane of an Azure function in the Azure portal.":::

   > [!NOTE]
   > When choosing an optimal partition key, it's important to consider the usage patterns and the 20 GB logical partition size limit. You could, for example, create a synthetic partition key consisting of a combination of **deviceId** and **date**.

1. Select **Code + Test**.
1. Replace the existing code with the following content, and then select **Save**.

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

   :::image type="content" source="../media/6-azure-function-app-function-code-test.png" alt-text="Screenshot of the Code + Test pane of the HttpTrigger1 of the Azure Function app in the Azure portal displaying the code.":::

   > [!NOTE]
   > The function logs the JSON-based payload of the HTTP request and constructs individual JSON elements to be stored in an individual document of the target Cosmos DB collection corresponding to the function output you configured. You could use the **pk** element, which consists of the concatenated deviceId property and date of the collected telemetry data point, as the partition key.

1. Select **Get function URL** for the function key and record its value.

   :::image type="content" source="../media/6-azure-function-app-function-url.png" alt-text="Screenshot of the Code + Test pane of the HttpTrigger1 of the Azure Function app in the Azure portal, with the Get function URL pop-up window.":::

## Configure and validate IoT telemetry rules of an Azure IoT Central application

1. Switch back to the web browser window displaying the **Devices** page of Azure IoT Central application you created previously in this exercise.
1. In the vertical menu of the IoT Central Application portal, select **Rules**.
1. Select **+ New**, and configure the following settings:

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

1. Select **Done**, and then select **Save**.
1. Switch back to the web browser window displaying the **HttpTrigger1 | Code + Test** pane in the Azure portal.
1. Select **Monitor**, and then select the **Logs** tab.
1. Verify that the **logs** pane displays the messages generated in response to the HTTP trigger originating from the Azure IoT Central application webhook you configured previously in this task.
1. Switch to the web browser window displaying the **Data Explorer** pane of the Cosmos DB account you provisioned in the previous exercise.
1. In the **NOSQL API** section, select the circular arrow **Refresh** button, expand the **iotdb** node and its **iotcollection**, select the **Items** node, and then select the first document in the list of items.
1. Verify that the **details** pane of the **Items** tab in the **Data Explorer** window displays the telemetry data generated by devices registered with the Azure Central IoT application and processed by the Azure function, including **pk**, **timestamp**, **deviceId**, and **temperature**.

   :::image type="content" source="../media/6-azure-cosmos-db-iot-collection-items.png" alt-text="Screenshot of the Azure Cosmos DB items representing telemetry data generated by devices registered with Azure IoT Central and processed by the Azure function.":::

## Results

Congratulations! You completed the second exercise of this module. In this exercise, you created an Azure IoT Central application.
