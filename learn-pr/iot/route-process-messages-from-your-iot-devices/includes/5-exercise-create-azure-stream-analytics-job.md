In this exercise, you create an Azure Stream Analytics (ASA) job that outputs live stream messages to a Blob Storage container. You then use the Storage browser to verify that your job runs successfully.

Your Stream Analytics job processes message data to an output location using the following parameters:

* **Name** - vibrationJob
* **ASA job input** - IoT Hub messaging endpoint
* **ASA job output** - Blob Storage container
* **ASA job query** - pass through all messages from input to output

> [!NOTE]
> It may seem odd that in this lab you are using IoT Hub routing to deliver device data to a storage location, and then also processing your device message data through an Azure Stream Analytics job with output to the same storage location. In a real-world scenario you probably wouldn't use both of these message processing tools for processing device data in this way. Instead, it's more common to use an ASA job to invoke a time sensitive action based on analysis of real-time data. However, since this module is providing an introduction to both of these data processing tools, the Blob Storage container provides an easy way to validate that your IoT Hub route is working as expected and to show a simple implementation of Azure Stream Analytics.

### Task 1: Create the Stream Analytics job

1. On the Azure portal, navigate to the home page, then select **Create a resource**.

1. On the **Create a resource** blade, search for **Stream Analytics job**.

1. On the **Stream Analytics job** box, select **Create** > **Stream Analytics job**.

    The **New Stream Analytics job** pane is displayed.

1. In the **New Stream Analytics job** pane, fill in the following fields:

   | Parameter | Value |
   | --------- | ----- |
   | **Subscription** | Select the sandbox **Concierge Subscription**. |
   | **Resource group** | Select your Azure sandbox resource group, <rgn>[sandbox resource group name]</rgn>. |
   | **Name** | Enter **vibrationJob**. |
   | **Region** | Choose a region close to you. |
   | **Hosting environment** | Ensure that **Cloud** is selected. |
   | **Streaming units** | Ensure that **1** is selected. |

1. Select **Review + create**.

1. If validation checks pass, select **Create** to create your Stream Analytics job. Otherwise, fix any errors.

1. Wait for the **Your deployment is complete** message, and then select **Go to resource**.

    > [!TIP]
    > If you miss the message to go to the new resource, or need to find a resource at any time, navigate to your Azure portal home page, then select **See all** under Resources. Or, you can type in the resource you are searching for in the **Search Resources, services, and docs** box near the top of the blade. Enter enough of the resource name for it to appear in the list of resources.

### Task 2: Create the Stream Analytics job input

1. On your Stream Analytics job blade, on the left-side menu under **Job topology**, select **Inputs**.

    The **Inputs** pane is displayed.

1. On the **Inputs** pane, select **+ Add input**, and then select **IoT Hub**.

    The **IoT Hub - New input** pane is displayed.

1. On the **IoT Hub - New input** pane, fill in the following fields:

   | Parameter | Value |
   | --------- | ----- |
   | **Input alias** | Enter **vibrationInput**. |
   | **Select IoT Hub from your subscriptions** | Ensure that this option is selected. |
   | **Subscription** | Make sure the Concierge Subscription is selected. |
   | **IoT Hub** | Make sure your IoT hub is selected. |
   | **Consumer group** | **$Default** |
   | **Shared access policy name** | **iothubowner**<br><br>**Note**: The **Shared access policy key** is prepopulated and read-only. |
   | **Endpoint** | **Messaging** |
   | **Partition key** | Leave this field blank. |
   | **Event serialization format** | **JSON** |
   | **Encoding** | **UTF-8** |
   | **Event compression type** | **None** |

1. Select **Save**, and then wait for the input to be created.

    The **Inputs** list should be updated to show the new input.

### Task 3: Create the Stream Analytics job output

1. To create an output, on the left-side menu under **Job topology**, select **Outputs**.

    The **Outputs** pane is displayed.

1. On the **Outputs** pane, select **+ Add output**, then select **Blob storage/ADLS Gen2**.

    The **Blob storage/ADLS Gen2 - New output** pane is displayed.

1. On the **Blob storage/ADLS Gen2 - New output** pane, fill in the following fields:

   | Parameter | Value |
   | --------- | ----- |
   | **Output alias** | Enter **vibrationOutput**. |
   | **Select Blob storage/ADLS Gen2 from your subscriptions** | Ensure that this option is selected. |
   | **Subscription** | Select the Azure sandbox subscription. |
   | **Storage account** | Select the Storage account that you created. |
   | **Container** | Ensure that **Use existing** is selected, and select **vibrationcontainer** from the dropdown list. |
   | **Authentication Mode** | Select **Connection string**<br><br>**Note**: The **Storage account key** is displayed. |
   | **Path pattern** | Leave this field blank. |
   | **Event serialization format** | **JSON** |
   | **Format** | **Line separated**<br><br>**Note**: This setting stores each record as a JSON object on each line and, taken as a whole, results in a file that is an invalid JSON record. The other option, **Array**, ensures that the entire document is formatted as a JSON array where each record is an item in the array. This formatting allows the entire file to be parsed as valid JSON. |
   | **Encoding** | **UTF-8** |
   | **Write mode** | **Append, as results arrive** |
   | **Path pattern** | Leave this field blank. |
   | **Minimum rows** | Leave this field blank. |
   | **Maximum time** | Leave **Hours**, **Minutes**, **Seconds** blank. |

1. Select **Save**, and then wait for the output to be created.

    The **Outputs** list is updated with the new output.

### Task 4: Create the Stream Analytics job query

1. To edit the query, on the left-side menu under **Job topology**, select **Query**.

1. In the query editor pane, replace the existing query with the query below:

    ```sql
    SELECT
        *
    INTO
        vibrationOutput
    FROM
        vibrationInput
    ```

1. Directly above the query editor pane, select **Save query**.

1. On the left-side menu, select **Overview**.

### Task 5: Test the logging route

Now for the fun part. Is the telemetry from your device app being processed through your ASA job and delivered to the storage container?

1. Ensure that the device app you created in Visual Studio Code is still running.

    If not, run it in the Visual Studio Code terminal using **dotnet run**.

1. On the **Overview** pane of your Stream Analytics job, select **Start job**.

1. In the **Start job** pane, leave the **Job output start time** set to **Now**, and then select **Start**.

    It can take a few moments for the job to start.

1. On the Azure portal menu, select **Dashboard**.

1. From your Resources tile, navigate to your Storage account.

1. On the **Overview** pane of your Storage account, select the **Monitoring** tab.

1. Under **Key metrics**, next to **Show data for last**, change the time range to **1 hour**.

    You should see activity in the charts.

1. On the left-side menu, select **Storage browser**.

    You can use Storage browser for extra reassurance that all of your data is getting to the storage account.

1. In **Storage browser**, select **Blob containers**, and then select **vibrationcontainer**.

1. Select the json Blob block file.

1. On the page displaying file details for the json file, select **Download**.

1. Open the downloaded file in **Visual Studio Code**, and review the JSON data.

    The data in your json file should appear similar to the following output:

    ```json
    {"vibration":-0.025974767991863323,"EventProcessedUtcTime":"2021-10-22T22:03:10.8624609Z","PartitionId":3,"EventEnqueuedUtcTime":"2021-10-22T22:02:09.1180000Z","IoTHub":{"MessageId":null,"CorrelationId":null,"ConnectionDeviceId":"sensor-v-3000","ConnectionDeviceGenerationId":"637705296662649188","EnqueuedTime":"2021-10-22T22:02:08.7900000Z"}}
    {"vibration":-2.6574811793183173,"EventProcessedUtcTime":"2021-10-22T22:03:10.9718423Z","PartitionId":3,"EventEnqueuedUtcTime":"2021-10-22T22:02:11.1030000Z","IoTHub":{"MessageId":null,"CorrelationId":null,"ConnectionDeviceId":"sensor-v-3000","ConnectionDeviceGenerationId":"637705296662649188","EnqueuedTime":"2021-10-22T22:02:11.0720000Z"}}
    {"vibration":3.9654399589335796,"EventProcessedUtcTime":"2021-10-22T22:03:10.9718423Z","PartitionId":3,"EventEnqueuedUtcTime":"2021-10-22T22:02:13.3060000Z","IoTHub":{"MessageId":null,"CorrelationId":null,"ConnectionDeviceId":"sensor-v-3000","ConnectionDeviceGenerationId":"637705296662649188","EnqueuedTime":"2021-10-22T22:02:13.1500000Z"}}
    {"vibration":0.99447803871677132,"EventProcessedUtcTime":"2021-10-22T22:03:10.9718423Z","PartitionId":3,"EventEnqueuedUtcTime":"2021-10-22T22:02:15.2910000Z","IoTHub":{"MessageId":null,"CorrelationId":null,"ConnectionDeviceId":"sensor-v-3000","ConnectionDeviceGenerationId":"637705296662649188","EnqueuedTime":"2021-10-22T22:02:15.2120000Z"}}
    ```

1. In Visual Studio Code, close the document containing your json data.

1. Return to your Azure portal window and navigate to your Dashboard.

1. On your Resources tile, select **vibrationJob**.

1. On the **vibrationJob** blade, select **Stop job**, and then select **Yes**.

1. Switch to the Visual Studio Code window.

1. At the Terminal command prompt, to exit the device simulator app, press **CTRL-C**.

## Verify your work

In this exercise, you performed the following steps:

1. Create the Stream Analytics job
1. Create the Stream Analytics job input
1. Create the Stream Analytics job output
1. Create the Stream Analytics job query
1. Test the logging route

You've traced the message data processes from the device app, to the IoT hub, and then through both an IoT hub route and Azure Stream Analytics job all the way to a Blob Storage container. Great progress!
