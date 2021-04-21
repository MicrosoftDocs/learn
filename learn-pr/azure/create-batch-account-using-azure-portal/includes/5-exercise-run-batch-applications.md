In Azure portal, application packages can be uploaded and managed in more feasible way. In order to use application packages, you need to link an Azure Storage account to your Batch account. Based on quotas and limits defined for your Azure Batch service, you can add additional applications and application packages to a Batch account.

### Create an application package

1. Download a local copy of the essentials build for [ffmpeg 4.3.1](https://github.com/MicrosoftDocs/mslearn-create-batch-account/raw/main/ffmpeg-4.3.1-2020-11-08-essentials_build.zip).

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Select **Resource groups**, then select the resource group that contains the Batch account that you created in previous steps.

1. In the settings window for your resource group, select **Overview**, then select your Batch account.

1. In the settings window for your Batch account, select the **Applications**, and then select **Add**

    :::image type="content" source="../media/5-diagram-1.png" alt-text="A screenshot of the 'New application' page in the Azure portal, which is used for creating application packages.":::

1. Enter the following information:

    * **Application ID**: Enter `ffmpeg` as the ID for your new application.

    * **Version**: Enter `4.3.1` as the version for the application package you are uploading.

    * **Application package**: Use the .zip file downloaded earlier.

    The Application ID and Version you enter must follow these requirements:

    * On Windows nodes, the ID can contain any combination of alphanumeric characters, hyphens, and underscores. On Linux nodes, only alphanumeric characters and underscores are permitted.

    * Can't contain more than 64 characters.

    * Must be unique within the Batch account.

    * IDs are case-preserving and case-insensitive.

1. When you have entered all of the information for your application, select **Submit**.

After the .zip file has been uploaded to your Azure Storage account, the portal displays a notification. Depending on the size of the file that you are uploading and the speed of your network connection, this may take some time to complete.

To add additional application package versions for an existing application, select the application in the **Applications** section of your Batch account, then select **Add**. As you did for the new application, specify the **Version** for your new package, upload your .zip file in the Application package field, and then select **Submit**.

### Run a task using an application package in the Azure portal 

In Azure portal, Batch tasks can run directly on virtual machines in a Batch pool. These tasks can utilize application packages to simplify environment set-up.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Select **Resource groups**, then select the resource group that contains the Batch account that you created in previous steps.

1. In the settings window for your resource group, select **Overview**, then select your Batch account.

1. In the settings window for your Batch account, select the **Jobs**, and then select **Add**

1. In the **Add job** window, enter a **Job ID** for your new job.

1. Select **Select a pool to run the job on**, then select the pool that you created in previous steps, and then click **Select**.

1. Keep **Job manager, preparation, and release tasks** as "None".

1. Keep **Advanced settings** as "None".

1. Select **OK** to create your job.

    :::image type="content" source="../media/5-diagram-2.png" alt-text="A screenshot of the 'Add job' page in the Azure portal.":::

1. Next, select the job you just created and select **Tasks** under the "General" header on the sidebar.

1. Select **Add** to create a new task.

    1. Enter a **Task ID**.

    1. Enter the following for **Command line**:
    
        ```cmd
        cmd /c %AZ_BATCH_APP_PACKAGE_ffmpeg#4.3.1%\\bin\\ffmpeg.exe -i LowPriVMs-1.mp4 LowPriVMs-1.mp3
        ```

    1. Under **Advanced settings**:
    
        1. For **Resource files**, select the video you uploaded previously by selecting **Pick storage blob**. Select **Include SAS** and click OK. Navigate to your storage account, select the **input-data** container, and select the file you uploaded.

        :::image type="content" source="../media/5-select-resource-file.png" alt-text="A screenshot of selecting the resource file in the Azure portal.":::

        1. For **Application packages**, select the application package you added previously.

    1. Click **Submit**.

1. After the task is submitted, click into it to see the output. `stderr.txt` reports any error encountered, and `stdout.txt` displays the task output result.

    :::image type="content" source="../media/5-diagram-4.png" alt-text="A screenshot of task output in the Azure portal.":::
