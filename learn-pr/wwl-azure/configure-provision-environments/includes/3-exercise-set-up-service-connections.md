
In this exercise, you'll investigate Service Connections.

> [!NOTE]
> To follow along with this walkthrough, you'll need an existing Azure subscription containing an existing storage account.

## Steps

You can set up a service connection to environments to create a secure and safe connection to the environment you want to deploy.

Service connections are also used to get resources from other places in a secure manner.

For example, you might need to get your source code from GitHub. Let's look at configuring a service connection to Azure in this case.

1.  From the main menu in the **Parts Unlimited** project, click **Project settings** at the bottom of the screen.

    :::image type="content" source="../media/06-01-open-project-settings-6be1e6db.png" alt-text="Screenshot of the open project settings.":::


2.  In the Project Settings pane, from the **Pipelines** section, click **Service Connections**. Click the drop-down beside **+New service connection**.
    
    :::image type="content" source="../media/06-02-new-service-connection-969bcb85.png" alt-text="Screenshot of the new service connection.":::
    
    
    As you can see, there are many types of service connections. You can create a connection to:
    
    
     -  Apple App Store.
     -  Docker Registry
     -  Bitbucket.
     -  Azure Service bus.
    
    In this case, we want to deploy a new Azure resource, so we'll use the Azure Resource Manager option.

3.  Click **Azure Resource Manager** to add a new service connection.

    :::image type="content" source="../media/06-03-add-azure-resource-manager-connection-2ec294f4.png" alt-text="Screenshot of the add Azure Resource Manager connection.":::


4.  Set the **Connection name** to **Azure Resource Manager Service Connection**, click on an Azure **Subscription**, then select an existing **Resource Group**.
    
    > [!NOTE]
    > You might be prompted to sign-in Azure at this point. If so, sign-in first.
    
    :::image type="content" source="../media/new-resource-manager-service-connection-1ccdc94a.png" alt-text="Screenshot of the new Azure Resource Manager Service Connection.":::
    
    
    Notice that what we are creating is a **Service Principal**. We'll be using the Service Principal for authenticating to Azure. At the top of the window, there's an option to set up Managed Identity Authentication instead.
    
    The Service Principal is a service account with only permissions in the specific subscription and resource group. It makes it a safe way to connect from the pipeline.
    
    > [!IMPORTANT]
    > When you create a service connection with Azure, the service principal gets a contributor role to the subscription or resource group. It's not enough to upload data to blob storage for the service principal. You must explicitly add the service principal to the Storage Blob Data Contributor role. Otherwise, the release gets failed with an authorization permission mismatch error.

5.  Click **OK** to create it. It will then be shown in the list.

    :::image type="content" source="../media/06-05-new-service-connection-added-d7276582.png" alt-text="Screenshot of the new service connection added.":::


6.  Click **Pipelines,** **Releases**, and **Edit** in the main Parts Unlimited menu to see the release pipeline. Click the link to **View stage tasks**.

    :::image type="content" source="../media/06-06-stage-tasks-39ae329a.png" alt-text="Screenshot of the stage tasks from the Parts Unlimited menu.":::


    The current list of tasks is then shown. Because we started with an empty template, there are no tasks yet. Each stage can execute many tasks.

    :::image type="content" source="../media/06-07-no-tasks-yet-bdc09b80.png" alt-text="Screenshot of the message showing no tasks yet, only the agent job.":::


7.  Click the **+** sign to the right of the **Agent job** to add a new task. See the available list of task types.

    :::image type="content" source="../media/06-08-available-task-types-a1c37e66.png" alt-text="Screenshot of the available task types.":::


8.  In the **Search** box, enter the word **storage** and see the list of storage-related tasks. These include standard tasks and tasks available from the Marketplace.

    :::image type="content" source="../media/06-09-available-storage-tasks-d5596055.png" alt-text="Screenshot of the available storage tasks.":::


    We'll use the Azure file copy task to copy one of our source files to a storage account container.

9.  Hover over the **Azure file copy** task type and click **Add** when it appears. The task will be added to the stage but requires further configuration.

    :::image type="content" source="../media/06-10-added-file-copy-d3230ff3.png" alt-text="Screenshot of the added file copy.":::


10. Click the **File Copy** task to see the required settings. Select the latest task version.
    
    :::image type="content" source="../media/06-11-required-settings-1f427416.png" alt-text="Screenshot of the required settings to select the latest task version.":::
    

11. Set the **Display Name** to **Backup website zip file**, click the ellipsis beside **Source, locate** the file as follows, and click **OK** to select it.

    :::image type="content" source="../media/06-12-select-file-or-folder-fcef2cbc.png" alt-text="Screenshot of the select file or folder option.":::


    We then need to provide details on connecting to the Azure subscription. The easiest and most secure way is to use our new Service Connection.

12. Find and select the **Azure Resource Manager Service Connection** we created from the **Azure Subscription** drop-down list.

    :::image type="content" source="../media/06-13-available-service-connections-6e3a9cc2.png" alt-text="Screenshot of the available Service Connections.":::


13. From the **Destination Type** drop-down list, select **Azure Blob**, and from the **RM Storage Account** and **Container Name**, select the storage account, enter the container's name, then click **Save** at the top of the screen, **OK**.

    :::image type="content" source="../media/06-14-blob-container-settings-6a31d280.png" alt-text="Screenshot of the blob container settings.":::


14. To test the task, click **Create release**, and in the **Create a new release** pane, click **Create**.

15. Click the new release to view the details.

    :::image type="content" source="../media/06-15-release-3-5b130d9f.png" alt-text="Screenshot of the release to all environments.":::


16. On the release page, approve the release so that it can continue.

17. Once the **Development** stage has been completed, you should see the file in the Azure storage account.

    :::image type="content" source="../media/06-16-file-in-storage-db606dd6.png" alt-text="Screenshot of file in storage in Azure Storage.":::


    A key advantage of using service connections is that this type of connection is managed in a single place within the project settings. It doesn't involve connection details spread throughout the pipeline tasks.
