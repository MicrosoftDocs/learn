> [!IMPORTANT]
> You need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) to complete the exercises in this module. If you don't have an Azure subscription, you can still read along.

## Create the exercise environment
1. You have been asked to make a backup of a virtual machine. The backup must be application consistent.
1. Select **Sign in** to activate sandbox and sign in using your own credentials.

    :::image type="content" source="../media/4-sandbox-sign-in.png" alt-text="Screen shot showing the Azure sign in screen"::: 

1. Select **Review permissions**, read and accept to continue.

    :::image type="content" source="../media/4-review-permission.png" alt-text="Screen shot showing review permissions button."::: 

1.  Azure Cloud Shell will authenticate and build and you are ready to start the exercise.

Using the cloud shell on the right, run these commands to create the example topology. The environment will take approximately 5 minutes to build.

.Clone the setup script from GitHub.

    ```console
    git clone https://github.com/MicrosoftDocs/mslearn-business-continuity networking
    ```

1. Run the setup script.

    ```console
    bash networking/setup.sh
    ```

1. The script will create all the resources. Wait until it completes, you should see a **Lab Environment Created** message.

    :::image type="content" source="../media/4-lab-created.png" alt-text="Screen shot showing the lab environment created message."::: 

## Create a backup

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com) using the same account you used to activate the sandbox.

1. Click the portal menu on the top left, click **Virtual machines**, and then click **labvm**.

1. If the VM is running, click **Stop**, and wait for the **Status** to show **Stopped (deallocated)**.

1. In the left navigation pane, under **Operations**, click **Backup**.

1. Enter the following settings, and then click **Enable Backup**.

   - Recovery Services vault: **Create new**

   - Backup vault: **labdemo**

   - Choose backup policy: **DefaultPolicy-labdemo**

    :::image type="content" source="../media/4-azure-backup-welcome.png" alt-text="Screen shot showing the back up welcome screen":::

1. This takes you back to the **Virtual machines** page, click **labvm**.

1. In the left navigation pane, under **Operations**, click **Backup**.

1. Click **Backup now**, and then click **OK**.

    :::image type="content" source="../media/4-vm1-backupscreen.png" alt-text="Screen shot showing the backup screen":::
   
1. The backup starts, and runs in two phases.

   - In the first phase, it takes a snapshot of the VM. This takes about 10 minutes.

   - In the second phase, it moves the data into the recovery services vault. This takes about 50 minutes.

## Monitor progress of the first phase

You won't see anything in the Backup page of the VM until the backup has completed. However, you can monitor it in the Backup center.

1. In the Azure portal, search for **backup center**, and then under **Services**, click **Backup center**.

1. In the left navigation pane, under **Monitoring + reporting**, click **Backup jobs**. You should see your job running.

    :::image type="content" source="../media//4-backup-instances.png" alt-text="Screenshot showing multiple backup instances."

1. Click the backup job to see more info. You can see in the screen picture that the first phase has completed.

    :::image type="content" source="../media/4-single-backup.png" alt-text="Screen shot showing a single backup instance."

## View results of first phase

When the first phase has completed, you can see that it is **Crash Consistent**.

1. In the breadcrumb trail, click **Backup center**.

1. In the left navigation pane, under **Manage**, click **Backup instances**.

    :::image type="content" source="../media/4-multiple-backups.png" alt-text="Screen shot showing multiple backup instances."
    
    1. Scroll down until you see **labvm** and select **labvm**. This shows that the backup is **Crash Consistent**. This is incorrect, the backup should be **Application Consistent**. You need to find out why, and fix the problem.

    > ![NOTE]
    > Only the first phase has completed, and the data will now be transferring to the vault. You can continue with the lab; you don’t have to wait for this to complete.

    :::image type="content" source="../media/4-backup-screen.png" alt-text="Screenshot of the backup screen."
 
## Resolution

The VM was in a **Stopped** state. You need to start the VM and wait for it to come to running state before making another backup.

1. Click the portal menu on the top left, click **Virtual machines**, and then click **labvm**.

1. Click **Start**, and wait for the **Status** to show **Running**.

1. In the left navigation pane, under **Operations**, click **Backup**.

1. On the **labvm** page, you should see that there is one **Crash Consistent** restore point.

1. Click **Backup now**.

    :::image type="content" source="../media/4-crash-instance-restore-point.png" alt-text="Screenshot showing the crash consistent restore point."

1. On the **Backup now** page, click **OK**. The second backup will be an incremental backup and should take less time than the first backup.

1. You can monitor progress in the **Backup center**.

1. When the first phase is complete, navigate to the **Backup** page of the VM. The send backup is **Application Consistent**.

    :::image type="content" source="../media/4-send-backup.png" alt-text="Screenshot showing backup screen."
  