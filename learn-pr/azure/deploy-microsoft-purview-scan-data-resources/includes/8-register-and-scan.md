<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    1. Understand what registration and scanning are.
    2. Understand what is necessary to complete each process.
    3. Understand what you need to do/where you need to start for any data type.
-->

# Register and scan

Now that \<Corporation Name> has a Microsoft Purview account and created collections that reflect their business structure, the next step to understanding their data is to connect Microsoft Purview to their data sources and giving Microsoft Purview access to process these sources.

This connection is a two step process in Microsoft Purview:

1. Registration - maps data sources in your environment to your collections
1. Scanning - classifies your data and captures technical metadata (file names, file size, columns, data types, and so on)

Microsoft Purview has many applications and features to help you understand your data, but registration and scanning are the two most important processes. This is how your data is aligned with your business, how permission and data discovery can be strategized for your organization, and data assets (for example: files, resource sets, or tables) are described and classified.

This is how your data map and data catalog are populated, and all of Microsoft Purview's other features build off of this connection.

## Registration

Registering a data source tells Microsoft Purview where to find that data source, and associates your source to one of your collections. Think of it as providing an address book for your collection.  This doesn't affect the data in the source: your data remains in it's current location.

You'll want to chose a collection that relates your data source to its logical location in your organization. Where that will be depends on how you've structured your collections.

In our example \<Corporation Name> has \<these collections>. Registering a resource to \<restricted low level collection> will restrict discovery to that privileged group, which may be useful for sensitive data repositories. Registering the resource to \<higher level collection> will allow all users in that \<region or organization> to discover and use the data source. This would be useful for general data used by many teams for reporting.

When you're choosing which collection to register your data source to, consider who might want to access it, the sensitivity of the data, and useability of the data.

Once you've decided on a collection, we can register the data source from within the Microsoft Purview Governance Portal by going to the Data Map and selecting **Register**

<!-- SCREENSHOT -->

Microsoft Purview supports an array of data sources that span on-premises, multi-cloud, and software-as-a-service (SaaS) options. For any one of these data sources, information is needed to be able to register the source, and different information is required depending on the source. For example, if your data source resides in your Azure subscription, you will choose the necessary subscription, storage source name, and the collection where it will reside.

<!-- SCREENSHOT -->

For all data sources available in Microsoft Purview, requirements for registration depend on where the data is located, and what information is needed to build a connection. Each source page in the documentation will tell you what information you'll need.
For example, sources in Azure typically require a subscription ID and the name of the resource, while data stored in Amazon S3 bucket requires a bucket URL.

Once you have provided these details and select **Register** your data source will be listed under your selected collection.

<!-- SCREENSHOT -->

## Scanning

Scanning is the process Microsoft Purview uses to access your data sources to gather technical metadata, schema information, and classify your data assets. This is one of the most important actions within Microsoft Purview. Scanning data assets allows you to understand:

- What kind of data is stored in your data sources.
- How that data is structured.
- If any data is sensitive.

This will allow you to audit and govern your data sources without having to manually investigate each individual file and source.

### Authentication

While the registration process was straight forward, the scanning process is a little more complex. Registration only required the connection information, or the address, of your data source. Scanning requires that Microsoft Purview is able to authenticate directly with your data source to be able to access the metadata and schema information. Again, this does not affect the data in the source, or move it, but it does require that Microsoft Purview has permissions to the source. Depending on your network and security, this can be a complex process. You can store the credentials in an Azure Key Vault for security and ease of access by your scan rules.

Each data source has different authentication requirements. Data sources outside of Azure will use their native authentication systems that will require a profile to be in place with the details provided to Microsoft Purview. For example, if connecting to Snowflake, basic authentication is supported and you'll provide a username and password for Microsoft Purview to connect with your Snowflake source.

For authentication within Azure there are several options available:

- Microsoft Purview system or user assigned Managed Identity
- Account Key (using Key Vault)
- Service Principal (using Key Vault)

If you're enabling connectivity for the first time, it can be difficult to choose between these different kinds of authentication. Each source will have its own best practices, that you can find in the documentation, but here are some good general guidelines:

- **Microsoft Purview system or user assigned Managed Identity** - This authentication method is usually the recommended method for Azure sources, and is one of the most straight-forward authentication methods between Azure resources. A managed identity is an identity in active directory that can be assigned roles just like a user or a group, but rather than being associated with a person, it is associated directly with an Azure resource. In this instance, Microsoft Purview. This allows Microsoft Purview to directly authenticate against your resource, rather than using a go-between identity. This allows you assign permissions to your Microsoft Purview account, instead of needing to manage a separate role. A system-assigned managed identity is created automatically when a resource is deployed. User-assigned managed identities can be used in the same way, but are user created, assigned, and managed, rather than being managed by Azure.

- **Service Principal** - A service principal is a good option if you need a single role to authenticate against multiple resources in your Azure subscription. A service principal is an application that functions as an identity that you can use to authenticate against Azure resources. Once it is created, you can assign roles to a service principal like you would for any user or group. One benefit of using a service principal, is that it has certificates and secrets that can be set to expire after a set time limit.

- **Account Key** - for storage accounts in Azure, an account key gives you general access to a storage account without needing to provide authorization to a specific role or user. These keys can be rotated and regenerated to maintain security for your storage accounts. Account keys can be useful to securely manage broad-spectrum access across multiple applications without needing to provide roles for individual users.

Once you've decided on authentication method and gathered the connection information, you can authenticate with your source through the Azure Portal. In your Data Map in the Microsoft Purview Governance Portal, select your data source and select **New Scan**.

<!-- SCREENSHOT -->

Initially you will be able to input your credentials and test your connection. Often this is where users run into trouble. If you do:

1. Check your credentials to confirm that they are correct.
1. Check documentation for your source to confirm any special cases or unsupported scenarios.
1. Confirm network connectivity between Azure and your source. Source documentation should have further information to check this connection as well.

### Scanning 

Once your credentials are successfully validated, it's time to set up your scan. Scanning has two three parts: scope, rule set, and schedule.

The **scope** of a scan determines what parts of a data source you want to scan. For example, in Data Lake you can choose to scan an entire data lake, or a subset of folders.

<!-- SCREENSHOT -->

Choosing a subset of folders might be useful if your organization has a single data lake that is organized by team or effort. The scope will be dependant on the data source type.

The **scan rule set** is a set of instructions that allow you customize the kinds of data that will have their metadata and schema extracted, as well as the kinds of data that will be extracted.

For example, the default Data Lake scan rule set extracts metadata from these kinds of files:

CSV, JSON, PSV, SSV, TSV, GZIP, TXT, XML, PARQUET, AVRO, ORC, DOC, DOCM, DOCX, DOT, ODP, ODS, ODT, PDF, POT, PPS, PPSX, PPT, PPTM, PPTX, XLC, XLS, XLSB, XLSM, XLSX, XLT

It also tags data with all available classifications. This can be useful for broad-spectrum scanning. But if you are storing a certain kind of information, or only a certain file type, you can streamline the scanning process by creating a custom scan rule set. This allows you to choose file and data types to extract metadata from during a scan, as well as classification types you're looking for. For example, if your data is only for customers in the Americas, you can use a custom scan rule set to exclude European drivers license number from your scan, as your data won't contain that information.

The **schedule** of your scan will determine how often your scan will run. This is an important decision as scanning is how your Microsoft Purview data catalog maintains an accurate understanding of your data landscape, but Microsoft Purview is also billed by compute power used during scanning.

There are two types of scans: Once and reoccurring.

- **Once** - This scan will only run one time and is useful for proof of concept scenarios, or for legacy datasets that will remain completely unchanged.
- **Recurring** - This scan will be set to run on a schedule, either monthly or weekly, at a specific time. Schedule a recurring scan for data sets that are regularly updated or changing. This will allow you to maintain an accurate picture of your data landscape, and audit sensitive data.

Here are some best practices to consider when scheduling your scan:

- Run scans during non-business or off-peak hours to avoid process overhead.
- For some sources, when using a recurring scan, the first scan scans the entire source, but all scans after that scan only new or updated information.
- Scan frequency should align with your change management schedule for a source.

Once you have determined your scope, rule set, and schedule select save and run and your scan will begin running.

<!-- SCREENSHOT -->

Depending on the size of your data source and the scope of your scan, a scan can take a long time to run. You can check its progress in your data source details.

<!-- SCREENSHOT -->

Select Refresh to periodically update the status of the scan.

> [!NOTE]
> After a scan has completed, Microsoft Purview runs an ingestion process where it adds all the new metadata and information into the catalog. This process depends on the size of the source data as well, and you won't see new assets in your Microsoft Purview catalog until this process is complete.

Once the scan and ingestion are complete, all your data source's metadata is added to your data catalog where it can be audited, managed, and discovered.
