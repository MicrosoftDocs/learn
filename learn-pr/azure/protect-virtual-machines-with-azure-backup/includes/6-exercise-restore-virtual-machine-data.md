A few days after you backed up your first Azure virtual machine (VM), the server had issues. The VM needs to be restored from a backup. You want to restore the VM's disk and attach it to the problematic live server, and then track the restore to ensure that it finished successfully.

In this exercise, you'll see how to restore a successful backup to replace a VM that has become corrupted, and monitor its progress.

## Restore a virtual machine in the Azure portal

### Create a storage account to use as a staging location

1. If you closed Azure, sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true) by using the same account that you used in the previous exercise.

1. In the Azure portal, enter **Storage accounts** in the top search bar, and then select it.

    ![Select storage accounts.](../media/6-select-storage-accounts.png)

    The **Storage accounts** pane appears.

1. In the menu bar, select **Create**. The **Create a storage account** pane appears.

1. On the **Basics** tab, enter the following values for each setting to create a storage account.

    | Setting | Value |
    |-|-|
    | Resource group | From the dropdown list, select **vmbackups**. |
    | **Instance details** |
    | Storage account name | Enter a unique name like **restorestagingYYYYMMDD**, where YYYYMMDD is replaced with today's date. |
    | **Region** | From the dropdown list, select **(US) West US 2**. |

    ![Specify storage account options.](../media/6-specify-storage-account-options.png)

1. Select **Review + create**.

1. After validation passes, select **Create**.

    Wait for the storage account to be deployed.

### Stop the virtual machine to allow for the restore

A backup can't be restored if the VM is allocated and running. If you forget to stop the VM and attempt to restore it, you'll see an error that's similar to the following example.

![Screenshot that shows the error details when a VM is running.](../media/6-restore-error.png)

To prevent this error, follow these steps:

1. In the top left of the Azure portal, select **Home**, select **Virtual Machines**, and then select **NW-APP01**.

    ![Screenshot that shows the VM overview page.](../media/6-vm-overview.png)

    The *NW-APP01* virtual machine pane appears.

1. In the menu bar, select **Stop**.

    ![Screenshot that shows how to stop the VM.](../media/6-stop-vm.png)

1. In the **Stop this virtual machine** dialog box, select **OK**.

    ![Screenshot of the prompt for stopping this VM.](../media/6-stop-this-vm.png)

### Restore the virtual machine

The Recovery Services vaults are accessible at the subscription level. When you're viewing the VM, Azure provides a quick link to the specific vault under **Operations**.

1. In the menu pane, scroll to **Operations**, and select **Backup**.

    ![Screenshot of the Backup operation for a VM.](../media/6-vm-backup-menu.png)

1. To restore the virtual machine, in the menu bar, select **Restore VM**. The **Restore Virtual Machine** pane for *NW-APP01* appears.

1. Under the **Restore point** text box, select **Select**. The **Select restore point** pane appears.

1. By default, the start and end date are set for a two week range. Set the **Start date** to an appropriate date for our restore points (**07/05/2021**), select the restore point to use for the recovery, and then select **OK**.

    ![Screenshot of selecting a restore point.](../media/6-restore-point.png)

    The **Restore Virtual Machine** pane for *NW-APP01* appears.

1. Configure the restore point using the following values for each setting.

    | Setting | Value |
    |-|-|
    | **Restore Configuration** |
    | Replace existing | Select this option. |
    | Staging Location | From the dropdown list, select the storage account that you previously created. |

    ![Screenshot that shows the restore configuration options.](../media/6-restore-configuration.png)

1. Select **Restore**. The **Backup** pane for the *NW-APP01* virtual machine appears. Notice the notifications in the top right of the toolbar. The latest notification shows **Triggering restore for NW-APP01**

## Track a restore

1. In the **Alerts and Jobs** section, select **View all Jobs**. The **Backup Jobs** pane appears.

    ![Screenshot of view details for the restore job.](../media/6-review-jobs.png)
    
1. In the **Details** column, select **View details** for the **Restore** job.

    :::image type="content" source="../media/6-restore-progress.png" alt-text="Screenshot of the restore progress." lightbox="../media/6-restore-progress.png":::

    The **Restore** pane appears for *NW-APP01*.

1. You can monitor the progress of the VM restore job:
    - **Job details**: Details about the restore job you launched for this VM.
    - **Job status**: Real-time progress of the restore job.
    - **Sub tasks**: Name and status of the tasks within the job.

    ![Screenshot of the job details pane.](../media/6-job-details.png)
