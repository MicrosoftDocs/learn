In the Azure portal, application packages can be uploaded and managed in more feasible ways. To use application packages, you need to link an Azure storage account to your Azure Batch account. Based on quotas and limits defined for your Batch service, you can add more applications and application packages to a Batch account.

### Create an application package

1. [Download a local copy of the essentials build for ffmpeg 4.3.1](https://github.com/MicrosoftDocs/mslearn-create-batch-account/raw/main/ffmpeg-4.3.1-2020-11-08-essentials_build.zip).

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Select **Resource groups**, and then select the resource group that contains the Batch account that you created in previous steps.

1. In the settings window for your resource group, select **Overview**, and then select your Batch account.

1. In the settings window for your Batch account, select  **Applications** > **Add** to open the **New application** page.

    :::image type="content" source="../media/5-diagram-1.png" alt-text="Screenshot of the page for creating an application package in the Azure portal.":::

1. Enter the following information:

    - **Application Id**: Enter **ffmpeg** as the ID for your new application.

    - **Version**: Enter **4.3.1** as the version for the application package that you're uploading.

    - **Application package**: Use the .zip file that you downloaded earlier.

    The application ID and version that you enter must follow these requirements:

    - On Windows nodes, the ID can contain any combination of alphanumeric characters, hyphens, and underscores. On Linux nodes, only alphanumeric characters and underscores are permitted.

    - The ID can't contain more than 64 characters.

    - The ID must be unique within the Batch account.

    - IDs are case-preserving and case-insensitive.

1. When you've entered all of the information for your application, select **Submit**.

After the .zip file has been uploaded to your Azure storage account, the portal displays a notification. Depending on the size of the file that you're uploading and the speed of your network connection, this process might take some time to finish.

To add more application package versions for an existing application, select the application in the **Applications** section of your Batch account, and then select **Add**. As you did for the new application, specify the **Version** value for your new package, upload your .zip file in the **Application package** box, and then select **Submit**.

### Run a task by using an application package in the Azure portal

In the Azure portal, Batch tasks can run directly on virtual machines in a Batch pool. These tasks can use application packages to simplify environment setup.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Select **Resource groups**, and then select the resource group that contains the Batch account that you created in previous steps.

1. In the settings window for your resource group, select **Overview**, and then select your Batch account.

1. In the settings window for your Batch account, select **Jobs** > **Add**.

1. In the **Add job** window, enter **Job ID** value for your new job.

1. Click **Select a pool to run the job on**, select the pool that you created in previous steps, and then click **Select**.

1. Keep **Job manager, preparation, and release tasks** as **None**.

1. Keep **Advanced settings** as **None**.

1. Select **OK** to create your job.

    :::image type="content" source="../media/5-diagram-2.png" alt-text="Screenshot of the page for adding a job in the Azure portal.":::

1. Select the job that you created, and then select **Tasks** under the **General** header on the sidebar.

1. Select **Add** to create a new task, and then:

    1. Enter a **Task ID** value.

    1. Enter the following code for **Command line**:
    
        ```cmd
        cmd /c %AZ_BATCH_APP_PACKAGE_ffmpeg#4.3.1%\\bin\\ffmpeg.exe -i LowPriVMs-1.mp4 LowPriVMs-1.mp3
        ```

    1. Under **Advanced settings**:
    
      - For **Resource files**, select the video that you uploaded previously by selecting **Pick storage blob**. Check the box for **Include SAS**, and leave the default **Expires in** value for seven days. Select **OK**. Go to your storage account, select the **input-data** container, and select the file that you uploaded.

           :::image type="content" source="../media/5-select-resource-file.png" alt-text="Screenshot of selecting the resource file in the Azure portal.":::

      - For **Application packages**, select the application package that you added previously.

    1. Select **Submit**.

1. After the task is submitted, open it to see the output. The *stderr.txt* file reports any errors encountered. The *stdout.txt* file displays the task output result.

    :::image type="content" source="../media/5-diagram-4.png" alt-text="Screenshot of task output in the Azure portal.":::
