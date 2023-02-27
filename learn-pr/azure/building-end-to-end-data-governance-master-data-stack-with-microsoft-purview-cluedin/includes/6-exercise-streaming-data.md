It may sound odd that we're going to stream data so early in the module, even though there are still so many problems with the data that need to be addressed. 

Agility and time to value are of upmost importance in today's modern technology stack. Our data might not be perfect yet, but the data is already at a better level of usability than it was when it was raw, so we can provide this value immediately to our end users, and then iterate over our model to continue to make improvements.

So let's set up our stream of data back into an ADLS Gen2 folder called **mastered**:

1. Create a new folder in your ADLS Gen 2 account called **mastered**.

1. Gather the account key for your storage account by:

    1. Under **Security + networking**, select **Access keys**. Your account access keys appear, and the complete connection string for each key.

    1. Select **Show keys** to show your access keys and connection strings and to enable buttons to copy the values.

    1. Under key1, find the **Key value**. Select the **Copy** button to copy the account key.


1. In CluedIn, navigate to your Export Targets, select **Add Export Target** and choose the Azure Data Lake Connector.

    :::image type="content" source="../media/Export_Target_Data_Lake.png" alt-text="Screenshot of the CluedIn Consume window, showing the Azure Data Lake Connector selected.":::

1. Enter the account details, including the storage account key you copied earlier.

    :::image type="content" source="../media/Export_Target_Details.png" alt-text="Screenshot of the CluedIn Consume window, showing the Azure Data Lake Connector selected.":::

1. After you've entered your connection information, select **Test Connection**. If you get a green light, you can move on! If not, check your firewall settings and account key value for your ADLS Gen2 account.

1. Select **Streams** in the Left-Hand Menu of CluedIn and Create a New Stream called **Employees**.

    :::image type="content" source="../media/Employee_Stream.png" alt-text="Screenshot of the CluedIn Create Stream window, with the Stream Name entered as Employees.":::

    A Stream in CluedIn allows an end user to set up a push-based delivery of data to a target.

    A stream requires that you provide it with a Filter (which records you would like to share), an Export Target (where to send it), a projection (what data in those records to share). You can also optionally make final transformations or actions on the data to be applied to the data leaving the platform (but won't make any changes to that same data in the CluedIn platform).

1. Set a filter using the conditions on the first tab of your newly created stream with a value of **Property**, with a value of **Entity Type** and set the operator to **Equals**.

1. In the value for the Entity Type, choose **Employee** and save.

    :::image type="content" source="../media/Stream_Filter.png" alt-text="Screenshot of the CluedIn stream configuration window, showing the value selector.":::

1. In the **Export Target** tab, choose the Azure Data Lake Connector that you just added. Add **mastered** as the name of the container. This points the data stream to the folder you created in the first step.

    :::image type="content" source="../media/Choose_Target.png" alt-text="Screenshot of the CluedIn stream Export Target Configuration window, showing the ADLS Gen 2 account selected.":::

1. For the mode of the stream, choose **Synchronization**.

1. In the projection, it asks you what Entity Properties and Vocabulary Keys you would like to share. Add **employee.Job** to the list (and any others that you would like).

1. Select **Save**.

    >[!NOTE]
    > You can look at the Data Tab to get a preview of the exact data that will be shared downstream.

    :::image type="content" source="../media/Stream_Setup.png" alt-text="Screenshot of the CluedIn stream Export Target Configuration window, showing the Add Property drop-down menu.":::

1. Toggle the **Inactive** button and your stream will be activated.

1. Navigate to your ADLS Gen2 and you should see a folder called **mastered** and files created for the data. Because this is a stream of live data, CluedIn will create regular data files. You'll need to stitch these together yourself when you want to utilize them.

Your end consumers can already start to use this data, with all its glory and failures. However, we can still say at this point that the end users will prefer to use this than the original files in our raw folder.