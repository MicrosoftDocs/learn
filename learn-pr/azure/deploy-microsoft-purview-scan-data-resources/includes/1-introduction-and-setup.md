## What is Microsoft Purview?

Microsoft Purview is a unified data governance service that helps you manage and govern your on-premises, software-as-a-service (SaaS), and multi-cloud data. Use Microsoft Purview to create a comprehensive, up-to-date map of your data landscape with automated data discovery, sensitive data classification, end-to-end data lineage, insights reports, and a business glossary. Empower data consumers, data officers, data stewards, experts, BI and analytics admins to find valuable, trustworthy data and where it is located.

### How does Microsoft Purview benefit an organization?

Microsoft Purview helps CDOs, data analysts, BI engineers, data stewards, governance experts and admins to answer these kinds of questions:

- What data does my org have?
- Where did this data come from?
- Where is data stored?
- What’s my exposure to risk?
- What is the data being used for?
- Is my data useage compliant?
- How do I control access & use?
- What is required by regulation X (read GDPR, CELA, HIPAA) etc.?
- For what business purpose?
- Where is the sensitive data?

## Example Scenario : 1

Scenario: The CDO (Chief Data Officer) of Fabrikam Corp Inc. wants to set up a daily dashboard view of what percentage of data across the company's data estate is classified as "Sensitive" and "Confidential".

Problem: "Suppose you work at an athletic shoe company named Fabrikam Corp Inc as a business intelligence and analytics engineer. The CDO of your company has assigned to you the task of setting up a daily dashboard view of what percentage of data across the company's data estate is classified as "Sensitive" and "Confidential".

Microsoft Purview Solution: "During Purview's scanning process, Purview's classification engine will determine and apply classifications on each table or schema level hosted in the data estate. The Insights feature will help you build reports to view detailed analytics on each of the classified data sources, databases or files as well as what classifications and sensitivity labels were applied. You may even use Purview Insights APIs to build custom reports using and data visualization tools such as Power BI or Tableau etc."

Getting Started: Before deploying Microsoft Purview in your environment, it is best to start with a proof of concept. In this guide we will develop a small proof of concept to start Fabrikam on their journey to using Microsoft Purview to govern their data estate.

## Example Scenario : 2

The Fabricam Corp shoe company has expanded rapidly over the last year, going from a handful of employees and a single data lake, to a multi-regional business with data across several platforms. In the expansion, keeping track of what data Fabricam stores and where has mostly fallen to department heads. Data officers often have to repeat security procedures as new data repositories surface, data experts and officers are flooded with requests for data access and questions about their data. Before the company can go international, Fabricam needs a solution to help them understand and take command of their full data estate.

Microsoft Purview will allow Fabricam to register all their data sources, manage access and data discovery by department, and even understand where data comes from and what kind of data it is.

You've been requested to create a Microsoft Purview proof of concept for Fabricam, to understand how to deploy Microsoft Purview in an environment and onboard resources.

## What is the main goal?

By the end of this session, you'll have deployed a Microsoft Purview account in your Azure environment, registered an Azure Data Lake Gen 2 Storage Account, and scanned the storage account so Microsoft Purview can classify the data, and add the metadata to its data map.

## Prerequisites

In order to proceed with the hands-on components of this module, you will require the following:

- An [Azure account](https://azure.microsoft.com/free/) with an active subscription.
- Owner permissions within a Resource Group to create resources and manage role assignments.

## Prepare environment

To provide data for Microsoft Purview to classify, we'll set up an ADLS Gen 2 account with some sample data. Follow the steps below to create the resource.

1. Sign in to the [Azure portal](https://portal.azure.com) with your Azure account.

1. Select **Create a resource**.
1. Search for and select **Storage account**.
1. Select the **Storage account** plan, and select **Create**.
1. Select an existing resource group, or create a new one.
1. Create a unique storage account name.
1. Select **Standard** performance.
1. Select **Locally-redundant storage**.NET
1. Select **Next: Advanced**.
1. Select **Enable hierarchical namespace**.
1. Select **Review + create**.
1. Download and install [Azure Storage Explorer](https://azure.microsoft.com/features/storage-explorer/).
1. Open Azure Storage Explorer.
1. Sign in to Azure via **View > Account Management > Add an account...**.
1. Download a copy of the **[Bing Coronavirus Query Set](https://github.com/tayganr/purviewlab/raw/main/assets/BingCoronavirusQuerySet.zip)** to your local machine. Note: This data set was originally sourced from [Microsoft Research Open Data](https://msropendata.com/datasets/c5031874-835c-48ed-8b6d-31de2dad0654).

1. Locate the downloaded zip file via File Explorer and unzip the contents by right-clicking the file and selecting **Extract All...**.

    :::image type="content" source="../media/02.10-explorer-unzip.png" alt-text="Screenshot of the BingCoronavirusQuerySet zip file with the menu open and Extract All highlighted.":::

1. Select **Extract**.

    :::image type="content" source="../media/02.11-explorer-extract.png" alt-text="Screenshot of the extract menu with the Extract button highlighted.":::

1. Open Azure Storage Explorer, select the Toggle Explorer icon, expand the Azure Subscription to find your Azure Storage Account. Right-click on Blob Containers and select **Create Blob Container**. Name the container **raw**.

    :::image type="content" source="../media/02.12-explorer-container.png" alt-text="Screenshot of the Microsoft Azure Storage Explorer":::

1. With the container name selected, select the **Upload** button and select **Upload Folder...**.

    :::image type="content" source="../media/02.13-explorer-upload.png" alt-text="<alt text>":::

1. Select the **ellipsis** to select a folder.

    :::image type="content" source="../media/02.14-explorer-browse.png" alt-text="<alt text>":::

1. Navigate to the extracted **BingCoronavirusQuerySet** folder (for example, Downloads\BingCoronavirusQuerySet) and select **Select Folder**.

    :::image type="content" source="../media/02.15-explorer-folder.png" alt-text="<alt text>":::

1. Select **Upload**.

    :::image type="content" source="../media/02.16-explorer-data.png" alt-text="<alt text>":::

1. Monitor the **Activities** until the transfer is complete.

    :::image type="content" source="../media/02.17-explorer-transfer.png" alt-text="<alt text>":::