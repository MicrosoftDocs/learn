Azure CycleCloud relies on templates to define cluster configurations. Its default implementation includes built-in templates for the most common schedulers, but you can find a number of others in the Azure CycleCloud GitHub repository.

Recall that you wanted to test the process of implementing a cluster by using a customized Azure CycleCloud template. For this purpose, you will leverage the Azure CycleCloud GitHub repository hosting [the Microsoft curated Slurm project](https://github.com/Azure/cyclecloud-slurm). You will modify an existing cluster template from this repository by changing the storage configuration of the scheduler node, import the newly modified template into your Azure CycleCloud application, use the application's graphical interface to create a cluster, and finally validate the storage configuration change.

> [!IMPORTANT]
> To complete exercises in this module, you have to satisfy the following prerequisites:
> - Have an Azure subscription with availability of vCPU cores in the three groups of VM sizes:
>    - at least 4 vCPU cores of the DSv3 series
>    - at least 400 vCPU cores of the FSv2 series
>    - at least 60 vCPU cores of the NC series
> - Have a Microsoft account or an Azure AD account with the Owner or Contributor role in the Azure subscription.
> - Deploy an Azure CycleCloud application to an Azure VM accessible via a public IP address associated with its network interface.
> - Configure the Azure CycleCloud application with the Owner or Contributor role-level access to the Azure subscription.
> - Have an Azure CycleCloud application user account with the Administrator role.
> - Create an Azure virtual network subnet into which you can deploy cluster nodes.
> - Have the private key of the SSH key pair used to configure the Azure CycleCloud application. 

> [!NOTE]
> You will need the private key in order to connect directly to the cluster nodes in the last exercise of this module.

## Install and configure Azure CycleCloud CLI

The majority of management tasks in this and subsequent exercises require the use of Azure CycleCloud CLI, so you will start by installing it and connecting it to your Azure CycleCloud application. To simplify the initial setup, you will use Azure Cloud Shell. 

1. From your computer, start any Azure portal-compatible web browser, navigate to [the Azure portal](https://portal.azure.com) and, when prompted, authenticate with a Microsoft account or an Azure Active Directory (Azure AD) account that has the Contributor or Owner role in the Azure subscription you will be using in this module.

    > [!NOTE]
    > The Azure portal supports the most common modern web browsers, including the current versions of Microsoft Edge, Google Chrome, Mozilla Firefox, and Apple Safari. 

1. From the Azure portal, open the **Cloud Shell** by clicking its icon in the toolbar next to the search text box.
1. If prompted to select either **Bash** or **PowerShell**, select **Bash**. 

    > [!NOTE]
    > If this is the first time you are starting Azure Cloud Shell and you are presented with the **You have no storage mounted** message, select the subscription you are using in this lab, and then select **Create storage**. 

1. Within the Bash session in the Azure Cloud Shell pane, run the following command to set the value of a variable to the public IP address of the Azure CycleCloud application server (replace the placeholder `<public_ip_address>` with the actual public IP address): 

    ```azurecli-interactive
    PIP=<public_ip_address>
    ```

1. Run the following command to download the ZIP file containing the Azure CycleCloud instance-specific CLI installer:

    ```azurecli-interactive
    curl -O --insecure https://$PIP/static/tools/cyclecloud-cli.zip
    ```

1. Run the following commands to extract and execute the script that performs the Azure CycleCloud CLI installation:

    ```azurecli-interactive
    unzip ./cyclecloud-cli.zip
    cd ./cyclecloud-cli-installer
    ./install.sh
    ```

1. Run the following command to establish a connection to the Azure CycleCloud instance, where the `<username>` and `<password>` placeholders designate the credentials of your Azure CycleCloud application user account with the Administrator role:

    ```azurecli-interactive
    cyclecloud initialize --batch --url=https://$PIP --username=cc-admin --password=Pa55w.rd1234 --verify-ssl=false
    ```

    > [!NOTE]
    > The `--verify-ssl` parameter set to `false` accommodates scenarios where the Azure CycleCloud application is configured with a self-signed certificate or a certificate from an untrusted certification authority.

1. Run the following command to verify the connection to the Azure CycleCloud instance by displaying its locker configuration:

    ```azurecli-interactive
    cyclecloud locker list
    ```

    > [!NOTE]
    > The output should include the names of the lockers and their respective Azure Storage locations. You should record their names since you will need one of them later in this exercise.
    > 
    > ```
    > default-locker (az://cyclecloud050921/cyclecloud)
    > ```


## Configure an Azure CycleCloud Slurm project 

Next, you will configure a sample Azure CycleCloud Slurm project. You will leverage an existing Slurm project from the Azure CycleCloud GitHub repository. You will fetch it into your home directory in Azure Cloud Shell and then upload it to the Azure CycleCloud locker.

1. On your computer, within the web browser window displaying the Azure portal, within the Bash session in the Azure Cloud Shell pane, run the following commands to create a project directory and fetch a Slurm project from the corresponding GitHub repository into it.

    ```azurecli-interactive
    mkdir ~/cyclecloud-slurm && cd ~/cyclecloud-slurm
    cyclecloud project fetch https://github.com/Azure/cyclecloud-slurm
    ```

1. Run the following command to designate the default locker and upload the project into it (replace the placeholder `<locker_name>` with the name of the locker you identified in the previous task):

    ```azurecli-interactive
    cyclecloud project default_locker <locker_name>
    cyclecloud project upload 
    ```

    > [!NOTE]
    > Alternatively, you could simply run `cyclecloud project upload <locker_name>`, where the placeholder `<locker_name>` designates the locker name.

    > [!NOTE]
    > Ignore the azcopy related error message stating `Cannot perform sync due to error: sync must happen between source and destination of the same type, e.g., either file <-> file, or directory/container <-> directory/container` followed by `Upload failed!` as long as the individual copies of project files succeed.

    > [!NOTE]
    > Wait for the upload to complete. This might take about 5 minutes.


## Implement a custom Azure CycleCloud template

Now, you will download and modify the sample Azure CycleCloud template compatible with the fetched GitHub-based project. You will use it to define a custom storage configuration that includes an extra disk attached to the scheduler node and exported via network file system (NFS). Following this modification, you will import it into your Azure CycleCloud application.

> [!NOTE]
> You can examine the content of the template via a web browser by navigating to [the Azure/cyclecloud-slurm repository](https://github.com/Azure/cyclecloud-slurm/blob/2.4.1/templates/slurm.txt)

1. On your computer, within the web browser window displaying the Bash session in the Azure Cloud Shell pane, run the following command to change the working directory to the newly fetched repository:

    ```azurecli-interactive
    cd ~/cyclecloud-slurm/templates
    ```

1. Run the following commands to download the intended version of the cluster template:

    ```azurecli-interactive
    mv slurm.txt slurm.bak.txt
    curl -O https://raw.githubusercontent.com/Azure/cyclecloud-slurm/2.4.1/templates/slurm.txt
    ```

1. Run the following command to open the downloaded template in the nano editor:

    ```azurecli-interactive
    nano slurm.txt
    ```

1. Within the nano editor interface, scroll-down to the `[[node scheduler]]` section, within that section, locate the `[[[volume shared]]]` subsection, scroll to the line `Persistent = ${NFSType == "Builtin"}`, and add the following content after it:

    ```azurecli-interactive

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
        mountpoint = /mnt/exports
        fs_type = ext4
        raid_level = 0

    ```

    > [!NOTE]
    > If you are using a Windows computer, you can paste the content of Clipboard by using the **Shift+Insert** key combination.

    > [!NOTE]
    > Your changes define two 128 GB Premium storage disks in a stripe-based volume that will be automatically mounted onto the head node during its provisioning. The volume will use the /mnt/exports/ mountpoint and will be automatically formatted as the ext4 filesystem. The `Persistent = true` setting indicates that the disks will persist when you terminate the cluster, although they will be automatically deleted if you delete the cluster.

    > [!NOTE]
    > Azure CycleCloud implements the volumes as Azure managed disks.

1. Within the Nano editor interface, press **ctrl + o** key combination, press the **Enter** key, and then press **ctrl + x** key combination to save the changes you made and close the file.

    > [!NOTE]
    > At this point, you can leverage your connection to the Azure CycleCloud application via CLI to import the template. 

1. Run the following command to import the template you modified in the previous task into the Azure CycleCloud application:

    ```azurecli-interactive
    cyclecloud import_template -f ~/cyclecloud-slurm/templates/slurm.txt
    ```

## Start a new cluster and examine its storage configuration

To conclude this exercise, you will verify that the template you imported into Azure CycleCloud application delivers the intended functionality. To accomplish this, you will create a new cluster and review the storage configuration of its head node to ensure that it includes a volume consisting of two persistent disks. 

1. On your computer, open another browser window and navigate to the **https://&lt;IP_address&gt;** URL (replace the **&lt;IP_address&gt;** placeholder with the public IP address of the Azure CycleCloud application server). If prompted, confirm that you want to proceed.
1. If prompted to authenticate, sign in by providing credentials of the same Azure CycleCloud application user account you used to configure Azure CycleCloud CLI.
1. In the Azure CycleCloud graphical interface, navigate to the **Clusters** page and select **+**. 
1. On the **Create a New Cluster** page, select the icon labeled **Slurm** in the form of an isosceles triangle with small circles at each of its vertices.

    :::image type="content" source="../media/u3-cyclecloud-new-cluster-slurm.png" alt-text="The screenshot depicts the Create a New Cluster page of the Azure CycleCloud web application." border="false":::

1. On the **About** tab of the **New Slurm Cluster** page, in the **Cluster Name** text box, type **contoso-custom-slurm-lab-cluster**.

    :::image type="content" source="../media/u3-cyclecloud-create-new-cluster-about.png" alt-text="The screenshot depicts the About tab of the New Slurm Cluster page of the Azure CycleCloud web application." border="false":::

1. On the **Required Settings** tab of the **New Slurm Cluster** page, in the **Cluster Name** text box, configure the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Region | select the name of the Azure region  where you intend to deploy the cluster in this exercise |
    | Scheduler VM Type | select **Choose**, in the **Select a machine type** pop-up window, in the **SKU Search** text box, type **D4s_v3**, in the list of results, select the checkbox next to the **D4s_v3** entry, and select **Apply** |

    > [!NOTE]
    > Ensure that you select the VM size that supports the Premium tier of Azure Storage, which is required to provision disks of the head node according to your custom configuration.

    :::image type="content" source="../media/u3-cyclecloud-select-machine-type.png" alt-text="The screenshot depicts the Select a machine type pop-up window tab of the New Slurm Cluster page of the Azure CycleCloud web application." border="false":::

    | Setting | Value |
    | --- | --- |
    | Max HPC Cores | type **100** |
    | Max HTC Cores | type **100** |
    | Max VMs per Scaleset | type **40** |
    | Subnet ID | select **cyclecloud-rg: cyclecloud-rg-vnet-contoso-slurm-lab-cluster-subnet** |

    :::image type="content" source="../media/u3-cyclecloud-create-new-cluster-required-settings.png" alt-text="The screenshot depicts the Required Settings tab of the New Slurm Cluster page of the Azure CycleCloud web application." border="false":::

1. On the **Network Attached Storage** tab of the **New Slurm Cluster** page, verify that the **NFS Type** is set to **Builtin**, accept the default value of **Size (GB)** set to **100**, and select **Next**.

    :::image type="content" source="../media/u3-cyclecloud-create-new-cluster-network-attached-storage.png" alt-text="The screenshot depicts the Network Attached Storage tab of the New Slurm Cluster page of the Azure CycleCloud web application." border="false":::

1. On the **Advanced Settings** tab of the **New Slurm Cluster** page, review the available options without making any changes and select **Next**.

    :::image type="content" source="../media/u3-cyclecloud-create-new-cluster-advanced-settings.png" alt-text="The screenshot depicts the Advanced Settings tab of the New Slurm Cluster page of the Azure CycleCloud web application." border="false":::

1. On the **Cloud-init** tab of the **New Slurm Cluster** page, review the available options without making any changes and select **Save**.

    :::image type="content" source="../media/u3-cyclecloud-create-new-cluster-advanced-settings.png" alt-text="The screenshot depicts the Advanced Settings tab of the New Slurm Cluster page of the Azure CycleCloud web application." border="false":::

1. On the **contoso-custom-slurm-lab-cluster** page, select the **Start** link and, when prompted to confirm, select **OK**

    :::image type="content" source="../media/u3-cyclecloud-cluster-state-off.png" alt-text="The screenshot depicts the Nodes tab page of contoso-slurm-lab-cluster in the off state in the Azure CycleCloud web application." border="false":::

1. Monitor the startup process.

    > [!NOTE]
    > The process involves provisioning of the Azure VM serving the role of the cluster's master node, installation and configuration of the Swarm scheduler, as well as creating and mounting disk volumes. This might take about 5 minutes.

1. Once the status of the scheduler node changes to **Ready**, select its entry on the **Nodes** tab and then select **Show Detail** to display its detailed view. 
1. In the **Showing scheduler in contoso-custom-slurm-lab-cluster cluster** pop-up window, switch to the **Node** tab, scroll down to **Volumes** section, and verify that the entries **nfs-1** and **nfs-2** appear on the list of volumes.
 
    :::image type="content" source="../media/u3-cyclecloud-start-cluster-volumes.png" alt-text="The screenshot depicts the Node tab page of the detailed view of a cluster configured with two additional NFS volumes." border="false":::

Congratulations! You successfully completed the first exercise of this module. In this exercise, you implemented a cluster based on a customized Azure CycleCloud template. You used Azure CycleCloud CLI to import a sample project hosted in the Azure CycleCloud GitHub repository, including a customized copy of one of its templates. Next, you created a cluster based on the imported template via the Azure CycleCloud graphical interface, started it, and verified that the custom change took effect.