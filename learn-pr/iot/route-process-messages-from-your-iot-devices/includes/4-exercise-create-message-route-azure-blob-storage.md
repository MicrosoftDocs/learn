IoT solutions often require that incoming message data be sent to multiple endpoint locations, dependent upon either the type of data or for business reasons. Azure IoT Hub provides the _message routing_ feature to enable you to direct incoming data to locations required by your solution.

The prototype architecture requires that data be processed in two ways:
* routed to a storage location for archiving data
* streamed in real-time for immediate analysis

The prototype vibration monitoring scenario requires the following message processes:

* An IoT Hub route that delivers message data to an Azure Blob Storage location for data archiving
* An Azure Stream Analytics job for real-time analysis

First, we work on the logging route that sends data to Azure Blob Storage.

One important feature of message routing is the ability to filter incoming data before routing to an endpoint. The filter, written as a SQL query, directs output through a route only when certain conditions are met.

One of the easiest ways to filter data is to evaluate a message property. The code in your simulated device app configures the device-to-cloud messages with **sensorID** properties as shown in the following lines taken from the `CreateTelemetryMessage` and `CreateLoggingMessage` methods:

```csharp
...
telemetryMessage.Properties.Add("sensorID", "VSTel");
...
loggingMessage.Properties.Add("sensorID", "VSLog");
```

With the messages tagged in this way, you can embed a SQL query within your IoT hub message route that uses the **sensorID** property as a criteria for choosing the messages that are processed by the route. In this case, when the value assigned to **sensorID** is **VSLog** (vibration sensor log), the message is intended for the storage archive (logging).

In this exercise, you create and test the logging route.

## Task 1: Define the message routing endpoint

In the Azure portal, all the steps for creating a new logging route are combined in a multi-step walkthrough. In this section, you:

* Create a storage endpoint destination for messages in your route.
* Create a storage account and container.
* Create a route to the storage endpoint.

To create the storage endpoint:

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) window, ensure that your IoT Hub menu is open.

1. On the left-hand menu, under **Hub settings**, select **Message routing**.

1. In the **Message routing** pane, ensure that the **Routes** tab is selected.

1. Select **+ Add** to add a new route.

1. In the **Add a route** window, the first step is to create an endpoint:

   1. Fill in the following endpoint fields:

      | Property | Value |
      | ----- | ----- |
      | **Endpoint type** | Select **Storage** from the drop-down list. |
      | **Endpoint name** | Enter **vibrationLogEndpoint**. |

   1. Select **Pick a container** to choose the storage container that receives the log messages.

   1. On the **Storage accounts** window, select **+ Storage account** to create a storage account.

   1. Fill in the **Name** field with a name for your storage account. This name must be globally unique, only lowercase letters and numbers, and a length between 3 and 24 characters.

   1. Select the **Location** closest to your geographical location.

   1. Select **OK**.

   1. Once your storage account is created, select it from the list of storage accounts. You might have to select **Refresh** to update the list.

   1. In the **Containers** window, select **+ Container** to create a storage container.

   1. Name your storage container **vibrationcontainer**.

   1. Select **Create**.

   1. Once your container is created, choose **vibrationcontainer** from your list of containers, then select **Select**.

      You should be returned to the **Add a route** window. Notice that the **Azure storage container** is set to the URL for the storage account and container that you created.

   1. Take a moment to review the default selections for the rest of the fields.

      * Under **Encoding**, notice that there are two options and that **AVRO** is selected. By default, IoT Hub writes the content in Avro format, which has both a message body property and a message property. The Avro format is not used for any other endpoints. Although the Avro format is great for data and message preservation, it's a challenge to use it to query data. In comparison, JSON or CSV format is easier for querying data. IoT Hub now supports writing data to Blob Storage in JSON and AVRO.

      * The **File name format** field specifies the pattern used to write the data to files in storage. The various tokens are replaced with values as the file is created.

   1. Select **Create + next** to create your storage endpoint.

1. Once your endpoint is created, the second step is to create a route:

   1. Fill in the following route fields:

      | Property | Value |
      | -------- | ----- |
      | **Name** | Enter **vibrationLoggingRoute**. |
      | **Data source** | Ensure that **Device Telemetry Message** is selected. |
      | **Routing query** | Replace the default query with `sensorID = 'VSLog'`. This query ensures that only messages with the **sensorID** application property set to **VSLog** are routed to the storage endpoint. |

   1. Select **Create + skip enrichments**.

      > [!NOTE]
      > Message enrichments allow you to add information to incoming messages before they are routed to their designated endpoint. It's a useful feature that can simplify downstream processing, but we're not going to use it in this scenario.

1. Once you see your new route listed on the **Routes** tab, navigate back to your Azure portal Dashboard.

## Task 2: Verify data archival

1. Ensure that the device app you created in Visual Studio Code is still running.

   If not, run it in the Visual Studio Code terminal using **dotnet run**.

1. In the **Resources** section of your Azure portal homepage, navigate to the Storage account that you created in the previous section. If your **Resources** section does not list your Storage account, select **Resource groups** and then select the resource group for this sandbox, <rgn>[sandbox resource group name]</rgn>. Your Storage account should be listed as a resource in this group.

1. In the navigation menu of your Storage account, select **Storage browser**.

    You can use the Storage browser to verify that your data is being added to the storage account.

1. In the **Storage browser** pane, select **Blob containers** and then select **vibrationcontainer**.

    To view the logged data, you need to navigate down a hierarchy of folders. The first folder is named for the IoT hub.

    > [!NOTE]
    > If no data is displayed, click **Refresh**. You may need to wait a minute or two and then refresh again.

1. In the right-hand pane, select the name of your IoT hub, and then navigate down into the folder hierarchy.

    Under your IoT hub folder, you see folders for the partition, then numeric values for the year, month, and day. The final folder represents the hour, listed in UTC time. The hour folder contains block blobs that contain your logging message data.

1. Locate the block blob for the data with the earliest time stamp.

    The .avro files use a naming pattern of **{num}.avro** (for example, **22.avro**).

1. Select **...** next to the block blob with the earliest time stamp, then select **Download** from the Context menu.

   <!-- TODO: Can you not view the file contents in Storage browser? Is downloading necessary?-->

1. Open **File Explorer** and navigate to your **Downloads** folder.

1. Right-click the .avro file, then select **Open with**, then select **Visual Studio Code**.

1. In the Visual Studio Code window, select **Open Anyway**, then open the file in the Visual Studio text editor.

    Although the data is not formatted in a way that is easy to read, scroll to the right and you should be able to recognize your vibration messages.

1. Once you verified that the file contains your logging data, close the .avro document.

1. Return to your Azure portal window and navigate back to your dashboard.

## Verify your work

In this exercise, you performed the following steps:

1. Create a storage endpoint destination for messages in your route.
2. Create a storage account and container.
3. Create a route to the storage endpoint.
4. Verify that .avro storage blobs are being created.

If you encountered errors at any step or don't see .avro storage blobs created in the expected format, address the problem before continuing on to the next exercise.
