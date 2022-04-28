# Microsoft Purview Workshop

## What is Microsoft Purview?

Microsoft Purview is a unified data governance service that helps you manage and govern your on-premises, software-as-a-service (SaaS) data as well as multicloud (Azure, GCP, AWS, and many more cloud providers converged into a holistic unified Data Governance experience). Easily create a comprehensive, up-to-date map of your data landscape with automated data discovery, sensitive data classification, end-to-end data lineage, insights reports, business glossary, and approval workflows support. Empower data consumers, CDOs, data stewards, experts, BI and analytics admins to find valuable, trustworthy data and where it is located.

### How does Microsoft Purview benefit a CDO ?

Microsoft Purview helps CDOs, data analysts, BI engineers, data stewards, givernance experts and admins to answer these kinds of questions - 

- What data does my org have? 
- Where did this data originate?
- Where is data stored? 
- What’s my exposure to risk?
- Is my usage compliant? 
- How do I control access & use?
- What is required by regulation X (read GDPR, CELA, HIPAA) etc.?
- What data is being collected? 
- For what business purpose?
- Where is the sensitive data?   

## What is the main goal?
By the end of this session, you'll be able to understand and appreciate the salient features of Microsoft Purview service and how it encompasses a wide range of data sources across on-prem, multi-cloud (Azure, GCP, AWS), and 30+ varieties of databases and 10+ different file types including JSON, CSV, TSV, TXT, Parquet etc.

Goal: This learn module will walk you through the steps to set up Microsoft Purview and highlight the salient features supported by Microsoft Purview Data Catalog as we go along.

## Prerequisites

* An [Azure account](https://azure.microsoft.com/en-us/free/) with an active subscription.
* Owner permissions within a Resource Group to create resources and manage role assignments.

## Example Scenario
Scenario: The CDO (Chief Data Officer) of Fabrikam Corp Inc. wants to set up a daily dashbaord view of what percentage of data across the company's data estate is classified as "Sensitive" and "Confidential".

Problem: "Suppose you work at an athletic shoe company named Fabrikam Corp Inc as a business intelligence and analytics engineer. The CDO of your company has assigned to you the task of setting up a daily dashbaord view of what percentage of data across the company's data estate is classified as "Sensitive" and "Confidential".

Purview Solutioning: "During Purview's scanning process, Purview's classification engine will determine and apply classifications on each table or schema level hosted in the data estate. The Insights feature will help you build reports to view detailed analytics on each of the classified data sources, databases or files as well as what classifications and sensitivity labels were applied. You may even use Purview Insights APIs to build custom reports using and data visualization tools such as Power BI or Tableau etc."

## Prepare environment

To provide data for Microsoft Purview to classify, we will set up an ADLS Gen 2 account with some sample data. Follow the steps below to create the resource.

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
1. Download and install [Azure Storage Explorer](https://azure.microsoft.com/en-us/features/storage-explorer/).
1. Open Azure Storage Explorer.
1. Sign in to Azure via **View > Account Management > Add an account...**.
1. Download a copy of the **[Bing Coronavirus Query Set](https://github.com/tayganr/purviewlab/raw/main/assets/BingCoronavirusQuerySet.zip)** to your local machine. Note: This data set was originally sourced from [Microsoft Research Open Data](https://msropendata.com/datasets/c5031874-835c-48ed-8b6d-31de2dad0654).

1. Locate the downloaded zip file via File Explorer and unzip the contents by right-clicking the file and selecting **Extract All...**.

    :::image type="content" source="../media/02.10-explorer-unzip.png" alt-text="<alt text>":::

1. Select **Extract**.

    :::image type="content" source="../media/02.11-explorer-extract.png" alt-text="<alt text>":::

1. Open Azure Storage Explorer, select the Toggle Explorer icon, expand the Azure Subscription to find your Azure Storage Account. Right-click on Blob Containers and select **Create Blob Container**. Name the container **raw**.

    :::image type="content" source="../media/02.12-explorer-container.png" alt-text="<alt text>":::

1. With the container name selected, select the **Upload** button and select **Upload Folder...**.

    :::image type="content" source="../media/02.13-explorer-upload.png" alt-text="<alt text>":::

1. Select the **ellipsis** to select a folder.

    :::image type="content" source="../media/02.14-explorer-browse.png" alt-text="<alt text>":::

1. Navigate to the extracted **BingCoronavirusQuerySet** folder (e.g. Downloads\BingCoronavirusQuerySet) and select **Select Folder**.

    :::image type="content" source="../media/02.15-explorer-folder.png" alt-text="<alt text>":::

1. Select **Upload**.

    :::image type="content" source="../media/02.16-explorer-data.png" alt-text="<alt text>":::

1. Monitor the **Activities** until the transfer is complete.

    :::image type="content" source="../media/02.17-explorer-transfer.png" alt-text="<alt text>":::