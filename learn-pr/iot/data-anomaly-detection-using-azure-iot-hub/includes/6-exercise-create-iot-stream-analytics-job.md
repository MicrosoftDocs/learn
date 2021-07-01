
In this unit, we'll create and test the logging route.

## Route the logging message to Azure storage

1. In the Azure portal, ensure the **Overview** pane for the **VibrationSensorHub** is open.

1. In the left menu pane, under **Messaging**, select **Message routing**.

1. Select **Add** to add the first route. The **Add a route** pane appears.

1. In the **Name** field, enter *VibrationLoggingRoute*.

1. At the end of the **Endpoint** field, select **Add endpoint**, and then select **Storage** from the dropdown list. The **Add a storage endpoint** pane appears.

1. In the **Endpoint name** field, enter a descriptive name, such as *VibrationLogEndpoint*.

1. In the **Azure Storage account and container** section, select the **Pick a container** box. The **Storage accounts** pane appears.

1. First, we need to create the storage account to contain the container. In the top menu bar, **Storage account**. The **Create storage account** pane appears.

1. In the **Name** field, enter a name for your storage account, for example *vibrationstorage*. This field can only contain lower-case letters and numbers.

1. Change the **Location** field to the location nearest you, and leave the other fields with their default values.

    [![Screenshot showing the completed fields for a new storage account.](../media/vibration-storage-account.png)](../media/vibration-storage-account.png#lightbox)

1. Select **OK**. Wait until the resource is validated. Validation can take a few minutes.

1. In the **Storage accounts** pane that appears, search for *vibrationstorage*, and select it. The **Containers** pane appears.

1. Select **Container**. The **New container** pane appears.

1. In the **Name** field, enter a name such as *vibrationcontainer* (again, only lower-case letters and numbers are accepted).

1. Leave the **Public access level** as *Private*, and select **Create**. The **Containers** pane reappears listing your container.

1. Highlight the container in the list, and select **Select**. The **Add a storage endpoint** pane reappears.

1. Note the URL under the **Azure Storage container** title.

1. Leave the other fields with their default values, and select **Create**.

    [![Screenshot showing the completed fields for a new endpoint.](../media/vibration-storage-endpoint.png)](../media/vibration-storage-endpoint.png#lightbox)

    The **Add a route** pane appears.

1. Under **Data source**, leave the **Device Telemetry Messages** parameter as is, as that is exactly what we want.

1. You've nearly finished the logging route. One last step, change the **Routing query** from **true** to the following.

    ```sql
    sensorID = "VSLog"
    ```

    This query is an important step to determine which messages will follow this route.

1. Select **Save**. Wait for the **Success** message to appear on the **Message routing** pane.

1. Verify that your route has the following settings.

    [![Screenshot showing the summary of the logging route settings.](../media/vibration-logging-route.png)](../media/vibration-logging-route.png#lightbox)

Before creating the second route, let's verify that the logging route is working. This step requires creating the Stream Analytics job.

## Create an Azure Stream Analytics job

1. In the Azure portal **Home** page, select **Create a resource**. Search for and select **Stream Analytics job**, and press <kbd>Enter</kbd>. The **Stream Analytics job** pane appears.

1. Click **Create**.

    [![Screenshot showing the new job creation button.](../media/vibration-hub-new-job-create.png)](../media/vibration-hub-new-job-create.png#lightbox)

    The **New Stream Analytics job** pane appears.

1. Enter the following values for each field.

    | Field | Value  |
    |---------|---------|
    | Job name | vibrationJob |
    | Subscription  | Concierge Subscription or one of the subscriptions available to you  |
    | Resource group  | <rgn>[sandbox resource group name]</rgn> or select **Create new**, and enter a name for your resource group |
    | Location | Select the location nearest to you |
    | Streaming units | Reduce the number of streaming units from 3 to 1. No need to have more capability than we need. |

    [![Screenshot showing the completed fields of the job.](../media/vibration-stream-job.png)](../media/vibration-stream-job.png#lightbox)

1. Select **Create**.

1. Wait for the **Deployment succeeded** message, and then select **Go to resource**.

    > [!TIP]
    > If you miss the message to go to the new resource, or need to find a resource at any time, select **Home/All resources**. Enter enough of the resource name for it to appear in the list of resources.

    You'll now see the empty job, no inputs or outputs, and a skeleton query. The next step is to populate these entries.

1. Select **Inputs**. The **Inputs** pane appears.

1. Select **Add stream input**, and then select **IoT Hub** from the dropdown list. The **Input details** pane appears.

1. Enter the following values for each field.

    | Field | Value  |
    |---------|---------|
    | Input alias | Enter *vibrationInput* |
    | Select IoT Hub from your subscriptions  | Ensure it is selected  |
    | IoT Hub  | From the dropdown list, select **VibrationSensorHub** |
    | Endpoint | Ensure **Messaging** is selected |
    | Shared access policy name | Ensure **iothubowner** appears.  |

    Leave the other fields with their default values.

    [![Screenshot showing the completed fields of the new stream input.](../media/vibration-log-stream-input.png)](../media/vibration-log-stream-input.png#lightbox)

1. Select **Save**.

1. Select your job again, which is easily done from the path on the top left of the pane. You should now see your job has an input.

1. Select **Outputs**.

1. To add an output, select **Add**, and then select **Blob storage/Data Lake** from the dropdown list.

1. Enter the following values for each field.

    | Field | Value  |
    |---------|---------|
    | Output alias | Enter *vibrationOutput* |
    | Select storage from your subscriptions  | Ensure it is selected  |
    | Storage account  | From the dropdown list, select **Vibrationstorage** |
    | Container| Select **vibrationcontainer** - the container you created in the previous section  |

1. Leave the other fields with their default values, and select **Save**.

1. On the top left of the pane, use the path to select your job.

1. Select **Edit query**, and change it to:

    ```sql
    SELECT
        *
    INTO
        vibrationOutput
    FROM
        vibrationInput
    ```

1. Select **Save query**, and return to your job.

    [![Screenshot showing the completed SQL logging query.](../media/vibration-stream-query.png)](../media/vibration-stream-query.png#lightbox)

## Test the logging route

Now for the fun part. Does the telemetry your device app is pumping out work its way along the route, and into the storage container?

1. Ensure your device app is running.

1. In the **vibrationJob** pane, select **Start**.

1. In the **Start job** box, select **Start**.

    [![Screenshot showing the job start button.](../media/vibration-job-start.png)](../media/vibration-job-start.png#lightbox)

1. Select **Home** in the Azure portal. If the **vibrationstorage** resource isn't available in the **Recent resources** list, search for it under **All resources**.

1. Select **vibrationstorage**. Change the time range to **1 hour**. You should see activity in the charts.

1. For added reassurance that all the data is getting to the account, select **Storage Explorer**. Under **BLOB CONTAINERS**, select **vibrationcontainer**.

    > [!NOTE]
    > The Storage Explorer is currently in preview mode, so its exact mode of operation may change.

1. You'll need to navigate down a number of folder style entries, that create dates and times. You should eventually see a text screen of all the telemetry data.

    [![Screenshot showing the storage explorer log of entries.](../media/vibration-storage-explorer.png)](../media/vibration-storage-explorer.png#lightbox)

1. Return back to your job home page, and select **Stop** to end the job for now.

You've traced the activity from the device app, to the hub, down the route, and to the storage container. Great progress!

Now, we need to add the second route, sending the telemetry data to an updated Azure Stream Analytics query.
