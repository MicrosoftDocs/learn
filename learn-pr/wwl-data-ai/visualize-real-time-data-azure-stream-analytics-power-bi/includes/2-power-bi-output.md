
All Azure Stream Analytics jobs include at least one input and output. In most cases, inputs reference sources of streaming data (though you can also define inputs for static reference data to augment the streamed event data). Outputs determine where the results of the stream processing query will be sent. To support real-time data visualization, you can use a **Power BI** output.

## Streaming data inputs

Inputs for streaming data consumed by Azure Stream Analytics can include:

- Azure Event Hubs
- Azure IoT Hubs
- Azure Blob or Data Lake Gen 2 Storage

Depending on the specific input type, the data for each streamed event includes the event's data fields and input-specific metadata fields. For example, data consumed from an Azure Event Hubs input includes an **EventEnqueuedUtcTime** field indicating the time when the event was received in the event hub.

> [!NOTE]
> For more information about streaming inputs, see [Stream data as input into Stream Analytics](/azure/stream-analytics/stream-analytics-define-inputs?azure-portal=true) in the Azure Stream Analytics documentation.

## Power BI outputs

You can use a Power BI output to write the results of a Stream Analytics query to a table in a Power BI streaming dataset, from where it can be visualized in a dashboard. When adding a Power BI output to a Stream Analytics job, you need to specify the following properties:

- **Output alias**: A name for the output that can be used in a query.
- **Group workspace**: The Power BI workspace in which you want to create the resulting dataset.
- **Dataset name**: The name of the dataset to be generated by the output. You shouldn't pre-create this dataset as it will be created automatically (replacing any existing dataset with the same name).
- **Table name**: The name of the table to be created in the dataset.
- **Authorize connection**: You must authenticate the connection to your Power BI tenant so that the Stream Analytics job can write data to the workspace.

> [!NOTE]
> For more information about Power BI outputs, see [Power BI output from Azure Stream Analytics](/azure/stream-analytics/power-bi-output?azure-portal=true) in the Azure Stream Analytics documentation.
