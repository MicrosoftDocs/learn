Once the creation of the Data Factory instance is complete, you can go to the resource where you can begin to create your data pipelines by selecting **Launch Studio** on the **Open Azure Data Factory Studio** tile. This opens up the following screen:

> [!div class="mx-imgBorder"]  
> ![Screenshot that shows the Azure Data Factory Studio authoring canvas.](../media/author-azure-data-factory.png) 

The first step in your pipeline is creating a Copy Activity that copies data between the source and destination using the following steps. 

1. **Open the authoring canvas** by clicking on the **pencil icon** on the left sidebar or the create pipeline button to open the authoring canvas. 
    > [!div class="mx-imgBorder"]  
    > ![Screenshot that shows the Create pipeline option highlighted.](../media/create-pipeline-designer.png)

1. Create the **pipeline**. select the **+** button in the Factory Resources pane and select **Pipeline**.
    > [!div class="mx-imgBorder"]  
    > ![Screenshot that shows Factory Resources under the Data Factory tab. The plus symbol is selected, exposing Pipeline, both are highlighted.](../media/open-create-pipeline-designer.png)

1. Add a **copy activity**. In the **Activities** pane, open the **Move and Transform** accordion and drag the **Copy Data** activity onto the pipeline canvas.
    > [!div class="mx-imgBorder"]  
    > ![Screenshot that shows the Copy Data activity being dragged from the Move and Transform section onto the pipeline canvas.](../media/use-copy-activity.png)

With the Copy Activity added, you then start to define the source data

1. In the **Source** tab of the Copy Activity settings, select **+ New** to select a data source.
    > [!div class="mx-imgBorder"]  
    > ![Screenshot that shows the Source tab of the Copy Activity with the New button highlighted.](../media/create-data-source.png)

1. For example, In the data store list, select the **Amazon S3** tile and select **continue**
    > [!div class="mx-imgBorder"]  
    > ![Screenshot that shows the Amazon S3 tile selected in the data store list.](../media/select-amazon-simple-storage-service-data-source.png)

1. In the **file format list**, select the **DelimitedText** format tile and select **continue**
    > [!div class="mx-imgBorder"]
    > ![Screenshot that shows Delimited Text selected in the Select format list.](../media/select-data-source-file-format.png)

1. In **Set Properties** window, give your dataset an understandable **name** and select the **Linked Service dropdown**. If you haven't created your S3 Linked Service, select **New**. 
    > [!div class="mx-imgBorder"]  
    > ![Screenshot that shows the Set Properties window, with filter highlighted under Linked service.](../media/data-source-file-format.png)

1. Specific to the S3 Linked Service configuration pane, specify your S3 **access key** and **secret key**. The Data Factory service encrypts credentials with certificates managed by Microsoft. For more information, see Data Movement Security Considerations. To verify your credentials are valid, select **Test Connection**. Select **Create** when finished. 
    > [!div class="mx-imgBorder"]  
    > ![Screenshot that shows the S3 linked service configuration pane with the access key and secret key fields.](../media/set-data-source-access-keys.png)

1. Once you have created and selected the linked service, specify the rest of your dataset settings. These settings specify how and where in your connection you want to pull the data. Select **Finish** once completed. 
    > [!div class="mx-imgBorder"]  
    > ![Screenshot that shows the dataset settings configuration pane for the Amazon S3 source.](../media/finish-up-data-source-settings.png)

1. To verify your dataset is configured correctly, select **Preview Data** in the Source tab of the Copy Activity to get a small snapshot of your data. 
    > [!div class="mx-imgBorder"]
    > ![Screenshot that shows the Preview Data pane with a sample of the source data.](../media/preview-data.png)

With the source data defined, then you'll define the sink into which the data will be loaded. In this example the sink will be Azure Data Lake Storage Gen2 by performing the following steps:

1. In the **Sink** tab, select **+ New**  
    > [!div class="mx-imgBorder"]  
    > ![Screenshot that shows the Sink tab of the Copy Activity with the New button highlighted.](../media/define-data-sink-copy-activity.png)

1. Select the **Azure Data lake Storage Gen2** tile and select **continue** 
    > [!div class="mx-imgBorder"]  
    > ![Screenshot that shows the Azure Data Lake Storage Gen2 tile selected in the data store list.](../media/define-dataset.png)

1. In **Set Properties** side nav, give your dataset an understandable **name** and select the **Linked Service dropdown**. If you haven't created your ADLS Linked Service, select **New**. 
    > [!div class="mx-imgBorder"]  
    > ![Screenshot that shows the Set Properties pane for the Azure Data Lake Storage Gen2 dataset.](../media/dataset-properties.png)

1. In the ADLS linked service configuration pane, select your **authentication method** and **enter your credentials**. In the example below, an account key and selected my storage account from the drop-down. 
    > [!div class="mx-imgBorder"]  
    > ![Screenshot that shows the ADLS linked service configuration pane with the authentication method and credentials fields.](../media/finalize-dataset-properties.png)

1. Once you have configured your linked service, enter in the **ADLS dataset configuration**. Select **finish** once completed. 
    > [!div class="mx-imgBorder"]  
    > ![Screenshot that shows the ADLS dataset configuration pane.](../media/finish-dataset-properties.png)

At this point, you have fully configured your copy activity. 

1. To test it out, select the **Debug** button at the top of the pipeline canvas. This starts a pipeline debug run.
    > [!div class="mx-imgBorder"]  
    > ![Screenshot that shows the Debug button at the top of the pipeline canvas.](../media/test-copy-activity.png)

1. To monitor the progress of a pipeline debug run, select the Output tab of the pipeline
    > [!div class="mx-imgBorder"]  
    > ![Screenshot that shows the Output tab with the progress of the pipeline debug run.](../media/monitor-copy-activity.png)

1. To view a more detailed description of the activity output, select the eyeglasses icon. This opens up the copy monitoring screen, which provides useful metrics such as Data read/written, throughput, and in-depth duration statistics.
    > [!div class="mx-imgBorder"]  
    > ![Screenshot that shows the copy monitoring screen with data read, data written, and throughput metrics.](../media/view-copy-activity-results.png)

To verify the copy worked as expected, open up your ADLS gen2 storage account and check to see your file was written as expected
