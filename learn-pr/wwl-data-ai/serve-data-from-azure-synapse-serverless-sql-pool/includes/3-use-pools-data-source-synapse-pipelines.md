Azure Synapse Pipelines are a cloud ETL service for scale-out serverless data integration and data transformation. It offers a code-free UI for intuitive authoring and single-pane-of-glass monitoring and management.
You can use Azure Synapse Pipeline to orchestrate data integration jobs and serverless SQL pool can be used as part of these jobs. To use serverless SQL pool in Azure Synapse Pipeline, you need to ensure that the built-in serverless SQL pool is properly linked to the Synapse Pipeline. Select the **Manage** hub in the Azure Synapse Studio menu on the left side, than select **Linked services**.
 
![Viewing Linked Services in Azure Synapse Studio](../media/view-linked-services.png)

Find the built-in serverless SQL pool in the list of linked services. If it’s not already there, click on **+ New** button in the command menu. A page will open on the right side, find Azure Synapse Analytics, and select it, and click on **Continue**.
Once it opens, populate the page with information required. You will need to enter the built-in serverless SQL pool connection string information manually, like shown on the image below.
 
![Creating a Linked Services in Azure Synapse Studio](../media/create-linked-services.png)

Once done, click **Test connection** button to see if everything will work out. A green checkbox reports that the connection information is good. Click on **Create now**. A page will close and a new linked service to your built-in serverless SQL pool will appear in the list.

Now navigate to the **Integrate** hub in the menu on the left side, click on **+** button and select **Pipeline**.
 
![Creating a pipeline in Azure Synapse Studio](../media/create-pipeline.png)

The pipeline designer will open. Let’s say we now want to read the data from a built-in serverless SQL pool and store the results into the storage account. To do this, drag and drop the **Copy data** activity from under the **Move & transform** section. Once it’s added to the pipeline, select it and in the bottom of the screen, select the **Source** tab.
 
![Viewing the Copy Activity in Azure Synapse Studio](../media/view-copy-activity.png)

This is where we define the source of the data for this copy activity. Click on the **+ New** button and a page will appear on the right. Find **Azure Synapse Analytics**. Give the data set a **name**, select the linked service you just created for the built-in serverless SQL pool, and then select the name of the table or view in the **Table name** drop down, and click **OK**.
  
![Define dataset properties in Azure Synapse Studio](../media/define-dataset-properties.png)

The source information in now populated.
 
![Define data source properties in Azure Synapse Studio](../media/define-data-source-properties.png)

Select the **Sink** tab and hit the **+ New** button to create a new data set where we will copy the data to. In the page that appears on the right, select **Azure Data Lake Storage Gen2**, next you can select the **file format**, let’s use **Parquet**. Next, select the **linked service** for the storage where you want to write to and specify the path. You can use the default Azure Data Lake Storage Gen2 that you linked to in the workspace when the workspace was created.
 
![Set data source properties in Azure Synapse Studio](../media/set-data-source-properties.png)

Now the sink information is populated.
 
![Viewing sink properties in Azure Synapse Studio](../media/view-sink-properties.png)

You can change the behavior of copy activity, but for simplicity let’s leave everything to default.
At the top of the pipeline designer in command bar click on the **validate** button. The page on the right should appear with a message that pipeline contains no errors.
 
![Validating pipeline in Azure Synapse Studio](../media/validate-pipelines.png)

Now click on **Debug** button in the pipeline designer command bar and your pipeline will start executing.

Once the pipeline finishes, you will see the status change to Completed. You can now go and check the files that were outputted. To operationalize this pipeline, make sure you give it a proper name, configure proper triggers that will start the pipeline, and then publish it. 
