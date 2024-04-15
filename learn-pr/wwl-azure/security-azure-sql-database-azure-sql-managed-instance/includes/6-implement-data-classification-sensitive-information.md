## Manage data sources in Microsoft Purview

1.  Register
2.  Scan and Ingest
3.  Classify

Labeling in the Microsoft Purview Data Map is currently in PREVIEW.

### Supplemental Terms of Use for Microsoft Azure Previews

Azure may include preview, beta, or other pre-release features, services, software, or regions offered by Microsoft for optional evaluation ("Previews"). Previews are licensed to you as part of your agreement governing use of Azure, and subject to terms applicable to "Previews".

Certain named Previews are subject to additional terms set forth below, if any. These Previews are made available to you pursuant to these additional terms, which supplement your agreement governing use of Azure. Capitalized terms not defined herein shall have the meaning set forth in your agreement. If you do not agree to these terms, do not use the Preview(s).<br>

### Register a new source

> [!NOTE]
> You'll need to be a Data Source Admin and one of the other Purview roles (for example, Data Reader or Data Share Contributor) to register a source and manage it in the Microsoft Purview governance portal.

In Microsoft Purview, after you register your data source, you can scan your source to capture technical metadata, extract schema, and apply classifications to your data.

#### Prerequisites

Here's a list of all the sources that are currently available to register and scan in Microsoft Purview.

Before you can scan your data source, you must take these steps:

1.  Register your data source - This essentially gives Microsoft Purview the address of your data source, and maps it to a collection in the Microsoft Purview Data Map.
2.  Consider your network and choose the right integration runtime configuration for your scenario.
3.  Consider what credentials you're going to use to connect to your source. All source pages will have a Scan section that will include details about what authentication types are available.

### Scans and ingestion in Microsoft Purview

Scanning and Ingestion features in Microsoft Purview connect your Microsoft Purview account to your sources to populate the data map and data catalog so you can begin exploring and managing your data through Microsoft Purview.

 -  Scanning captures metadata from data sources and brings it to Microsoft Purview.<br>
 -  Ingestion processes metadata and stores it in the data catalog from both:
     -  Data source scans - scanned metadata is added to the Microsoft Purview Data Map.
     -  Lineage connections - transformation resources add metadata about their sources, outputs, and activities to the Microsoft Purview Data Map.

### Scanning

After data sources are registered in your Microsoft Purview account, the next step is to scan the data sources. The scanning process establishes a connection to the data source and captures technical metadata like names, file size, columns, and so on. It also extracts schema for structured data sources, applies classifications on schemas, and applies sensitivity labels if your Microsoft Purview Data Map is connected to a Microsoft Purview compliance portal. The scanning process can be triggered to run immediately or can be scheduled to run on a periodic basis to keep your Microsoft Purview account up to date.

For each scan, there are customizations you can apply so that you're only scanning information you need, rather than the whole source.

### Create a scan rule set

In a Microsoft Purview catalog, you can create scan rule sets to enable you to quickly scan data sources in your organization.

A scan rule set is a container for grouping a set of scan rules together so that you can easily associate them with a scan. For example, you might create a default scan rule set for each of your data source types, and then use these scan rule sets by default for all scans within your company. You might also want users with the right permissions to create other scan rule sets with different configurations based on business need.

### System scan rule sets

System scan rule sets are Microsoft-defined scan rule sets that are automatically created for each Microsoft Purview catalog. Each system scan rule set is associated with a specific data source type. When you create a scan, you can associate it with a system scan rule set. Every time Microsoft makes an update to these system rule sets, you can update them in your catalog, and apply the update to all the associated scans.

### Classify - Data classification in the Microsoft Purview governance portal

Data classification in the Microsoft Purview governance portal is a way of categorizing data assets by assigning unique logical tags or classes to the data assets. Classification is based on the business context of the data. For example, you might classify assets by *Passport Number*, *Driver's License Number*, *Credit Card Number*, *SWIFT Code*, *Person’s Name*, and so on.

When you classify data assets, you make them easier to understand, search, and govern. Classifying data assets also helps you understand the risks associated with them. This in turn can help you implement measures to protect sensitive or important data from ungoverned proliferation and unauthorized access across the data estate.

The Microsoft Purview Data Map provides an automated classification capability while you scan your data sources. You get more than 200+ built-in system classifications and the ability to create custom classifications for your data. You can classify assets automatically when they're ingested as part of a configured scan, or you can edit them manually in the Microsoft Purview governance portal after they're scanned and ingested.

### Uses of classification

Classification is the process of organizing data into *logical categories* that make the data easy to retrieve, sort, and identify for future use. This can be important for data governance. Among other reasons, classifying data assets is important because it helps you:

 -  Narrow down the search for data assets that you're interested in.
 -  Organize and understand the variety of data classes that are important in your organization and where they're stored.
 -  Understand the risks associated with your most important data assets and then take appropriate measures to mitigate them.

### Types of classification

The Microsoft Purview governance portal supports both system and custom classifications.

 -  System classifications: 200+ system classifications supported are out of the box.<br>

    In the example in the preceding image, Person’s Name is a system classification. System classification has the thunderbolt icon along with classification name. Hovering over the classification itself provides more details on the type of classification, and more details on how it was applied<br>

 -  Custom classifications: You can create custom classifications when you want to classify assets based on a pattern or a specific column name that's unavailable as a system classification. Custom classification rules can be based on a regular expression pattern or dictionary.<br>

    Let's say that the Employee ID column follows the EMPLOYEE\{GUID\} pattern (for example, EMPLOYEE9c55c474-9996-420c-a285-0d0fc23f1f55). You can create your own custom classification by using a regular expression, such as \\^Employee\\\[A-Za-z0-9\\\]\{8\}-\\\[A-Za-z0-9\\\]\{4\}-\\\[A-Za-z0-9\\\]\{4\}-\\\[A-Za-z0-9\\\]\{4\}-\\\[A-Za-z0-9\\\]\{12\}\\$.

> [!NOTE]
> Sensitivity labels are different from classifications. Sensitivity labels categorize assets in the context of data security and privacy, such as *Highly Confidential*, *Restricted*, *Public*, and so on. To use sensitivity labels in the Microsoft Purview Data Map, you'll need at least one Microsoft 365 license or account within the same Microsoft Entra tenant as your Microsoft Purview Data Map.<br>

### Labeling in the Microsoft Purview Data Map

> [!IMPORTANT]
> Labeling in the Microsoft Purview Data Map is currently in PREVIEW. The Supplemental Terms of Use for Microsoft Azure Previews include additional legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.<br>

To get work done, people in your organization collaborate with others both inside and outside the organization. Data doesn't always stay in your cloud, and often roams everywhere, across devices, apps, and services. When your data roams, you still want it to be secure in a way that meets your organization's business and compliance policies.

Applying sensitivity labels to your content enables you to keep your data secure by stating how sensitive certain data is in your organization. It also abstracts the data itself, so you use labels to track the type of data, without exposing sensitive data on another platform.<br>

For example, applying a sensitivity label ‘highly confidential’ to a document that contains social security number and credit card numbers helps you identify the sensitivity of the document without knowing the actual data in the document.

### Benefits of labeling in Microsoft Purview

Microsoft Purview allows you to apply sensitivity labels to assets, enabling you to classify and protect your data.

 -  Label travels with the data: The sensitivity labels created in Microsoft Purview Information Protection can also be extended to the Microsoft Purview Data Map, SharePoint, Teams, Power BI, and SQL. When you apply a label on an office document and then scan it into the Microsoft Purview Data Map, the label will be applied to the data asset. While the label is applied to the actual file in Microsoft Purview Information Protection, it's only added as metadata in the Microsoft Purview map. While there are differences in how a label is applied to an asset across various services/applications, labels travel with the data and is recognized by all the services you extend it to.<br>
 -  Overview of your data estate: Microsoft Purview provides insights into your data through pre-canned reports. When you scan data into the Microsoft Purview Data Map, we hydrate the reports with information on what assets you have, scan history, classifications found in your data, labels applied, glossary terms, etc.
 -  Automatic labeling: Labels can be applied automatically based on sensitivity of the data. When an asset is scanned for sensitive data, autolabeling rules are used to decide which sensitivity label to apply. You can create autolabeling rules for each sensitivity label, defining which classification/sensitive information type constitutes a label.
 -  Apply labels to files and database columns: Labels can be applied to files in storage such as Azure Data Lake or Azure Files as well as to schematized data such as columns in Azure SQL Database.

**Sensitivity labels** are tags that you can apply on assets to classify and protect your data.

### How to apply labels to assets in the Microsoft Purview Data Map

Being able to apply labels to your asset in the data map requires you to perform the following steps:<br>

1.  Create new or apply existing sensitivity labels in the Microsoft Purview compliance portal. Creating sensitivity labels include autolabeling rules that tell us which label should be applied based on the classifications found in your data.<br>
2.  Register and scan your asset in the Microsoft Purview Data Map.
3.  Microsoft Purview applies classifications: When you schedule a scan on an asset, Microsoft Purview scans the type of data in your asset and applies classifications to it in the data map. Application of classifications is done automatically by Microsoft Purview, there's no action for you.
4.  Microsoft Purview applies labels: Once classifications are found on an asset, Microsoft Purview will apply labels to the assets depending on autolabeling rules. Application of labels is done automatically by Microsoft Purview, there's no action for you as long as you have created labels with autolabeling rules in step 1.

> [!NOTE]
> **Autolabeling rules** are conditions that you specify, stating when a particular label should be applied. When these conditions are met, the label is automatically assigned to the data. When you create your labels, make sure to define autolabeling rules for both files and database columns to apply your labels automatically with each scan.<br>

### Labeling for SQL databases

In addition to the Microsoft Purview Data Map's labeling for schematized data assets, Microsoft also supports labeling for SQL database columns using the SQL data classification in SQL Server Management Studio (SSMS). While Microsoft Purview uses the global sensitivity labels, SSMS only uses labels defined locally.

Labeling in Microsoft Purview and labeling in SSMS are separate processes that don't currently interact with each other. Therefore, labels applied in SSMS are not shown in Microsoft Purview, and vice versa. We recommend Microsoft Purview for labeling SQL databases, because the labels can be applied globally, across multiple platforms.
