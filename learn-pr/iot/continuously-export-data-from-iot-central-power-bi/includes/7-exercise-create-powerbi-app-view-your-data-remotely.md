
In this exercise, we're going to create a Stream Analytics job, and then use Power BI to visualize the output from the query. We first create an instance of an Event Hubs namespace.

## Create an Event Hubs namespace

1. In the Azure portal, create a new resource. Search for "Event Hubs", and select it.

1. For **Name**, enter "continuousnamespace". Pricing tier can be the recommended selection, as notice the **Subscription** entries are from the free sandbox resources.  **Throughput Units** can be set to **1**.

1. Click **Create**, and wait for the resource to be deployed. This process can take a few minutes.

1. Now, you need to save off the connection string for the namespace. Click on **Shared access policies** in the left menu, open up the **RootManagedSharedAccessKey**, and copy the **Connection string-primary key** to your text file, noting it is the connection string for the Event Hub namespace.

### Create an Event Hubs instance

1. Locate your Event Hub namespace resource. If you do not already have it open, navigate to your Azure home page, search recent resources, or **All resources**, for the namespace.

1. Select the namespace, and click **+ Event Hub**. We need to create an instance of this namespace.

1. In the **Create Event Hub** page, enter "continuouseventhub" for the **Name**. Leave the other fields at their defaults, and click **Create**.

    [![Screenshot showing the fields required to create an Event Hub instance](../media/continuous-data-create-event-hub-instance.png)](../media/continuous-data-create-event-hub-instance.png#lightbox)

1. Wait for the resource to be deployed.

### Set continuous data export to the Event Hub

1. Locate the home page for your IoT Central **Refrigerated Truck** app.

1. Click **Data export**, in the left menu.

1. Click **+ New**, and select **Azure Event Hubs**.

1. In the **Create data export** page, leave the **Display name** as **Export to Event Hubs 1**.

1. Enter the connection string for the Event Hubs namespace, that you saved off in the previous section.

     [![Screenshot showing the creation of a data export to an event hub](../media/continuous-data-create-data-export-event-hub.png)](../media/continuous-data-create-data-export-event-hub.png#lightbox)

1. Leave the other entries at their default values, and click **Save**.

1. Wait for the **Status** of the data export to change to **Running**.

## Create an Azure Stream Analytics job

Navigate to the home page for Azure.

1. In the Azure portal **Home** page, select **Create a resource**. Search for and select **Stream Analytics job**. Click **Create**.

    [![Screenshot showing the new job creation button](../media/continuous-data-new-job-create.png)](../media/continuous-data-new-job-create.png#lightbox)

1. Enter "continuousJob" for the name. Select the sandbox **Concierge subscription**, and **learn-** resource group.

1. Select the location nearest to you.

1. Reduce the number of **Streaming units** from 3 to 1. No need to have more capability than you need.

1. Click **Create**. Wait for the **Deployment succeeded** message. Open the new resource.

    > [!TIP]
    > If you miss the message to go to the new resource, or need to find a resource at any time, navigate to **Home/All resources**. Enter enough of the resource name for it to appear in the list of resources.

1. You'll now see the empty job, no inputs or outputs, and a skeleton query. The next step is to populate these entries. Click on **Inputs**.

1. Click **+ Add stream input**, and select **Event Hub** from the drop-down list.

1. On the right-hand side of the window, enter "continuousInput" for the **Input alias**.

1. Ensure **Select Event Hub from your subscriptions** is selected.

1. For **Event Hub namespace**, select **continuousnamespace**. Ensure **Use existing** is selected for **Event Hub name**. Select **continuouseventhub**. No need to change the other fields from their defaults.

1. Click **Save**.

1. Select your job again, easily done from the breadcrumb trail, top left. You should now see your job has an input. Select **Outputs**.

1. Select **Add**, to add an output, then **Power BI** from the drop-down list.

1. You will probably be asked to **Authorize** the connection, so do so now.

1. For **Output alias**, enter "continuousBI".

1. For **Group workspace**, select **My workspace** if it is available, otherwise, select one of the listed workspaces, and record the workspace name in your text file.

1. For **Dataset name**, enter **continuousDataset**.

1. For **Table name**, enter **continuousTable**.

1. Change **Authentication mode** to **User token**.

1. No need to change any of the other fields, so click **Save**.

1. Use the breadcrumbs to select your job.

1. Click **Edit query**, and change the query to:

    ```sql
    SELECT
        *
    INTO
        continuousBI
    FROM
        continuousInput
    ```

1. Click **Save query**, and return to your job.

    [![Screenshot showing the completed SQL logging query](../media/continuous-data-job-overview.png)](../media/continuous-data-job-overview.png#lightbox)

## Create a dashboard to visualize the query, using Power BI

1. In your browser, navigate to **outlook.office365.com**. This URL will take you to the mail inbox. You may have to enter your Microsoft Account login information.

1. Use the nine dots icon, top left, to display a drop-down list. Select **All apps**. Scroll down and select **Power BI**.

    [![Screenshot showing the selection of Power BI from the Office 365 portal](../media/continuous-outlook-power-bi.png)](../media/continuous-outlook-power-bi.png#lightbox)

1. Open the workspace that you created the dataset in. This might be **My workspace**, or another one you selected in the previous section, and stored into your text file.

1. Under **Datasets** verify that **continuousDataset** is displayed. If not, you might have to wait a short time for this list to populate.

1. Select **+ Create**, top right, and select **Dashboard** from the drop-down list.

1. Give the dashboard a friendly name, say "Continuous dash".

1. In the blank screen that follows, click **Add tile**. Select **Custom Streaming Data**, **Next**, and select the **continuousDataset** from the list of datasets.

    [![Screenshot showing the selection of the Power BI dataset, for a tile](../media/continuous-power-bi-dataset.png)](../media/continuous-power-bi-dataset.png#lightbox)

1. For the first card, select **Visualization Type** as **Gauge**, **Value** as **Contents Temperature**. Click **Next**, then enter "Contents temperature" for the title, in the **Tile details** box.

1. Click **Apply**.

1. Use the bottom-right corner icon on the tile to shrink it to the smallest allowable size.

1. Repeat the process, with the same dataset and tile source, for a second tile. This time with **Line chart** as the **Visualization Type**. Select **EventProcessedUtcTime** as the **Axis**, and for **Values**, select **Contents Temperature** again. No need to add a title, click **Next**, then **Apply**.

    [![Screenshot showing the creation of a line chart tile](../media/continuous-power-bi-utc-tile.png)](../media/continuous-power-bi-utc-tile.png#lightbox)

1. Now, top right of your screen, change **Web view** to **Phone view**.

1. There's a latency with so many routes and connections, so you might have to wait a minute. Are you now seeing the continuous data coming through? Is the temperature changing? Is the line chart scrolling left?

1. Let the job run for a while, with the console output of the device app in view. Are you able to correlate the contents temperatures from the app, shown in the console window, matches the gauge in Power BI?

    [![Image of a Power BI dashboard on a mobile phone](../media/continuous-data-phone-view-2.png)](../media/continuous-data-phone-view-2.png#lightbox)

If you're seeing an active Power BI dashboard, similar to the one above, you've about completed this module. Great work.

Finish the module off with a knowledge check.
