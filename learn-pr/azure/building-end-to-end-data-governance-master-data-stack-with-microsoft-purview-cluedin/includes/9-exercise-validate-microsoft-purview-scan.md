One of the main features of this data stack, is an end to end lineage of data movement through the data estate. So far, we can see that our data is in container storage. We can also see that it moved through CluedIn and back out to the same container storage, but in a different folder. Our data came from a folder called **raw** and we now have a new copy of that data in a folder called **mastered**.

Because we only ran our scan in Microsoft Purview once, let's run it again.

1. Go back to your storage account in Microsoft Purview, create a new scan, and run it once.

   Now that we have data free flowing from Azure Data Lake Storage (ADLS) Gen2 into CluedIn, via Microsoft Purview and then back into ADLS Gen2, we need to validate that Microsoft Purview is also automatically picking up on the mastered data coming out of CluedIn.

1. Once the scan is complete, refresh your Data Map. You should now see a CluedIn Collection on your data map.

1. More importantly search Microsoft Purview Assets for **Employee**. You should see that it found our Employees.csv in the Raw folder and files in the mastered folder as well.

1. Select the **Employees.csv** file first, and select the **Lineage**. Here we can see that Employees.csv was mapped into an entity type called Employee. We can also see that it was exported out to the same container that it came from in a folder called mastered.

:::image type="content" source="../media/purview-employees.png" alt-text="Screenshot of the lineage page for Employees.csv in Microsoft Purview.":::