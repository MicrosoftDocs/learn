
In this exercise we are going to add a query to the Stream Analytics job, and then use Microsoft Power Bi to visualize the output from the query. The query searches for spikes and dips in the vibration data, reporting anomalies.

## Add a query to the Azure Stream Analytics job

1. In your Azure portal, select **vibrationJob** from your list of resources.

1. The **Overview** page for the job includes the **Query**. Select **Edit query**, to the right of the window.

1. Add to the existing contents of the query.

1. Copy and paste the following SQL query, before the existing short query.

   ```sql
    WITH AnomalyDetectionStep AS
    (
        SELECT
            EVENTENQUEUEDUTCTIME AS time,
            CAST(vibration AS float) AS vibe,
            AnomalyDetection_SpikeAndDip(CAST(vibration AS float), 95, 120, 'spikesanddips')
                OVER(LIMIT DURATION(second, 120)) AS SpikeAndDipScores
        FROM vibrationInput
    )
    SELECT
        time,
        vibe,
        CAST(GetRecordPropertyValue(SpikeAndDipScores, 'Score') AS float) AS
        SpikeAndDipScore,
        CAST(GetRecordPropertyValue(SpikeAndDipScores, 'IsAnomaly') AS bigint) AS
        IsSpikeAndDipAnomaly
    INTO vibrationOutput
    FROM AnomalyDetectionStep
   ```

    > [!NOTE]
    > This first section of this query takes the vibration data, and examines the previous 120 seconds worth. The `AnomalyDetection_SpikeAndDip` function will return a `Score` parameter, and an `IsAnomaly` parameter. The score is how certain the machine learning algorithm is that the given value is an anomaly, given as a percentage. If the score exceeds 95% certainty, the `IsAnomaly` parameter has a value of 1, otherwise the parameter has a value of 0. Notice the 120 and 95 parameters in the first section of the query.
    The second section of the query sends the time, vibration, and anomaly parameters to `vibrationOutput`.

1. Save the query.

1. Start the job again.

In order for a human operator to make much sense of the output from this query, we need to visualize the data in a friendly way. One way of doing this is to create a Power BI dashboard.

## Create a Microsoft Power BI dashboard

1. In your browser, navigate to `outlook.office365.com`. This will take you to the mail inbox.

1. Use the nine dots icon (top left) to display a drop-down list. Select **All apps**. Scroll down and select **Power BI**.

1. Open **My workspace**.

1. Under **Datasets** verify that **vibrationBI** is displayed. If not, you might have to wait a short time for this to populate.

1. Select **+ Create** (top right), and select **Dashboard** from the drop-down list.

1. Give the dashboard a friendly name, say "vibration dash".

1. In the blank screen that follows, click **Add tile**. Select **Custom Streaming Data**, **Next**, and select the **vibrationBI** from the list of Datasets.

1. For the first card, select **Visualization Type** as **Gauge**, **Value** as **vibe**, and enter "Vibration" for the title (in the **Tile details** box).

1. Click **Apply**.

1. Use the bottom right corner icon on the tile to shrink it to the smallest allowable size.

1. Repeat the process for a second tile. This time with **Clustered bar chart** as the **Visualization Type**, and **SpikeAndDipScore** as the **Value**. No need to add a title, click **Apply**.

1. Again, shrink this tile to the smallest possible.

1. Create a third tile. This time with **Card** as the **Visualization Type**, and **IsSpikeAndDipAnomaly** under **Fields**. Again, click **Apply**, and shrink the tile.

1. Now create a fourth tile, this time a bit more complex. Select **Line chart** for the **Visualization Type**, and **time** for the **Axis**. Under **Values**, select **IsSpikeAndDipAnomaly**. For the time window, select the last 60 minutes. Enter "Anomalies over the hour" for the tile title. Click **Apply**.

1. This time expand the tile to a size three times larger than the smallest tiles, and arrange your dashboard similar to the following image:

    ![Screenshot showing the temperature and humidity telemetry being sent](../media/vibration-anomalies-detected.png)

1. There is a latency with so many routes and connections, but are you now seeing the vibration data coming through?

1. Let the job run for a while, several minutes at least before the machine learning will kick in. Compare the console output of the device app, with the Power BI dashboard. Are you able to correlate the forced and increasing vibrations to a run of anomaly detections?

If you are seeing an active Power BI dashboard, similar to the one above, you have just about completed this module. Good work. Finish the module off with a short knowledge check.