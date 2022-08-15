After a Stream Analytics job is completed, you can view the results in the Azure portal. On the job's **Overview** pane, you see the status information, the location, and resource group where the service is provisioned, and the subscription details. Here, you can also confirm when the service was created and started.

To see the job's results, perform the following steps.

1. In the Azure portal, go to your output storage account **streamsink**.

1. Select **Storage browser**.

1. On the right, under **Blob containers**, open your container (**learn-container-output**).

1. Go to the **output** folder, and select the file inside it.

1. Select **Download**.

    :::image type="content" source="../media/8-download-output-file.png" alt-text="Screenshot that shows the query output result and file download button.":::

When you open the file, you should see something like this.

    ```json
    {
        "city" : "Reykjavik",
        "latitude" : 64,
        "longitude" : 21
    }
    ```