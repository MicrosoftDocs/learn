Azure CycleCloud relies on templates to define cluster configurations. Its default implementation includes built-in templates for the most common schedulers, but you can find several others in the Azure CycleCloud GitHub repository.

Recall that you wanted to test the process of implementing a cluster by using a customized Azure CycleCloud template. For this purpose, you'll leverage the Azure CycleCloud GitHub repository hosting [the Microsoft curated Slurm project](https://github.com/Azure/cyclecloud-slurm). You'll modify an existing cluster template from this repository by changing the storage configuration of the scheduler node, import the newly modified template into your Azure CycleCloud application, use the application's graphical interface to create a cluster, and finally validate the storage configuration change.

> [!IMPORTANT]
> To complete exercises in this module, you have to satisfy the following prerequisites:
>
> - Have an Azure subscription with availability of vCPU cores in the three groups of VM sizes:
>   - at least 4 vCPU cores of the DSv3 series
>   - at least 100 vCPU cores of the FSv2 series
>   - at least 48 vCPU cores of the NC series
> - Have a Microsoft account or a Microsoft Entra account with the Owner or Contributor role in the Azure subscription.
> - Deploy an Azure CycleCloud application to an Azure VM accessible with a public IP address associated with its network interface.
> - Configure the Azure CycleCloud application with the Owner or Contributor role-level access to the Azure subscription.
> - Have an Azure CycleCloud application user account with the Administrator role.
> - Create an Azure virtual network subnet into which you can deploy cluster nodes.
> - Have the private key of the SSH key pair used to configure the Azure CycleCloud application.

> [!NOTE]
> For information about identifying and increasing the vCPU quotas in an Azure subscription, refer to the following documentation:
>
> - [Check vCPU quotas using the Azure CLI](/azure/virtual-machines/linux/quotas)
> - [Standard quota: Increase limits by VM series](/azure/azure-portal/supportability/per-vm-quota-requests)

> [!NOTE]
> You'll need the private key to connect directly to the cluster nodes in the last exercise of this module.

In this exercise, you will perform the following tasks:

- Task 1: Install and configure Azure CycleCloud CLI
- Task 2: Configure an Azure CycleCloud Slurm project
- Task 3: Implement a custom Azure CycleCloud template
- Task 4: Start a new cluster and examine its storage configuration

## Task 1: Install and configure Azure CycleCloud CLI

Most management tasks in this and subsequent exercises use Azure CycleCloud CLI, so you'll start by installing it and connecting it to your Azure CycleCloud application. To simplify the initial setup, you'll use Azure Cloud Shell.

> [!NOTE]
> Alternatively, you can sign in to the Azure VM hosted the Azure CycleCloud application, where the Azure CycleCloud CLI is already installed.

1. From your computer, start any Azure portal-compatible web browser, navigate to [the Azure portal](https://portal.azure.com), and when prompted, authenticate with a Microsoft account or a Microsoft Entra account that has the Contributor or Owner role in the Azure subscription you'll be using in this module.

    > [!NOTE]
    > The Azure portal supports the most common modern web browsers, including the current versions of Microsoft Edge, Google Chrome, Mozilla Firefox, and Apple Safari.

1. From the Azure portal, open the **Cloud Shell** by selecting its icon in the toolbar next to the search text box.
1. If you're prompted to select either **Bash** or **PowerShell**, select **Bash**.

    > [!NOTE]
    > If this is the first time you're starting Azure Cloud Shell and you're presented with the **You have no storage mounted** message, select the subscription you're using in this exercise, then select **Create storage**.

1. Within the Bash session in the **Azure Cloud Shell** pane, run the following command to set the value of a variable to the public IP address of the Azure CycleCloud application server (replace the placeholder `<public_ip_address>` with the actual public IP address):

    ```azurecli
    PIP=<public_ip_address>
    ```

1. Run the following command to download the .zip file containing the Azure CycleCloud instance-specific CLI installer:

    ```azurecli
    curl -O --insecure https://$PIP/static/tools/cyclecloud-cli.zip
    ```

1. Run the following commands in succession to extract and execute the script that performs the Azure CycleCloud CLI installation:

    ```azurecli
    unzip ./cyclecloud-cli.zip
    cd ./cyclecloud-cli-installer
    ./install.sh
    ```

    > [!NOTE]
    > Ignore any messages regarding the path environment variable and continue to the next step.

1. Run the following command to establish a connection to the Azure CycleCloud instance, where the `<username>` and `<password>` placeholders designate the credentials of your Azure CycleCloud application user account with the Administrator role:

    ```azurecli
    cyclecloud initialize --batch --url=https://$PIP --username=<username> --password=<password> --verify-ssl=false
    ```

    > [!NOTE]
    > The `--verify-ssl` parameter set to `false` accommodates scenarios where the Azure CycleCloud application is configured with a self-signed certificate or a certificate from an untrusted certification authority.

1. Run the following command to verify the connection to the Azure CycleCloud instance by displaying its locker configuration:

    ```azurecli
    cyclecloud locker list
    ```

    > [!NOTE]
    > The output should include the names of the lockers for each Azure subscription registered with CycleCloud and their respective containers in individual Azure Storage accounts. You should record name of the locker corresponding to the Azure subscription you intend to use for this lab, because you'll need it later in this exercise. The output of the command is in the following format (where the `<locker-name>` placeholder represents the name of the locker, the `<storage_account_name>` placeholder represents the name of the storage account hosting that locker, and the `<container_name>` placeholder represents the name of the locker container within that storage account):
    > 
    > ```output
    > <locker-name> (az://<storage_account_name>/<container_name>)
    > ```

## Task 2: Configure an Azure CycleCloud Slurm project

Next, you'll configure a sample Azure CycleCloud Slurm project. You'll leverage an existing Slurm project from the Azure CycleCloud GitHub repository. You'll fetch it into your home directory in Azure Cloud Shell and then upload it to the Azure CycleCloud locker.

1. On your computer, within the Bash session in the **Azure Cloud Shell** pane, run the following commands to create a project directory and fetch a Slurm project from the corresponding GitHub repository into it.

    ```azurecli
    mkdir ~/cyclecloud-slurm && cd ~/cyclecloud-slurm
    cyclecloud project fetch https://github.com/Azure/cyclecloud-slurm . 
    ```

    > [!NOTE]
    > Make sure to include the trailing period at the end of the second command.

1. Run the following command to designate the default locker and upload the project into it (replace the placeholder `<locker_name>` with the name of the locker you identified in the previous task, such as `cc-lab-subscription-storage`):

    ```azurecli
    cyclecloud project default_locker <locker_name>
    cyclecloud project upload 
    ```

    > [!NOTE]
    > Alternatively, you could run `cyclecloud project upload <locker_name>`, where the placeholder `<locker_name>` designates the locker name.

    > [!NOTE]
    > Ignore the azcopy-related error message stating `Cannot perform sync due to error: sync must happen between source and destination of the same type, e.g., either file <-> file, or directory/container <-> directory/container` followed by `Upload failed!` as long as the individual copies of project files succeed. To confirm this, verify that the final job status is listed as `Completed`, with zero failed transfers.

## Task 3: Implement a custom Azure CycleCloud template

Now, you'll download and modify the sample Azure CycleCloud template that's compatible with the fetched GitHub-based project. You'll use it to define a custom storage configuration that includes an extra disk attached to the scheduler node and exported through network file system (NFS). Following this modification, you'll import it into your Azure CycleCloud application.

> [!NOTE]
> You can examine the content of the template with a web browser by navigating to [the Azure/cyclecloud-slurm repository](https://github.com/Azure/cyclecloud-slurm/blob/2.4.1/templates/slurm.txt).

1. On your computer, within the web browser window displaying the Bash session in the **Azure Cloud Shell** pane, run the following command to change the working directory to the newly fetched repository:

    ```azurecli
    cd ~/cyclecloud-slurm/templates
    ```

1. Run the following commands to create a backup of the original cluster template:

    ```azurecli
    cp slurm.txt slurm.bak.txt
    ```

1. Run the following command to open the downloaded template in the nano editor:

    ```azurecli
    nano slurm.txt
    ```

    > [!NOTE]
    > Instead of the nano editor, you can use any other text editor available to you, including the Azure Cloud Shell built-in editor.

1. Within the nano editor interface, move to the `[[node scheduler]]` section. In that section, locate the `[[[volume shared]]]` subsection, move to the line `Persistent = ${NFSType == "Builtin"}`, and add the following content after it:

    ```azurecli

        # Add 2 premium disks in a RAID 0 configuration to the NFS export
        [[[volume nfs-1]]]
        Size = 128
        StorageAccountType = Premium_LRS
        Mount = nfs
        Persistent = true

        [[[volume nfs-2]]]
        Size = 128
        StorageAccountType = Premium_LRS
        Mount = nfs
        Persistent = true

        [[[configuration cyclecloud.mounts.nfs]]]
        mountpoint = /mnt/exports/lab
        fs_type = ext4
        raid_level = 0

    ```

    > [!NOTE]
    > If you're using a Windows computer, you can paste the content of the Clipboard by using the **Shift + Insert** key combination.

    > [!NOTE]
    > Your changes define two 128 GB Premium storage disks in a stripe-based volume that will be automatically mounted onto the head node during its provisioning. The volume will use the /mnt/exports/ mountpoint and will be automatically formatted as the ext4 filesystem. The `Persistent = true` setting indicates that the disks will persist when you terminate the cluster, but they'll be automatically deleted if you delete the cluster.

    > [!NOTE]
    > Azure CycleCloud implements the volumes as Azure managed disks.

1. Within the Nano editor interface, select the **Ctrl + O** key combination, select the **Enter** key, and then select the **Ctrl + X** key combination to save the changes you made and close the file.

    > [!NOTE]
    > At this point, you can use your connection to the Azure CycleCloud application through CLI to import the template.

1. Run the following command to import the template you modified in the previous task into the Azure CycleCloud application:

    ```azurecli
    cyclecloud import_template -f ~/cyclecloud-slurm/templates/slurm.txt
    ```

    > [!NOTE]
    > The command will display the name of the imported template, the state of the scheduler (`scheduler: Off -- --`) and the number of total nodes (`Total nodes: 1`).

## Task 4: Start a new cluster and examine its storage configuration

To conclude this exercise, you'll verify that the template you imported into Azure CycleCloud application delivers the intended functionality by creating a new cluster and reviewing the storage configuration of its head node to ensure that it includes a volume consisting of two persistent disks.

1. On your computer, open another browser window and navigate to the **https://&lt;IP_address&gt;** URL (replace the **&lt;IP_address&gt;** placeholder with the public IP address of the Azure CycleCloud application server). If prompted, confirm that you want to proceed.
1. If prompted to authenticate, sign in by providing credentials of the same Azure CycleCloud application user account you used to configure Azure CycleCloud CLI.
1. In the Azure CycleCloud graphical interface, navigate to the **Clusters** page and select **+**.
1. On the **Create a New Cluster** page, select the icon labeled **Slurm** in the form of an isosceles triangle with small circles at each of its vertices.

    :::image type="content" source="../media/u3-cyclecloud-new-cluster-slurm.png" alt-text="Screenshot of the Create a New Cluster page of the Azure CycleCloud web application." border="false":::

1. On the **About** tab of the **New Slurm Cluster** page, enter **contoso-custom-slurm-lab-cluster** in the **Cluster Name** text box.

    :::image type="content" source="../media/u3-cyclecloud-create-new-cluster-about.png" alt-text="Screenshot of the About tab of the New Slurm Cluster page of the Azure CycleCloud web application." border="false":::

1. On the **Required Settings** tab of the **New Slurm Cluster** page, configure the following settings (leave others with their default values) and select **Next**:

    | Setting | Value |
    | --- | --- |
    | Region | Select the name of the Azure region where you intend to deploy the cluster in this exercise. |
    | Scheduler VM Type | Select **Choose** in the **Select a machine type** pop-up window. In the **SKU Search** text box, enter **D4s_v3**. In the list of results, select the check box next to the **D4s_v3** entry, then select **Apply**. |

    > [!NOTE]
    > Ensure that you select the VM size that supports the Premium tier of Azure Storage, which is required to provision disks of the head node according to your custom configuration.

    | Setting | Value |
    | --- | --- |
    | Max HPC Cores | Enter **100**. |
    | Max HTC Cores | Enter **100**. |
    | Max VMs per Scaleset | Enter **40**. |
    | Subnet ID | Select **cyclecloud-rg: cyclecloud-rg-vnet-contoso-slurm-lab-cluster-subnet**. |

1. On the **Network Attached Storage** tab of the **New Slurm Cluster** page, verify that the **NFS Type** is set to **Builtin**, accept the default value of **Size (GB)** is set to **100**, and select **Next**.

    :::image type="content" source="../media/u3-cyclecloud-create-new-cluster-network-attached-storage.png" alt-text="Screenshot of the Network Attached Storage tab of the New Slurm Cluster page of the Azure CycleCloud web application." border="false":::

1. On the **Advanced Settings** tab of the **New Slurm Cluster** page, review the available options without making any changes, and select **Next**.

    :::image type="content" source="../media/u3-cyclecloud-create-new-cluster-advanced-settings.png" alt-text="Screenshot of the Advanced Settings tab of the New Slurm Cluster page of the Azure CycleCloud web application." border="false":::

1. On the **Cloud-init** tab of the **New Slurm Cluster** page, review the available options without making any changes, and select **Save**.
1. On the **contoso-custom-slurm-lab-cluster** page, select the **Start** link. When prompted to confirm, select **OK**.

    :::image type="content" source="../media/u3-cyclecloud-cluster-state-off.png" alt-text="Screenshot of the Nodes tab page of contoso-slurm-lab-cluster in the off state in the Azure CycleCloud web application." border="false":::

1. Monitor the startup process.

    > [!NOTE]
    > The process involves provisioning of the Azure VM serving the role of the cluster's master node, installation, and configuration of the Swarm scheduler, and creating and mounting disk volumes. This might take about five minutes.

1. After the status of the scheduler node changes to **Ready**, select its entry on the **Nodes** tab, then select **Show Detail** to display its detailed view.

    :::image type="content" source="../media/u3-cyclecloud-scheduler-node-detail.png" alt-text="Screenshot of the Nodes tab of the scheduler node of a contoso-custom-slurm-lab-cluster." border="false":::

1. In the **Showing scheduler in contoso-custom-slurm-lab-cluster cluster** pop-up window, switch to the **Node** tab, scroll to the **Volumes** section, and verify that the entries **nfs-1** and **nfs-2** display on the list of volumes.

    :::image type="content" source="../media/u3-cyclecloud-start-cluster-volumes.png" alt-text="Screenshot of the Node tab page of the detailed view of a cluster configured with two additional NFS volumes." border="false":::

Congratulations! You successfully completed the first exercise of this module. In this exercise, you implemented a cluster based on a customized Azure CycleCloud template. You used Azure CycleCloud CLI to import a sample project hosted in the Azure CycleCloud GitHub repository, including a customized copy of one of its templates. Next, you created a cluster based on the imported template with the Azure CycleCloud graphical interface, started it, and verified that the custom change took effect.

> [!NOTE]
> Don't delete the resources you deployed and configured in this exercise if you plan to run the next exercise in this module. These resources are required in order to complete the next exercise.
