Once a Stream Analytics job has completed, you can view the results right in the Azure portal. Within the Overview pane for the job, not only can you can get information about the status, but you can confirm the location and resource group in which the service is provisioned, as well as the subscription details. You can also confirm dates when the service was created and started.

1. In the Azure portal, navigate to your output Storage account (**streamsink**).
1. Select Storage Explorer (preview).
1. In the right pane, open your container (**learn-container**) under **BLOB CONTAINERS**.
1. Navigate to **output** folder and download the blob to view the query output results.

    ![Screenshot of Showing Query Result](../media/8-query-result.png)

If you open the file, you should see something like the following:

```json
{
    "city" : "Reykjavik",
    "latitude" : 64,
    "longitude" : 21
}
```