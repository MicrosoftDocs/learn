In this unit, you learn how to copy data from your Azure Managed Lustre file system to long-term storage in Azure Blob Storage by creating an export job. You can initiate an export job and monitor the job's progress and status in the Azure portal. Export jobs copy new or changed files from the file system to the blob container that you specified when you created the file system.

## Create an export job

You can export data from your Azure Managed Lustre file system to long-term storage in Azure Blob Storage by creating an export job. The export job copies new or changed files from the file system to the blob container that you specified when you created the file system.

Follow these steps to create an export job in the Azure portal:

1. In the Azure portal, open your Azure Managed Lustre file system and select the **Blob integration** pane under **Settings**.
1. Select **+ Create new job**.
1. In the **Job Type** dropdown, select **Export**.
1. In the **File system path** field, you can enter a string to specify what to export. All new or changed files in the file system whose filenames begin with this string are exported. Files are written to the blob container with the same file path (or prefix) that they have in the Lustre system. To avoid overwriting existing files in the blob container, make sure the path of the file in your Lustre system doesn't overlap the existing path of the file in the blob container.

The following screenshot shows the export job configuration settings in the Azure portal:

:::image type="content" source="./media/create-archive-job-options.png" alt-text="Screenshot showing portal setup for creating an export (archive) job." lightbox="./media/create-archive-job-options.png":::

## Monitor or cancel an export job

You can monitor or cancel export jobs you created through blob integration with your Azure Managed Lustre file system in the Azure portal. The **Recent jobs** section of the **Blob integration** page shows the status of each job.

Only one archive job runs at a time. To cancel the job that's in progress, select the **Cancel** link for that job in the **Recent jobs** table. The **Cancel** link isn't available for a completed job.

## Retry an export job

If an export job doesn't complete successfully, you can retry the export by [creating a new export job](#create-an-export-job). The new job copies only the files that weren't copied during the previous job.

Retries can be common when attempting to export data from active file systems where data is frequently changing. To learn more about these scenarios, see [Running export jobs in active file systems](/azure/azure-managed-lustre/blob-integration.md#running-export-jobs-in-active-file-systems).
