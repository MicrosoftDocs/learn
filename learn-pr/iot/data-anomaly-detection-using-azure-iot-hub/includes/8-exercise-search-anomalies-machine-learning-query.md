In this exercise, we're going to add a query to the Stream Analytics job, and then use Microsoft Power BI to visualize the output from the query. The query searches for spikes and dips in the vibration data, reporting anomalies. We must create the second route, after creating an instance of Event Hubs.

## Create an Event Hubs namespace

1. Create a new resource. Search for "Event Hubs", and select it.

    ![Screenshot showing the button to create Event Hubs](../media/vibration-create-event-hubs.png)

1. For **Name**, enter "vibrationNamespace". Pricing tier can be any selection, as notice the **Subscription** entries are from the free sandbox resources.  **Throughput Units** can be set to **1**.

    ![Screenshot showing the button to create Event Hubs](../media/vibration-create-namespace.png)

1. Click **Create**, and wait for the resource to be available.

### Create an Event Hubs instance

1. In your Azure home page, search for the namespace you created in **All resources**.

1. Select the namespace, and click **+ Event Hub**. We need to create an instance of the namespace.

    ![Screenshot showing the button to create Event Hubs](../media/vibration-add-event-hub.png)

1. In the **Create Event Hub** page, enter "vibrationeventhubinstance" for the **Name**. Leave the other fields at their defaults, and click **Create**.

    ![Screenshot showing the fields required to create an Event Hub instance](../media/vibration-create-event-hub-instance.png)

1. Wait for the resource to be deployed. When this happens, we can start to build the route itself.

## Create a route to an Event Hub

1. Locate the **VibrationSensorHub** overview page.

1. Select **Message routing** from the left-hand menu, then **+ Add**, to add a route.

1. Name the route "vibrationTelemetryRoute", then click **+ Add endpoint**. This time. select **Event Hubs** for the type of endpoint.

1. Enter "vibrationTelemetryEndpoint", for the **Endpoint name**.

1. For **Event hub namespace**, choose your entry from the previous section, **vibrationNamespace**.

1. For the instance, locate your **vibrationeventhubinstance**.

    ![Screenshot showing the completed fields for an Event Hub endpoint](../media/vibration-event-hub-endpoint.png)

1. Click **Create**, and wait for the success message.

1. You should now be back in the **Add a route** window. Remember that "VSTel" is a string we used in the device app. Change the **Routing query** to the following.

    ```sql
    sensorID = "VSTel"
    ```

1. Verify that your two message routes look like the following image.

    ![Screenshot showing the summary of the settings for the two message routes](../media/vibration-two-routes.png)

With this new route in place, now we need to update our Stream Analytics job.

## Add a new input to the Azure Stream Analytics job

1. In your Azure portal, select **vibrationJob** from your list of resources.

1. Select the **Inputs** section, and click **+ Add stream input**, selecting **Event Hub**.

1. In the **Input details** box, enter "vibrationEventInput" as the **Input alias**. Ensure **Select Event Hub from your subscriptions** is selected, as is your working subscription.

1. In **Event Hub namespace**, select the namespace you entered in the previous section. And select the instance you created for **Event Hub name**. You can leave the other fields at their default values.

1. Click **Save**.

## Add a new output to the Azure Stream Analytics job

1. In the breadcrumbs, go back to your job. You should now see two inputs. Select the icon to add an output.

1. Click **+ Add**, then select **Power BI**.

    ![Screenshot showing the Power BI selection, for a new output.](../media/vibration-hub-new-output.png)

1. Authorize the connection. You might need to sign up for a free Microsoft account, if you don't have one already.

1. Complete the **Power BI** entry. For **Output alias** enter "vibrationBI". For **Group workspace**, search for **My workspace**.

1. For **Dataset name** enter "vibrationDataset". For **Table name**, enter "vibrationTable". 

1. For **Authentication mode**, ensure **User token** is selected.

    ![Screenshot showing the completed fields of a Power BI output](../media/vibration-hub-new-bi.png)

1. Click **Save**.

1. Again, navigate using the breadcrumbs back to the job.

## Add a query to the Azure Stream Analytics job

1. Select **Edit query**, to the right of the window.

1. Copy and paste the following SQL query, before the existing short query.

   ```sql
    WITH AnomalyDetectionStep AS
    (
        SELECT
            EVENTENQUEUEDUTCTIME AS time,
            CAST(vibration AS float) AS vibe,
            AnomalyDetection_SpikeAndDip(CAST(vibration AS float), 95, 120, 'spikesanddips')
                OVER(LIMIT DURATION(second, 120)) AS SpikeAndDipScores
        FROM vibrationEventInput
    )
    SELECT
        time,
        vibe,
        CAST(GetRecordPropertyValue(SpikeAndDipScores, 'Score') AS float) AS
        SpikeAndDipScore,
        CAST(GetRecordPropertyValue(SpikeAndDipScores, 'IsAnomaly') AS bigint) AS
        IsSpikeAndDipAnomaly
    INTO vibrationBI
    FROM AnomalyDetectionStep
   ```

    > [!NOTE]
    > This first section of this query takes the vibration data, and examines the previous 120 seconds worth. The `AnomalyDetection_SpikeAndDip` function will return a `Score` parameter, and an `IsAnomaly` parameter. The score is how certain the machine learning algorithm is that the given value is an anomaly, given as a percentage. If the score exceeds 95%, the `IsAnomaly` parameter has a value of 1, otherwise `IsAnomaly` has a value of 0. Notice the 120 and 95 parameters in the first section of the query.
    The second section of the query sends the time, vibration, and anomaly parameters to `vibrationBI`.

1. Carefully verify you've used the same names in the SQL query, as you've in the **Inputs** and **Outputs**.

    ![Screenshot showing the new SQL query, and the inputs and outputs to the query](../media/vibration-two-query.png)

1. Save the query.

1. If all looks good, start the job again.

In order for a human operator to make much sense of the output from this query, we need to visualize the data in a friendly way. One way of doing this visualization is to create a Power BI dashboard.

## Create a Microsoft Power BI dashboard

1. In your browser, navigate to `outlook.office365.com`. This URL will take you to the mail inbox. You may have to enter your Microsoft Account login information.

1. Use the nine dots icon (top left) to display a drop-down list. Select **All apps**. Scroll down and select **Power BI**.

    ![Screenshot showing the selection of Power BI from the Office 365 portal](../media/vibration-outlook-power-bi.png)

1. Open **My workspace**.

1. Under **Datasets** verify that **vibrationDataset** is displayed. If not, you might have to wait a short time for this list to populate.

1. Select **+ Create** (top right), and select **Dashboard** from the drop-down list.

1. Give the dashboard a friendly name, say "Vibration dash".

1. In the blank screen that follows, click **Add tile**. Select **Custom Streaming Data**, **Next**, and select the **vibrationDataset** from the list of datasets.

    ![Screenshot showing the options when adding a dashboard tile](../media/vibration-dashboard-add-tile.png)

1. For the first card, select **Visualization Type** as **Gauge**, **Value** as **vibe**. Enter "Vibration" for the title (in the **Tile details** box).

1. Click **Apply**.

1. Use the bottom-right corner icon on the tile to shrink it to the smallest allowable size.

1. Repeat the process for a second tile. This time with **Clustered bar chart** as the **Visualization Type**, and **SpikeAndDipScore** as the **Value**. No need to add a title, click **Apply**.

1. Again, shrink this tile to the smallest possible.

1. Create a third tile. This time with **Card** as the **Visualization Type**, and **IsSpikeAndDipAnomaly** under **Fields**. Again, click **Apply**, and shrink the tile.

1. Now create a fourth tile, this time a bit more complex. Select **Line chart** for the **Visualization Type**, and **time** for the **Axis**. Under **Values**, select **IsSpikeAndDipAnomaly**. For the time window, select the last 60 minutes. Enter "Anomalies over the hour" for the tile title. Click **Apply**.

1. This time, expand the tile to a size three times larger than the smallest tiles, and arrange your dashboard similar to the following image:

    ![Screenshot showing the completed Power BI dashboard identifying anomalies](../media/vibration-anomalies-detected.png)

1. There's a latency with so many routes and connections, but are you now seeing the vibration data coming through?

1. Let the job run for a while, several minutes at least before the machine learning will kick in. Compare the console output of the device app, with the Power BI dashboard. Are you able to correlate the forced and increasing vibrations to a run of anomaly detections?

If you're seeing an active Power BI dashboard, similar to the one above, you've just about completed this module. Great work.

Finish the module off with a short knowledge check.
