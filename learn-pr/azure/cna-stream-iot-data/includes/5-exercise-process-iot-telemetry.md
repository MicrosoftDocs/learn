This exercise provides an overview of using Azure IoT Central applications to configure rules and export IoT telemetry data. For more information, see:

* [Configure rules](/azure/iot-central/core/howto-configure-rules?azure-portal=true)
* [Create webhook actions on rules in Azure IoT Central](/azure/iot-central/core/howto-create-webhooks?azure-portal=true)
* [Export IoT data to cloud destinations using data export](/azure/iot-central/core/howto-export-data?azure-portal=true)

In this exercise, you'll:

* Create an Azure function that logs an HTTP request payload.
* Configure and validate IoT telemetry rules of an Azure IoT Central application.
* Create an Azure Storage account that will store IoT telemetry.
* Configure and validate data export of an Azure IoT Central application.

## Prerequisites

* An Azure subscription
* A Microsoft account or an Azure AD account with the Global Administrator role in the Azure AD tenant associated with the Azure subscription and with the Owner or Contributor role in the Azure subscription
* Completion of the exercise unit **Set up Azure IoT Central**

## Create an Azure function that logs an HTTP request payload

Before you configure Azure IoT Central application rules, you'll create an Azure Function app that will help validate rule processing. When implementing your cloud-native application, you can easily replace the Azure Function app with any other component that supports the HTTP webhook functionality.

1. In a web browser, navigate to the [Azure portal](https://portal.azure.com/?azure-portal=true) and sign in to access the Azure subscription you'll be using in this module.
1. Use the **Search resources, services, and docs** box at the beginning of the Azure portal page to search for, and select **Function App**.
1. On the **Function App** blade, select **+ New** or **+ Create**.
1. On the **Basics** tab of the **Create Function App** blade, configure the following settings, and then select **Review + create**:

   | Setting | Configuration |
   | --- | --- |
   | Subscription | Select the name of the Azure subscription you'll be using in this module. |
   | Resource Group | Create a new resource group named **iot-central-apps-RG**. |
   | Function App name | Enter a unique name consisting of lowercase letters, digits or dashes, and starting with a letter. |
   | Publish | Select **Code**. |
   | Runtime stack | Select **.NET**. |
   | Version | Select **3.1**. |
   | Region | Select the Azure region closest to the location of your lab environment, preferably matching the location of your Azure IoT Central deployment. |
   | Operating System | Windows |
   | Plan type | Consumption (Serverless) |

   :::image type="content" source="../media/5-azure-create-function-app.png" alt-text="Screenshot of the Azure portal Create Function App blade Basics tab.":::

1. Select **Create**.

   > [!NOTE]
   > Wait for the Azure Function app provisioning to complete. This might take up to two minutes.

1. Within the browser window displaying the Azure portal with the Azure Function app provisioning status blade, select **Go to resource**.
1. On the Azure Function app blade, select **Functions**, and then select **+ Create**.
1. On the **Create function** blade, select the **HTTP trigger** template entry, and then select **Create**. If prompted, accept the defaults for the HTTP trigger template.

   :::image type="content" source="../media/5-create-function-app-trigger.png" alt-text="Screenshot of the Azure portal Azure Function app Add function blade.":::

1. On the **HttpTrigger1** blade, in the vertical menu bar, select **Code + Test**.
1. On the **HttpTrigger1 \| Code + Test** blade, replace the existing code with the following content, and then select **Save** to save your changes:

   ```csharp
   #r "Newtonsoft.Json"

   using System.Net;
   using Microsoft.AspNetCore.Mvc;
   using Microsoft.Extensions.Primitives;
   using Newtonsoft.Json;

   public static async Task<IActionResult> Run(HttpRequest req, ILogger log)
   {
       log.LogInformation("C# HTTP trigger function processed a request.");

       string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
       dynamic data = JsonConvert.DeserializeObject(requestBody);

       string responseMessage = $"Payload: {data}. \nThis HTTP triggered function executed successfully."; 
       log.LogInformation(responseMessage);

       return new OkObjectResult(responseMessage);
   }
   ```

   > [!NOTE]
   > The function logs the payload of the HTTP request, which should represent the telemetry data forwarded to the function app's endpoint by the Azure IoT Central application you created in the previous exercise in this module.

1. On the **HttpTrigger1 \| Code + Test** blade, select **Get function URL**, and then record the value of the Azure function URL.
1. To test the newly created function, on the **HttpTrigger1 \| Code + Test** blade, select **Test/Run**. Select the **Input** tab, and then select **Run**.

   :::image type="content" source="../media/5-azure-function-app-function-test-run-input.png" alt-text="Screenshot of the Code + Test blade of the HttpTrigger1 blade with the Input tab selected.":::

1. To verify the results, on the **HttpTrigger1 \| Code + Test** blade, review the log pane and verify that the payload data matches the one displayed on the **Output** tab.

   :::image type="content" source="../media/5-azure-function-app-function-test-run-output.png" alt-text="Screenshot of the Code + Test blade of the HttpTrigger1 blade with the Output tab selected.":::

   > [!NOTE]
   > You might have to select **Run** the second time to generate the results in the log pane.

## Configure and validate IoT telemetry rules of an Azure IoT Central application

1. Start another web browser window and navigate to the [IoT Central my apps](https://apps.azureiotcentral.com/myapps) page.
1. If prompted, sign in to access the Azure subscription you used in the exercise unit **Set up Azure IoT Central**.
1. On the **My apps** page, select the **adatum-iot-custom-application** entry.
1. In the vertical menu, under **Extend**, select **Rules**.
1. On the **Rules** page, select **Create a rule** and configure the following settings:

   | Setting | Configuration |
   | --- | --- |
   | Rule name | Enter **Adatum IoT custom app testing rule**. |
   | Device template | Select **Raspberry Pi**. |
   | Time aggregation | Turn it **On** with the value of time interval set to **5 minutes**. |
   | Telemetry | Select **humidity**. |
   | Operator | Select **is greater than**. |
   | Aggregation | Select **Average**. |
   | Enter a value | Enter **30**. |
   | Action | Select **+ Webhook**. |
   | Display name | Enter **Azure function webhook**. |
   | Callback URL | Paste the value of the Azure function URL you recorded in the previous task of this exercise. |

   > [!NOTE]
   > The value of the humidity telemetry is intentionally artificially low, to invoke the webhook functionality and trigger the function. In real-life scenarios, you would adjust it to correspond to the condition that warrants raising an alert or taking a remediation action.

1. On the **Rules** page, select **Done**, and then select **Save**.
1. Switch to the browser window displaying the **Raspberry Pi Azure IoT Online Simulator** page you used in the previous exercise of this module. On this page, verify that the simulated device is sending messages to the Azure IoT Central application. If the simulator has stopped, select **Run** directly after the code pane.
1. Switch back to the web browser window displaying the **HttpTrigger1 \| Code + Test** blade in the Azure portal. In the vertical menu, select the **Monitor** entry, and on the **HttpTrigger1 \| Code + Test** blade, select the **Logs** tab.
1. Verify that the logs pane displays the messages generated in response to the HTTP trigger originating from the Azure IoT Central application webhook you configured earlier in this task.

## Create an Azure Storage account that stores IoT telemetry

1. Switch to the web browser window displaying the Azure portal.
1. In the Azure portal, use the **Search resources, services, and docs** text box to search for, and select **Storage accounts**.
1. On the **Storage accounts** blade, select **+ New** or **+ Create**.
1. On the **Basics** tab of the **Create storage account** blade, configure the following settings (leave others with their default values):

   | Setting | Configuration |
   | --- | --- |
   | Subscription | Select the name of the Azure subscription you'll be using in this module. |
   | Resource Group | Select **iot-central-apps-RG**. |
   | Storage account name | Enter a unique name that contains between 3 and 24 lowercase letters and digits and starts with a letter. |
   | Performance | Select **Standard**. |
   | Redundancy | Select **Locally-redundant storage (LRS)** |

   :::image type="content" source="../media/5-azure-storage-account-create.png" alt-text="Screenshot of the Azure portal, Create storage account blade, Basics tab.":::

1. On the **Basics** tab of the **Create storage account** blade, select **Review + create**, and then select **Create**.

   > [!NOTE]
   > Wait for the Azure storage account provisioning to complete. This might take about two minutes.

1. After provisioning is complete, select **Go to resource**.
1. On the Azure storage account blade, in the vertical menu, select **Containers**, and then select **+ Container**.
1. On the **New container** blade, in the **Name** text box, enter **iotcontainer**, leave the **Public access level** set to **Private (no anonymous access)**, and then select **Create**.

   :::image type="content" source="../media/5-azure-blob-container-create.png" alt-text="Screenshot of the Azure portal, New container blade.":::

1. On the Azure storage account blade, in the vertical menu, in the **Security + Networking** section, select **Access keys**. Select **Show keys**, and then record the value of the connection string corresponding to **key1**.

   :::image type="content" source="../media/5-azure-storage-account-keys.png" alt-text="Screenshot of the Azure portal, Access keys blade.":::

## Configure and validate data export of an Azure IoT Central application

1. Switch to the web browser window displaying the **adatum-iot-custom-application** page in the IoT Central Application portal.
1. In the IoT Central Application portal, on the **adatum-iot-custom-application** page, in the vertical menu, in the **Extend** section, select **Data export**, and then select **Add an export**.

   :::image type="content" source="../media/5-azure-iot-custom-application-export.png" alt-text="Screenshot of the  Azure IoT Central portal, Data export page.":::

1. On the **Create new export** page, configure the following settings:

   | Setting | Configuration |
   | --- | --- |
   | Export name | Enter **Adatum IoT custom app export**. |
   | Type of data to export | Select **Telemetry**. |
   | Destinations | Select **create a new one**. |
   | New destination name | Enter **Adatum Blob Storage**. |
   | Destination type | Select **Azure Blob Storage**. |
   | Connection string | Paste the value of the connection string you copied in the previous task of this exercise. |
   | Container | Enter **iotcontainer**. |

   :::image type="content" source="../media/5-azure-iot-create-new-destination.png" alt-text="Screenshot of the Azure IoT Central application export new destination settings.":::

1. Select **Create**, and then select **Save** on the **Create new export** page.
1. Switch to the browser window displaying the **Raspberry Pi Azure IoT Online Simulator** page you used earlier in this exercise. On this page, directly after the code pane, select **Run**, and verify that the simulated device is sending messages to the Azure IoT Central application.
1. Switch to the browser window displaying the Azure storage account blade in the Azure portal.
1. On the Azure storage account blade, in the vertical menu, select **Containers**.
1. In the list of containers, select the **iotcontainer** entry.
1. On the **iotcontainer** blade, verify the presence of a new folder with a GUID-based name.
   > [!NOTE]
   > If the folder is not present, wait for about a minute and select **Refresh**.

1. On the **iotcontainer** blade, select the newly generated folder and navigate through its subfolders until you reach a blob in any of its subfolders.
1. On the **iotcontainer** blade, select the blob you identified in the previous step. Within the blob blade, select the **Edit** tab to display its content.

   :::image type="content" source="../media/5-azure-storage-blob-content.png" alt-text="Screenshot of the content of a blob representing telemetry exported from the Azure IoT Central application.":::

1. Switch to the browser window displaying the **Raspberry Pi Azure IoT Online Simulator** page. On this page, directly after the code pane, select **Stop**, and verify that the simulated device no longer sends messages to the Azure IoT Central application.

## Results

Congratulations! You completed the second exercise of this module. In this exercise, you:

* Created an Azure function that logs an HTTP request payload.
* Configured and validated IoT telemetry rules of an Azure IoT Central application.
* Created an Azure Storage account that will store IoT telemetry.
* Configured and validated data export of an Azure IoT Central application.

## Clean up the resources

To avoid unnecessary charges from using Azure resources, you should delete the **iot-central-apps-RG** resource group you created at the beginning of this exercise. To do so, in the Azure portal, navigate to the **iot-central-apps-RG** blade, and select the **Delete resource group** entry in the toolbar. In the **TYPE THE RESOURCE GROUP NAME** textbox, enter **iot-central-apps-RG**, and then select **Delete**.
