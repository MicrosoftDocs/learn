When provisioning nodes for a cluster, you might want to be able to perform custom configuration tasks during the operating system boot process, before any scheduler-driven changes take effect. These tasks can include, for example, updating path environment variables, configuring Domain Name System (DNS) name resolution settings, or binding nodes to an Active Directory Domain Services (AD DS) domain.

To implement this functionality, you decided to explore the use of cloud-init in Azure CycleCloud clusters and test it with a simple Bash script that modifies the content of a local file on each node. You intend to validate the outcome by connecting to cluster nodes and reviewing the content of the modified files.

> [!NOTE]
> When authoring cloud-init scripts, you can use any scripting or configuration method that the operating system running on target nodes can recognize and process, including traditional shell scripting, Python, and YAML.

## Configure SSH-based authentication to Azure CycleCloud cluster nodes

To validate the execution of cloud-init scripts, you will connect to cluster nodes via Azure CycleCloud CLI from Azure Cloud Shell. This connection relies on SSH key-based authentication, so you will need to upload to the Azure Cloud Shell home directory the private key corresponding to the public key distributed to cluster nodes.

1. If needed, from your computer, start any Azure portal-compatible web browser, navigate to [the Azure portal](https://portal.azure.com) and, when prompted, authenticate with a Microsoft account or an Azure Active Directory (Azure AD) account that has the Contributor or Owner role in the Azure subscription you are using in this module.
1. From the Azure portal, open the **Cloud Shell** by clicking its icon in the toolbar next to the search text box and ensure that you are running a Bash session.
1. Within the web browser window displaying the Azure Cloud Shell pane, in the pane's toolbar, select the fourth icon displaying a page with a pair of vertical arrows pointing in the opposite directions and, in the drop-down menu, select **Upload**.
1. In the **Open** dialog box, navigate to the location of the **.pem** file containing the private key and click **Open**.
1. From the Bash session in the Azure Cloud Shell pane, run the following commands to move the uploaded **.pem** file to the correct location and configure necessary file-level permissions (replace the `<private_key.pem>` placeholder with the name of the **.pem** file):

    ```azurecli-interactive
    mkdir -p ./.ssh
    mv private_key.pem ./.ssh
    chmod 600 ~/.ssh/cc-ssh-keys.pem
    ```

## Add a cloud-init script to the cluster nodes

The option to add scripts to the cluster nodes is available directly from the Azure CycleCloud graphical interface. You will use it to assign the same cloud-init script to the scheduler and compute nodes and then verify its functionality. The script adds an entry **10.10.10.10 cc.contoso.com** to the **/etc/hosts** file. 

1. If you are not yet connected to the Azure CycleCloud web application, open another browser window and navigate to the **https://&lt;IP_address&gt;** URL (replace the **&lt;IP_address&gt;** placeholder with the public IP address of the Azure CycleCloud application server). If prompted, confirm that you want to proceed.
1. If prompted to authenticate, sign in by providing credentials of the same Azure CycleCloud application user account with the Administrator role.
1. In the Azure CycleCloud graphical interface, navigate to the **Clusters** page, in the list of clusters, select the **contoso-custom-slurm-lab-cluster** entry, and select **Edit**.
1. In the **Edit contoso-custom-slurm-lab-cluster** pop-up window, select the **Cloud-init** entry, and, in the **Cloud-init configuration** section, on the **scheduler** tab, enter the following script:

    ```azurecli-interactive
    #!/bin/bash
    echo "10.10.10.10 www.contoso.com" >> /etc/hosts
    ```

    :::image type="content" source="../media/u6-cyclecloud-cluster-edit-cloud-init.png" alt-text="The screenshot depicts the Cloud-init tab of the Edit contoso-custom-slurm-lab-cluster pop-up window in the Azure CycleCloud web application." border="false":::

1. Within the same pop-up window, with the **Cloud-init** entry selected, select each of the remaining tabs, enter the same script, and, once completed, select **Save**.

## Verify the cloud-init functionality on the scheduler node

To verify the cloud-init functionality on the scheduler node, you will simply start the cluster. This will trigger provisioning of the scheduler node. Once the node is running, you will be able to connect to it from the Azure Cloud Shell and verify that the **/etc/hosts** file contains the entry **10.10.10.10 www.contoso.com**.

1. From your computer, within the browser window displaying the Azure CycleCloud web application, on the **contoso-custom-slurm-lab-cluster** page, select the **Start** link and, when prompted to confirm, select **OK**.
1. In the list of nodes, select the **scheduler** entry and monitor its status in the details pane, waiting until it changes from **Acquiring** to **Ready**.

    > [!NOTE]
    > This might take about 3 minutes

1. In the details pane select **Connect**, in the **Connect to node: scheduler** pop-up window, in the **Using the CycleCloud CLI** section, select the entry containing the command allowing you to connect to the scheduler node and select **Close**:

    :::image type="content" source="../media/u6-cyclecloud-scheduler-connect-command.png" alt-text="The screenshot depicts the Connect to node: scheduler pop-up window in the Azure CycleCloud web application." border="false":::

    > [!NOTE]
    > The command should have the format `cyclecloud connect scheduler -c contoso-custom-slurm-lab-cluster`

1. Switch to the web browser window displaying the Bash session in the Azure Cloud Shell pane and run the command you copied in the previous step.

    > [!NOTE]
    > The command should generate output in the following format:
    > 
    > ```azurecli-interactive
    > m@Azure:~$ cyclecloud connect scheduler -c contoso-custom-slurm-lab-cluster
    > Connecting to cc-admin@40.87.52.25 (contoso-custom-slurm-lab-cluster scheduler) using SSH
    > [cc-admin@ip-0A000304 ~]$
    > ```

1. Once connected to the scheduler node, run the following command to verify that the **/etc/hosts** file contains the entry **10.10.10.10 www.contoso.com**:

    ```azurecli-interactive
    cat /etc/hosts | grep "10.10.10.10 www.contoso.com"
    ```

    > [!NOTE]
    > The command should generate output in the following format:
    > 
    > ```azurecli-interactive
    > [cc-admin@ip-0A000304 ~]$ cat /etc/hosts | grep "10.10.10.10 www.contoso.com"
    > 10.10.10.10 www.contoso.com
    > ```

## Verify the cloud-init functionality on the compute nodes

Now you will repeat the equivalent sequence of steps to verify cloud-init functionality on the compute nodes.

> [!IMPORTANT]
> Before you can apply the equivalent procedure to verify the cloud-init functionality on the compute nodes, you first need to remove and reallocate the corresponding Azure VM scale sets. This step is specific to the Slurm-based clusters due to the fact that, in this case, the scheduler autoscale integration requires the Azure CycleCloud pre-populates the compute nodes. As a result, the cloud-init configuration you applied earlier in this exercise would not affect already existing nodes.

1. From your computer, in the web browser window displaying the Bash session in the Azure Cloud Shell pane, while connected to the scheduler node, run the following commands to remove and reallocate the compute nodes in your Azure CycleCloud cluster and terminate the connection to the scheduler node:

    ```azurecli-interactive
    sudo -i
    cd /opt/cycle/jetpack/system/bootstrap/slurm
    ./cyclecloud_slurm.sh remove_nodes
    ./cyclecloud_slurm.sh scale
    exit
    exit
    ```

1. On your computer, switch to the web browser window displaying the **contoso-custom-slurm-lab-cluster** page of the Azure CycleCloud web application, on the **Nodes** tab, select the **htc** row, in the details pane, select the **htc-1** entry, select the **Actions** tab header, in the drop-down menu, select **Start**, and, when prompted to confirm, select **OK**.

    :::image type="content" source="../media/u6-cyclecloud-cluster-compute-node-start.png" alt-text="The screenshot depicts the Actions menu on the contoso-custom-slurm-lab-cluster page in the Azure CycleCloud web application." border="false":::

1. In the details pane, monitor the newly started node and wait until its status changes from **Acquiring** to **Ready**.

    > [!NOTE]
    > This might take about 3 minutes

1. In the details pane select **Connect**, in the **Connect to node: htc-1** pop-up window, in the **Using the CycleCloud CLI** section, select the entry containing the command allowing you to connect to the scheduler node and select **Close**:

    :::image type="content" source="../media/u6-cyclecloud-htc-1-connect-command.png" alt-text="The screenshot depicts the Connect to node: htc-1 pop-up window in the Azure CycleCloud web application." border="false":::

    > [!NOTE]
    > The command should have the format `cyclecloud connect htc-1 -c contoso-custom-slurm-lab-cluster`.

1. Switch to the web browser window displaying the Bash session in the Azure Cloud Shell pane and run the command you copied in the previous step.

    > [!NOTE]
    > The command should generate output in the following format:
    > 
    > ```azurecli-interactive
    > m@Azure:~$ cyclecloud connect htc-1 -c contoso-custom-slurm-lab-cluster
    > Connecting to cc-admin@10.0.3.5 (contoso-custom-slurm-lab-cluster htc-1) through SSH bastion at cc-admin@40.87.52.25
    > [cc-admin@ip-0A000305 ~]$
    > ```

1. Once connected to the htc-1 node, run the following command to verify that the **/etc/hosts** file contains the entry **10.10.10.10 www.contoso.com**:

    ```azurecli-interactive
    cat /etc/hosts | grep "10.10.10.10 www.contoso.com"
    ```

## Clean up the lab environment

Your testing of the cluster customization by using Azure CycleCloud application is completed. In order to avoid unnecessary costs associated with the use of Azure resources, you will now terminate the cluster and remove all of the resources you provisioned throughout the exercises of this course.

1. On your computer, in the web browser displaying the graphical interface of the Azure CycleCloud web application, on the **contoso-custom-slurm-lab-cluster**  page, select the **Terminate** link, and, when prompted to confirm, select **OK**.
1. Monitor the termination process.

    > [!NOTE]
    > The process involves deprovisioning of the Azure VM serving the role of the cluster's head node. This might take about 5 minutes.

    > [!NOTE]
    > To delete all other resources you provisioned in this lab, you will delete the resource groups hosting the cluster resources.

1. On your computer, switch to the browser window displaying the Azure portal.
1. In the Azure portal, navigate to the blade of the resource group hosting cluster resources, select the **Delete resource group** entry in the toolbar, in the **TYPE THE RESOURCE GROUP NAME** textbox, type the name of the resource group, and select **Delete**.

Congratulations! You successfully completed the third and final exercise of this module. In this exercise, you explored the use of cloud-init in Azure CycleCloud clusters and tested it with a simple Bash script that modified the content of a local file on each node. You validated the outcome by connecting to cluster nodes and reviewing the content of the modified files. Afterwards, you terminated the cluster and deleted all cluster resources you used in the course of this module to avoid any unnecessary costs.