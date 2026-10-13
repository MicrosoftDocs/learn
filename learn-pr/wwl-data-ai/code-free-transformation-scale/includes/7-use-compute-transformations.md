In some cases, the code-free transformation at scale may not meet your requirements. You can use Azure Data Factory to ingest raw data collected from different sources and work with a range of compute resources such as Azure Databricks, Azure HDInsight, or other compute resources to restructure it as per your requirements.

## ADF and Azure Databricks

As an example, the integration of Azure Databricks with ADF allows you to add Databricks notebooks within an ADF pipeline to use the analytical and data transformation capabilities of Databricks. You can add a notebook within your data workflow to structure and transform raw data loaded into ADF from different sources. Once the data is transformed using Databricks, you can then load it to any data warehouse source.

Data ingestion and transformation using the collective capabilities of ADF and Azure Databricks essentially involves the following steps:

1. **Create Azure storage account** - The first step is to create an Azure storage account to store your ingested and transformed data.

1. **Create an Azure Data Factory** - Once you have your storage account setup, you need to create your Azure Data Factory using Azure portal.

1. **Create data workflow pipeline** - After your storage and ADF is up and running, you start by creating a pipeline, where the first step is to copy data from your source using ADF's Copy activity. Copy Activity allows you to copy data from different on-premises and cloud sources.

1. **Add Databricks notebook to pipeline** - Once your data is copied to your storage account, you add your Databricks notebook to the pipeline, after copy activity. This notebook may contain syntax and code to transform and clean raw data as required.

1. **Perform analysis on data** - Now that your data is cleaned up and structured into the required format, you can use Databricks notebooks to further train or analyze it to output required results.

You have learned what Azure Data Factory is and how its integration with Azure Databricks helps you to load and transform your data. Now create an end-to-end sample data workflow.


## Integrating Azure Databricks notebooks with Azure Data Factory pipeline

  
There are many tasks that need to be performed to integrate Azure Databricks notebooks with Azure Data Factory pipeline as follows:

1. Generate a Databricks Access Token.

1. Generate a Databricks Notebook

1. Create Linked Services

1. Create a Pipeline that uses Databricks Notebook Activity.

1. Trigger a Pipeline Run.

    > [!NOTE]
    > The following steps assume there is already an Azure Databricks cluster already provisioned


### Task 1: Generate an access token

1. In the Azure portal, select **Resource groups** and then select **awrgstudxx**, and then select **awdbwsstudxx** where `xx` are the initials of your name.

1. Select **Launch Workspace**.

1. Select your user profile menu in the top right corner of your Databricks workspace.

1. Select **Settings**, then select the **Developer** tab.

1. Under **Access tokens**, select the **Manage** button, then select **Generate new token**.

1. Enter a description in the **comment** "For ADF Integration" and set the **lifetime** period of 10 days and select **Generate**.

1. Copy the generated token and store in Notepad, and then select **Done**.

    > [!NOTE]
    > Personal access tokens are suited to learning and testing scenarios. For production workloads, Azure Databricks recommends more secure authentication types. The Azure Databricks linked service in Azure Data Factory also supports managed identity authentication.

### Task 2: Create a notebook

1. In the left sidebar, select **Workspace**, then select **Create** and then select **Folder**. Name the folder **adftutorial**, and select **Create Folder**. The adftutorial folder appears in the Workspace.

1. In the adftutorial folder, select **Create**, and then select **Notebook**.

1. In the Create Notebook dialog box, type the name of `mynotebook`, and ensure that the language states **Python**, and then select **Create**. The notebook with the title of `mynotebook` appears.

1. In the newly created notebook `mynotebook` add the following code:

    ```Python
    # Creating widgets for using parameters, and printing the parameters

    dbutils.widgets.text("input", "","")
    y = dbutils.widgets.get("input")
    print ("Param -\'input':")
    print (y)
    ```

    > [!NOTE]
    > The notebook path is **/adftutorial/mynotebook**

### Task 3: Create linked services

1. In Microsoft Edge, return to the tab for the Azure portal, go to your Azure Data Factory, and select **Open Azure Data Factory Studio**.

1. On the left hand side of the screen, select the **Manage** icon.

1. Under **Connections**,  select **Linked services**.

1. In the **Linked Service**, at the top of the screen, select **+ New**.

1. Select the **Compute** tab, select **Azure Databricks**, and then select **Continue**.

1. In the **New Linked Service (Azure Databricks)** screen, fill in the following details and select **Finish**:
    - **Name**: `xx_dbls`, where `xx` are your initials
    - **Databricks Workspace**: `awdbwsstudxx`, where `xx` are your initials
    - **Select cluster**: Existing interactive cluster
    - **Databricks Workspace URL**: should be populated
    - **Authentication type**: Access token
    - **Access token**: Copy the access token from Notepad and paste into this field
    - **Choose from existing cluster**: `awdbclstudxx`, where `xx` are your initials
    - Leave other options to their default settings

    > [!NOTE]
    > When you select **Finish**, you are returned to the **Azure Data Factory Studio** where the xx_dbls has been created, with the other linked services created in the previous exercise.

### Task 4: Create a pipeline that uses Databricks Notebook Activity

1. On the left hand side of the screen, select the **Author** icon, and then select **Pipeline**. This opens up a tab with a Pipeline designer.

1. At the bottom of the pipeline designer, select the parameters tab, and then select **+ New**.

1. Create a parameter with the Name of **name**, with a type of **string**

1. Under the **Activities** menu, expand out **Databricks**.

1. Select and drag **Notebook** onto the canvas.

1. In the properties for the **Notebook1** window at the bottom, complete the following steps:
    - Switch to the **Azure Databricks** tab.
    - Select **xx_dbls** which you created in the previous procedure.

    - Switch to the **Settings** tab, and put **/adftutorial/mynotebook** in Notebook path.
    - Expand **Base Parameters**, and then select **+ New**.
    - Create a parameter with the Name of **input**, with a value of **@pipeline().parameters.name**

1. In the **Notebook1**, select **Validate**, next to the Save as template button. A window appears on the right of the screen that states "Your Pipeline has been validated.
No errors were found." Select the >> to close the window.

1. Select **Publish all** to publish the linked service and pipeline.

    > [!NOTE]
    > A message appears to state that the deployment is successful.

### Task 5: Trigger a pipeline run

1. In the **Notebook1**, select **Add trigger**, and select **Trigger now** next to the Debug  button.

1. The **Pipeline Run** dialog box asks for the name parameter. Use **/path/filename** as the parameter here. Select **Finish**. A red circle appears above the Notebook1 activity in the canvas.

### Task 6: Monitor the pipeline

1. On the left of the screen, select the **Monitor** tab. Confirm that you see a pipeline run. If the cluster is stopped, it can take several minutes to start before the notebook runs.

1. Select **Refresh** periodically to check the status of the pipeline run.

1. To see activity runs associated with the pipeline run, select **View Activity Runs** in the **Actions** column.

### Task 7: Verify the output

1. In Microsoft Edge, select the tab `mynotebook - Databricks`.

1. In the **Azure Databricks** workspace, select **Compute** and check the state of the cluster.

1. Select the cluster `awdbclstudxx`, and then select the **Event Log** to view the activities.

    > [!NOTE]
    > If the cluster was stopped before the run, you see an Event Type of **Starting** with the time you triggered the pipeline run.