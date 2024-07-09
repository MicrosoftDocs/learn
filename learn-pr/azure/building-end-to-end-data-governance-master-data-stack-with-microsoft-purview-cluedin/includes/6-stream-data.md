It might sound odd that we're going to stream data so early in the module. Even though, there are still so many problems with the data that need to be addressed.

Agility and time to value are of upmost importance in today's modern technology stack. Our data might not be perfect yet, but the data is already at a better level of usability than it was when it was raw. So, we can provide this value immediately to our end users and then iterate over our model to continue to make improvements.

So let's set up our stream of data back into an Azure Data lake Storage (ADLS) Gen2 folder called **mastered**:

1. Gather the account key for your storage account by:

    1. Under **Security + networking**, select **Access keys**. Your account access keys appear, and the complete connection string for each key.

    1. Select **Show keys** to show your access keys and connection strings and to enable buttons to copy the values.

    1. Under key1, find the **Key value**. Select the **Copy** button to copy the account key.

1. In CluedIn, navigate to your Export Targets, under the **Consume** menu, and select **Add Export Target** and choose the Azure Data Lake Connector.

    :::image type="content" source="../media/export-target-data-lake.png" alt-text="Screenshot of the CluedIn Consume window, showing the Azure Data Lake Connector selected.":::

1. Enter the account details, including the storage account key you copied earlier. The **FileSystemName** is your container name. You can use an existing container, or enter a new name here and CluedIn creates it for you. For **DirectoryName**, enter **mastered**.

    :::image type="content" source="../media/export-target-details.png" alt-text="Screenshot of the CluedIn Consume window, showing the Azure Data Lake details added.":::

1. After you enter your connection information, select **Test Connection**. If you get a green light, you can move on! If not, check these values:
    - Confirm that your container name has no capital characters, special characters, or spaces. (These limitations are required on the ADLS Gen2 side).
    - Your account key value for your ADLS Gen2 account.
    - Your storage account firewall settings and account key value for your ADLS Gen2 account.

1. Select **Streams** in the Left-Hand Menu of CluedIn and Create a New Stream called **Employees**.

    :::image type="content" source="../media/employee-stream.png" alt-text="Screenshot of the CluedIn Create Stream window, with the Stream Name entered as Employees.":::

    A Stream in CluedIn allows an end user to set up a push-based delivery of data to a target.

    A stream requires that you provide it with:
    - A filter. The records you would like to share.
    - An Export Target. Where to send the stream.
    - A projection. What data in the records to share. 

    Optionally, you can make final transformations or actions on the data. These changes are applied to the data leaving the platform, but don't affect that same data in the CluedIn platform.

1. Set a filter using the conditions on the first tab of your newly created stream with a value of **Property** and a value of **Entity Type**. Set the operator to **Equals**.

1. In the value for the Entity Type, choose **Employee** and save.

    :::image type="content" source="../media/stream-filter.png" alt-text="Screenshot of the CluedIn stream configuration window, showing the value selector.":::

1. In the **Export Target** tab, choose the Azure Data Lake Connector that you just added. Select **Next**.
1. Add **mastered** as the Target Name. This setting points the data stream to the folder you created in the first step.

    :::image type="content" source="../media/choose-target.png" alt-text="Screenshot of the CluedIn stream Export Target Configuration window, showing the ADLS Gen 2 account selected.":::

1. For the mode of the stream, choose **Synchronization**.

1. On the properties to export page, in the properties to export section, it asks you what Entity Properties and Vocabulary Keys you would like to share. Add some vocabulary items to the list, like **employee.job** (and any others that you would like).

    >[!NOTE]
    >If you do not see the vocabulary items from your created vocabularies, like employee, you may need to clear the cache and do a hard refresh of the browser.

1. Select **Save**.

    >[!NOTE]
    > You can look at the Data Tab to get a preview of the exact data that will be shared downstream.

    :::image type="content" source="../media/stream-setup.png" alt-text="Screenshot of the CluedIn stream Export Target Configuration window, showing the 'Add Property' drop-down menu.":::

1. Toggle the **Inactive** button and your stream is activated.

1. Navigate to your ADLS Gen2 and you should see a folder called **mastered** and files created for the data. Because this stream contains live data, CluedIn creates regular data files. You need to stitch these files together yourself when you want to utilize them.

Your end consumers can already start to use this data, even with its imperfections. However, we can say that your end consumers prefer to use this data over the original files in our raw folder.