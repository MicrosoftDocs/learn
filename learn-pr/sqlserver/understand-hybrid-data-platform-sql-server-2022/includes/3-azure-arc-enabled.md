---
ms.custom:
  - build-2023
---
Azure Arc-enabled SQL Server enables you to manage and govern a hybrid infrastructure regardless of the physical location of the database infrastructure. Moreover, Azure Arc-enabled SQL Server allows organizations to extend their on-premises database environment to Azure, providing a unified management experience. 

With Azure Arc-enabled SQL Server, you can take advantage of several Azure services while still operating on-premises.

In addition to free inventory management, Azure Arc-enabled SQL Server now also offers automated backups and patching. This means that you can easily keep track of your SQL Server instances and ensure that they are always up-to-date and backed up, without having to manually perform these tasks.

Let's review some important features available on Azure Arc-enabled SQL Server.

### Cost efficiency with pay-as-you-go model

The pay-as-you-go model for Azure Arc-enabled SQL Server is a cost-effective and flexible option that enables you to pay for SQL Server software and track usage directly through **Cost Management** in Azure portal. This model helps to manage expenses more effectively by ensuring you're compliant with SQL Server licenses requirements.

SQL Server 2022 allows you to select the pay-as-you-go billing option during setup. In addition, you can also review the billing option in the overview blade of Arc-enabled SQL Server as shown:

:::image type="content" source="../media/module-2-overview-azure-sql-arc-payg.png" alt-text="Screenshot showing the Overview blade highlighting the license type option.":::

To learn more about the benefits of using Azure Hybrid Benefit to optimize existing SQL Server licensing investments, see [Manage SQL Server license and billing options](/sql/sql-server/azure-arc/manage-license-type).

### Streamline your SQL Server estate with Best Practices Assessment

Best Practices Assessment provides valuable insights into the overall configuration estate of SQL Server instances and databases. By identifying areas for improvement and implementing recommended best practices, organizations can ensure their databases comply with product best practices.

Assessments can take anywhere from a few minutes to an hour and may cause up to a 5-10% CPU impact on the server.

To configure, run and view your best practices assessment, go to your Arc-enabled SQL Server resource on Azure portal, and select **Best practices assessment** in the left pane.

:::image type="content" source="../media/module-2-best-practice-assessment.png" alt-text="Screenshot showing the best practices assessment option on Azure portal.":::

You can also change the default schedule for the assessment, which gives the option to schedule it in a more preferable timeframe.

### Azure Active Directory authentication

SQL Server 2022 introduces a new feature that allows you to use Azure Active Directory for authentication. Use this feature to create a secure connection with Azure Arc-enabled SQL Server for authentication purposes.

### Secure Azure Arc-enabled SQL Server with Microsoft Defender for Cloud

Microsoft Defender for Cloud is a cloud-based security solution designed to provide advanced protection against multiple attacks and vulnerabilities. It's a comprehensive solution that uses intelligent capabilities to detect and respond to threats in real-time.

One of the major advantages of Microsoft Defender for Cloud is its centralized management feature, which provides a single place for managing security across multiple cloud-based environments. This centralized view simplifies security management and seamlessly integrates with other Microsoft security tools for comprehensive protection, such as Azure Sentinel, to provide a comprehensive security solution for your organization.

Microsoft Defender for Cloud is available for Azure Arc-enables SQL Servers. By configuring it, you'll safeguard your database estate and get a list of recommended security actions to minimize your overall exposure.

To learn more about how to configure Arc-enabled SQL Server with Microsoft Defender for Cloud, see [Protect Azure Arc-enabled SQL Server with Microsoft Defender for Cloud](/sql/sql-server/azure-arc/configure-advanced-data-security).

### Configure your Azure Arc-enabled SQL Server

To configure Azure Arc-enabled SQL Server for the first time, you need to generate onboarding scripts responsible to install Azure extension for SQL Server on the host machine. You also need to make sure the host machine has network connectivity to Azure and to your target SQL Server machine. 

Before you add an Azure Arc-enabled SQL Server, you need:

- A virtual or physical machine running SQL Server 2022
- A user or service principal with the following permissions:
  - `Azure Connected Machine Onboarding` role
  - `Microsoft.AzureArcData/register/action`
  - `Microsoft.HybridCompute/machines/extensions/read`
  - `Microsoft.HybridCompute/machines/extensions/write`
- PowerShell
- Register Microsoft.AzureArcData and Microsoft.HybridCompute resource providers

You can follow the steps below to enable Azure Arc for SQL Server using the connected manually approach:

1. Navigate to the **Azure Arc > SQL Server** section in the Azure portal. 
1. Select **+ Add**.
1. Select **Connect Servers** under **Connect SQL Server to Azure Arc**. 
1. Complete and review the required information, including subscription, resource group, region, operating system, proxy, and license type. 
1. Select **Run script**, and download it.
1. Execute the script on the host machine.

For more details on how to configure Azure Arc-enabled SQL Server, see [Connect your SQL Server to Azure Arc](/sql/sql-server/azure-arc/connect).

### Deployments options

Depending on your deployment needs, you may choose between interactive or scalable methods to onboard SQL Server instances to Azure Arc, which can handle multiple instances simultaneously and increase productivity. 

To use these methods, you'll need to install the Azure Connected Machine agent along with the Azure extension for SQL Server, which provides direct connectivity to Azure.

#### Interactively

There are three interactively onboarding methods for adding existing SQL Server instances to Azure Arc:

- [Connect SQL Server to Azure Arc](/sql/sql-server/azure-arc/connect)
- [Connect SQL Server to Azure Arc on a server already connected to Azure Arc](/sql/sql-server/azure-arc/connect)
- Connect through an [installer](/sql/sql-server/azure-arc/connect-with-installer)

#### At scale

There are three scalable onboarding options for adding existing SQL Server instances to Azure Arc:

- Using the [automatic Arc-enabled SQL Server registration](/sql/sql-server/azure-arc/connect-at-scale-policy?#connect-at-scale-using-the-automatic-arc-enabled-sql-server-registration-method-recommended) method
- Using a [script](/sql/sql-server/azure-arc/connect-at-scale-script)
- Using a [configuration Manager custom task sequence](/sql/sql-server/azure-arc/onboard-configuration-manager-custom-task)

Both interactive or scalable methods allow you to manage your SQL Server instances that are hosted outside of Azure by using the connected machine agent and the Azure Arc extension.

### Current features and capabilities

For the current list of features and capabilities for Azure Arc-enabled SQL Server, see [Features available by operating system](/sql/sql-server/azure-arc/overview#feature-availability-by-operating-system).
