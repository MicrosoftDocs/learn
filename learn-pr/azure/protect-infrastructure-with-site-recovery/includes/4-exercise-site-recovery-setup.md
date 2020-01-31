Azure Site Recovery automates the setup of recovery from one region to another. The setup process will install the Mobility Service on to the VMs, create the required infrastructure in the recovery region, and give us a way to monitor the progress.

We currently have two virtual machines running the companies patient and employee systems. These systems are running in the West US region. You've been asked to protect the infrastructure by enabling it to be recovered to the East US region. Using Azure Site Recovery, you'll enable a Recovery Services vault to replicate the current workloads.

![Image showing the current Azure infrastructure and what will be set up by Azure Site Recovery](../media/4-environment.svg)

In this exercise, we'll complete the setup of Azure Site Recovery using the portal.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, you can read through the instructions to understand how to use backup virtual machines with Azure Backup.
> If you want to complete this exercise, but you don't have an Azure subscription, or prefer not to use your account, you will need to create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

## Create a recovery services vault

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true) with your own credentials.
1. Select **+ Create a resource** option on the top-left hand side of the portal.
1. Under the **Azure Marketplace**, select **IT & Management Tools**, then select **Backup and Site Recovery**.
1. Select **east-coast-rg** for the **Resource Group**.
1. Set the **Vault name** to **asr-vault**.
1. Set the **Region** to **East US 2**.
1. Select. **Review + create**, and then on the Summary page, select **Create**.
1. Once deployed, view the resource.

## Enable replication

1. In the Recovery Services vault pane, select **+ Replicate**.

    ![Screenshot showing the source options for replication](../media/4-enable-replication-source.png)

1. Select **Azure** as your source in the pane that opens.
1. Select **West US 2** in the source location to select the original location.
1. Select **west-coast-rg** in the **Source resource group**.
1. Select **OK** at the bottom of the pane.

    ![Screenshot showing the vm selection pane](../media/4-select-vms.png)

1. On the **Select virtual machines** pane, select both virtual machines.
1. Select **OK**.

    ![Screenshot of the configure settings pane, and where to select customize.](../media/4-customize-settings.png)

1. Select **Customize**.

    ![Screenshot sowing selecting the east coast resource group](../media/4-customize-target.png)

1. In the **Target resource group**, change it to **east-coast-rg**.

1. For each VM, change the cache storage to **asrcacheXXXX**, where **XXXX** is a random number.

1. Select **OK**.

1. Select **Create target resources**. Wait for the target resources to be created.

    ![Screenshot showing the enable replication option](../media/4-enable-replication.png)

1. Once the resources have been created, you can select **Enable replication**. This step can take up to 15 minutes. Continue to the next steps to monitor the progress.

## Monitor replication progress

1. Select **Home** on the top breadcrumb menu of the page to return to the portal's home page.

1. Select **All resources**.

1. In the list of resources, select the **Recovery Services vault** named **asr-vault**.

1. On the left under **Monitoring**, select **Site Recovery jobs**.

1. In the jobs list, select the **In progress** link to view how the replication setup is progressing.

    ![Screenshot of all the Site Recovery jobs](../media/4-site-recovery-jobs.png)

1. You can select any of the listed jobs to view more details.

    ![Screenshot of the Enable replication job's progress](../media/4-replication-job.png)

Two of these jobs will take the most time to complete. If you select either of the **Enable replication** jobs, you'll see that the **Installing Mobility Service and preparing target** step can take between five to 10 minutes to finish.
