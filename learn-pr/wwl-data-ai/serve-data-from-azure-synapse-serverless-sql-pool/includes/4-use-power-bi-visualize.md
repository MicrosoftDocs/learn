Power BI is a business analytics service that aims to provide interactive visualizations and business intelligence capabilities with an interface simple enough for end users to create their own reports and dashboards.

Power BI can be linked to the Azure Synapse workspace. To link your Power BI instance select the **Manage** hub in the menu on the left, then select the **Linked Services** item. If your Power BI instance is not already in the linked services list, click on the **+ New** button in command menu. In the page that will appear on the right select **Power BI**, then find the Power BI instance you want to connect to the workspace. Once that is done, your Power BI instance is linked to the Azure Synapse workspace.

To start creating Power BI reports using serverless SQL pool, select the **Develop** hub in the menu on the left, expand the **Power BI** item, select your Power BI instance, and select **Power BI data sets**. In the command bar select **+ New Power BI dataset**. A page on the right will appear with databases available in the Azure Synapse workspace. Click on **Download .pbids file** next to the database you previously created that belongs to the built-in serverless SQL pool.
 
![Defining a Power BI dataset in Azure Synapse Studio](../media/power-bi-dataset.png)

This will download a Power BI file with all the connection information already populated. Open the file, it will launch Power BI desktop. Once Power BI desktop opens, it will ask you to sign in. Select Microsoft account on the left side and click the **sign-in** button. This will open a web browser and ask you to enter your Microsoft account credentials.
 
![Entering credentials for Power BI](../media/power-bi-credentials.png)

Once signed in, click **Connect**. A new page will open where you can select the views or tables you want to use to build a report. Select the one you are interested in and click **Load**.
 
![Viewing datasets in Power BI](../media/view-power-bi-datasets.png)

You will be asked to choose between direct query and import mode. Let’s use import mode for this example. Once selected, loading of the data will start, and after it’s done you can start building your report.
 
When done, save the report and publish it to Power BI server by clicking on **File**, **Publish**, **Publish to Power BI**.
 
![Publishing reports in Power BI](../media/publish-reports-power-bi.png)

A new page will appear where you should select the Power BI instance you linked to the Azure Synapse workspace and click **publish**. Once publishing it completed the following page will appear.
 
![Publishing confirmation in Power BI](../media/publish-confirmation-power-bi.png)

Now go back to Azure Synapse Studio and select the **Develop** hub in menu on the left, expand the **Power BI** item, expand your **Power BI instance** item, and expand **Power BI reports** item. In the list you will be able to find the new report you have just built. Click on it and it will open the report designer right as a new tab in Azure Synapse Studio.

You can continue working on your report directly from Azure Synapse Studio.
