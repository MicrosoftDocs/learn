First, let's create a Data Lake Storage named **demodw** in Azure Synapse Analytics.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, or prefer not to do the exercise in your account, read the instructions to understand how to create a blank data warehouse.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Select **Create a resource** in the upper-left corner of the Azure portal.

1. Select **Databases**, search for and select **Azure Synapse Analytics**. Select **Create**.

1. In the **Create Synapse workspace** panel, create an Azure Synapse Analytics workspace with the following settings:

    | Field       | Value |
    | ----------- | ----------- |
    | **Basics** tab > **Project details** section |
    | Subscription     | Name of the subscription you are using in this exercise. |
    | Resource group        | Select **Create new**, enter **mslearn-demodw**, and then select **OK**. |
    | **Workspace details** |
    | Workspace name | **sampledatawhxx**, where *xx* are your initials. |
    | Region | Select a region near to you. |
    | Select Data Lake Storage Gen2 | From subscription |
    | Account name | Select **Create new**, and enter *demodw*. |
    | File system name | Select **Create new**, and enter *demodw*. |
    
1. Select **Next: Security**. Enter the following settings:

    | Field       | Value |
    | ----------- | ----------- |
    | **Security** tab > **SQL administrator credentials** section |
    | Admin username   | dwdbadmin |
    | Password         | Pa55w.rd |
    | Confirm password | Pa55w.rd |

1. Select **Review + create**. The **Create Synapse workspace** pane reappears with a *Validation succeeded* notification.

1. In the **Create Synapse workspace** panel, select **Create** to start the deployment process. Deployment can take a few minutes.

Monitor the deployment process by selecting the notifications (bell) icon in the toolbar. You've successfully created an Azure Synapse Analytics workspace after it deploys.
