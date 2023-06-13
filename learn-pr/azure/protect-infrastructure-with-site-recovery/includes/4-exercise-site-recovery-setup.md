Azure Site Recovery automates the setup of recovery from one region to another. The setup process will install the Mobility Service onto the VMs, create the required infrastructure in the recovery region, and give you a way to monitor the progress.

Currently, two VMs are running the company's patient and employee systems. These systems are running in the West US region. You've been asked to protect the infrastructure by enabling it to be recovered to the East US region. Using Azure Site Recovery, you'll enable a Recovery Services vault to replicate the current workloads.

:::image type="content" source="../media/4-environment.svg" alt-text="Diagram showing resources and infrastructure of primary region with storage account. The  hr-records, patient-records will be replicated in a recovery vault in a recovery region.":::

In this exercise, you'll complete the setup of Azure Site Recovery using the Azure portal.

> [!NOTE]
> This exercise is optional but depends on resources and an environment that was created in the previous unit. If you don't have an Azure account, you can read through the instructions to understand how to use backup virtual machines with Azure Backup.
> If you want to complete this exercise, but don't have an Azure subscription, or prefer not to use your account, you will need to create a [free account](https://azure.microsoft.com/free/?azure-portal=true) and first complete the exercises in the previous unit.

## Create a recovery services vault

1. If not already signed in, sign in to the [Azure portal](https://portal.azure.com?azure-portal=true) with your credentials.

1. On the Azure portal homepage, under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.
    :::image type="content" source="../media/azure-homepage.png" alt-text="Diagram showing Azure homepage.":::

1. In the left pane, select **IT & Management Tools**, then search for **Backup and Site Recovery**.

1. Select **Create**. The **Create Recovery Services vault** page appears.

1. On the **Basics** > **Project Details** tab, enter the following values for each setting.

    | Setting | Value |
    |---------|-------|
    | **Project Details** |
    | Subscription | *your subscription* |
    | Resource group | From the dropdown list, select **east-coast-rg** |

1. On the **Basics** > **Instance Details** tab, enter the following values for each setting.
    | Vault name | **asr-vault** |
    | Region | **(US) East US 2** |

1. Select **Review + create**, and after validation passes, then select **Create**. It may take a few minutes for the deployment to complete.

1. After deployment completes, select **Go to resource** to view your **asr-vault** Recovery Services vault.

## Enable replication

In this task, you'll replicate the two VMs that you created in the previous unit.

1. In the resources menu, under **Protected items**, select **Replicated items**. The **Replicated items** pane appears.

1. In the command bar, select **Replicate**, then select **Azure virtual machines** from the dropdown list. The **Enable replication** pane appears.

1. Enter the following values in the specified tabs, leaving other fields at their default values.
    1. On the **Source** tab, enter the following values for each setting:
        1. In **Region** enter **(US) West US 2**.
        1. Source resource group add **west-coast-rg**.
    1. On the **Virtual machines** tab, select both VMs **hr-records** and **patient-records**.
    1. On the **Replication settings** tab, enter the following values for each setting:
        1. In **Target location** enter **(US) East US 2**.
        1. In **Target subscription**, select **Customize**.
        1. In the **Target subscription** field, select your Azure subscription and select **OK**.

    :::image type="content" source="../media/source.png" alt-text="Screenshot showing the source options for replication.":::

1. Select **Next** to advance to the next tab.
1. On the **Enable replication** pane, select **Enable replication**. It may take a few moments for deployment to the east-coast-rg to complete.

## Monitor replication progress

You can review the progress of your site recovery job by selecting **Notifications** in the global controls in the upper right corner of your Azure portal.

1. In the **Notifications** pane, you will see that **Enabling replication for 2 vm(s)** is still running. Select the notification link.

1. The **Site Recovery jobs** lists all site recovery actions you have completed in this module.

1. In the jobs list, select the **In progress** link to view how the replication setup is progressing.

    :::image type="content" source="../media/4-site-recovery-jobs.png" alt-text="Screenshot of all the Site Recovery jobs.":::

1. You can select any of the listed jobs to view more details.

    :::image type="content" source="../media/4-replication-job.png" alt-text="Screenshot of the Enable replication job's progress.":::

Two of these jobs will take the most time to complete. If you select either of the **Enable replication** jobs, you'll see that the **Installing Mobility Service and preparing target** step can take between five to 10 minutes to finish.
