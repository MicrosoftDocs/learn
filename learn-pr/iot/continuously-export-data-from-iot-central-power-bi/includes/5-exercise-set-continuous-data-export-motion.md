In this unit, first we create blob storage, including one container, then we create a new data export from our IoT Central app. Finally, we test that the telemetry data is reaching the storage container.

It's essential to create the resources in the correct order: storage first, then data export.

## Create a blob storage resource

We're going to create blob storage outside of our IoT Central app, and then connect to it using a connection string.

1. Right-click [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), and select **Open link in new window**.

1. Select **+ Create a resource**, and type "Blob storage" into the search bar.

1. There are quite a few storage options, make sure to select **Storage account - blob, file, table, queue**.

    [![Screenshot showing the create button for new storage](../media/continuous-data-new-storage.png)](../media/continuous-data-new-storage.png#lightbox)

1. Click **Create**.

1. The subscription should be the sandbox **Concierge subscription**.

1. Select the **Resource group** for the sandbox, which should start with **learn-**.

1. Give the storage a suitable name, "continuousblob", or similar.

1. Select the region nearest to you.

1. Leave the rest of the entries at their default values, and click **Review + create**. And click **Create** again, when that option appears.

    [![Screenshot showing how to create a blob storage resource](../media/continuous-data-blob.png)](../media/continuous-data-blob.png#lightbox)

1. When the option is available, click **Go to resource**.

## Create a storage container

It's important to have a container within your blob storage account.

1. Locate **Containers** in the left menu for your blob storage, then select **+ Container**.

1. Create a new container, with a name such as "continuouscontainer".

1. When the container deploys, navigate back to the overview page for the blob storage.

## Extract the connection string for the blob storage account

We're going to connect the data export feature to the storage account using a connection string.

1. Locate, and select, **Access keys**, under **Settings**, in the left menu.

1. You'll notice that there are two keys. You need the full **Connection string**, so use the icon to the far right to copy the **key1** connection string to the clipboard.

    [![Screenshot showing the connection strings for blob storage](../media/continuous-data-blob-key.png)](../media/continuous-data-blob-key.png#lightbox)

1. Save off the connection string to the text file you created in an earlier unit.

1. Great, you've now set up and copied all you need. Leave the storage overview page open though, so you can come back and find it when checking data is being received.

## Create the data export

1. Navigate to your browser page that has your IoT Central app in view.

1. Locate, and select, the **Data export** entry in the left menu. Then, under the **+ New** drop-down list, select **Azure Blob Storage**.

    [![Screenshot showing the menu options for new data export](../media/continuous-data-new-export.png)](../media/continuous-data-new-export.png#lightbox)

1. In the **Create data export** dialog that follows, enter the connection string you saved off in the previous section.

1. For **Container**, enter **continuouscontainer**.

1. Verify that **Enabled**, **Telemetry**, **Devices**, and **Device templates** are all **On**. Then click **Save**.

1. You should now see the **Data export** page, noting that your data export **Status** is **Running**.

    [![Screenshot showing that the data export service is up and running](../media/continuous-data-export-running.png)](../media/continuous-data-export-running.png#lightbox)

Good work. The final step of this unit is to verify the telemetry is reaching your container.

## Verify your container is receiving continuous data

1. Your refrigerated truck app might still be running, but if not, start it again now.

1. Find the browser window with the blob storage resource in view.

1. Find, and select, **Containers** in the left menu. Click on **continuouscontainer**.

1. There will be some latency before data appears. When data starts arriving, you can clearly see the node headings of **devices**, **deviceTemplates**, and **telemetry**.

    [![Screenshot showing the blob container is receiving data](../media/continuous-data-blob-flowing.png)](../media/continuous-data-blob-flowing.png#lightbox)

1. Great progress: your continuous data is now flowing into your blob storage container. Feel free to navigate the container nodes, though the content is fairly dry JSON.

1. Leave everything running. In the real-world, data will certainly flow continuously.

With this JSON data arriving in volumes, the question is what to do with it. What we want is an app to enable friendly display of the data. Let's next look at some Microsoft technology that is suitable for data visualization.
