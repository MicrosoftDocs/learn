You've been asked to make a backup of a virtual machine. The backup must be application consistent.

> [!IMPORTANT]
> You need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) to complete the exercises in this module. If you don't have an Azure subscription, you can still read along.

## Create the exercise environment

Using the Cloud Shell on the right, run these commands to create the example topology. The environment will take approximately 5 minutes to build.

1. Clone the setup script from GitHub.

    ```powershell
    git clone https://github.com/MicrosoftDocs/mslearn-business-continuity networking
    ```

1. Run the setup script.

    ```powershell
    networking/setup.ps1
    ```

1. The script will create all the resources. Wait until it completes, you should see a **Lab Environment Created** message.

## Create a backup

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. Select the portal menu on the top left, select **Virtual machines**, and then select **labvm**.

1. If the VM is running, select **Stop**, and wait for the **Status** to show **Stopped (deallocated)**.

1. In the left navigation pane, under **Operations**, select **Backup**.

    :::image type="content" source="../media/4-azure-backup-welcome.png" alt-text="Screenshot showing the back up welcome screen.":::

1. Enter the following settings, and then select **Enable Backup**.

   - Recovery Services vault: **Create new**

   - Backup vault: **labdemo**

   - Choose backup policy: **DefaultPolicy-labdemo**

1. This takes you back to the **Virtual machines** page, select **labvm**.

1. In the left navigation pane, under **Operations**, select **Backup**.

1. Select **Backup now**, and then select **OK**.

    :::image type="content" source="../media/4-machine-backup-screen.png" alt-text="Screenshot showing the backup screen.":::

1. The backup starts, and runs in two phases.

    - In the first phase, it takes a snapshot of the VM. This takes about 10 minutes.
    
    - In the second phase, it moves the data into the recovery services vault. This takes about 50 minutes.

## Monitor progress of the first phase

You won't see anything in the Backup page of the VM until the backup has completed. However, you can monitor it in the Backup center.

1. In the Azure portal, search for **backup center**, and then under **Services**, select **Backup center**.

1. In the left navigation pane, under **Monitoring + reporting**, select **Backup jobs**. You should see your job running.

    :::image type="content" source="../media/4-backup-instances.png" alt-text="Screenshot showing the backup job running.":::

1. Select the backup job to see more info. You can see in the screen picture that the first phase has completed.

    :::image type="content" source="../media/4-single-backup.png" alt-text="Screenshot showing a single backup instance.":::

## View results of first phase

When the first phase has completed, you can see that it is **Crash Consistent**.

1. In the breadcrumb trail, select **Backup center**.

1. In the left navigation pane, under **Manage**, select **Backup instances**.

    :::image type="content" source="../media/4-multiple-backups.png" alt-text="Screenshot showing multiple backup instances.":::

1. Scroll down until you see **labvm** and select **labvm**. This shows that the backup is **Crash Consistent**. This is incorrect, the backup should be **Application Consistent**. You need to find out why and fix the problem.

    > [!NOTE]
    > Only the first phase has completed, and the data will now be transferring to the vault. You can continue with the lab; you don't have to wait for this to complete.

 
## Resolution

The VM was in a **Stopped** state. You need to start the VM and wait for it to be in a running state before making another backup.

1. Select the portal menu on the top left, select **Virtual machines**, and then select **labvm**.

1. Select **Start**, and wait for the **Status** to show **Running**.

1. In the left navigation pane, under **Operations**, select **Backup**.

1. On the **labvm** page, you should see that there is one **Crash Consistent** restore point.

1. Select **Backup now**.

    :::image type="content" source="../media/4-backup-screen.png" alt-text="Screenshot of the backup screen.":::

1. On the **Backup now** page, select **OK**. The second backup will be an incremental backup and should take less time than the first backup.

1. You can monitor progress in the **Backup center**.

1. When the first phase is complete, navigate to the **Backup** page of the VM. The send backup is **Application Consistent**.

    :::image type="content" source="../media/4-crash-instance-restore-point.png" alt-text="Screenshot showing the crash consistent restore point.":::
