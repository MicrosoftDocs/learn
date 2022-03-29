
After data sources are registered in your Azure Purview account, the next step is to scan the data sources. The scanning process establishes a connection to the data source and captures technical metadata like names, file size, columns, and so on. It also extracts schema for structured data sources, applies classifications on schemas, and applies sensitivity labels if your Azure Purview account is connected to a Microsoft 365 Security and Compliance Center (SCC). The scanning process can be triggered to run immediately or can be scheduled to run on a periodic basis to keep your Azure Purview account up to date.

For each scan there are customizations you can apply so that you're only scanning your sources for the information you need.

Choose an authentication method for your scans
Azure Purview is secure by default. No passwords or secrets are stored directly in Azure Purview, so you’ll need to choose an authentication method for your sources. There are four possible ways to authenticate your Azure Purview account, but not all methods are supported for each data source.

Managed Identity
Service Principal
SQL Authentication
Account Key or Basic Authentication
Whenever possible, a Managed Identity is the preferred authentication method because it eliminates the need for storing and managing credentials for individual data sources. This can greatly reduce the time you and your team spend setting up and troubleshooting authentication for scans. When you enable a managed identity for your Azure Purview account, an identity is created in Azure Active Directory and is tied to the lifecycle of your account.

Scope your scan
When scanning a source, you have a choice to scan the entire data source or choose only specific entities (folders/tables) to scan. Available options depend on the source you're scanning, and can be defined for both one-time and scheduled scans.

For example, when creating and running a scan for an Azure SQL Database, you can choose which tables to scan, or select the entire database.

Scan rule set
A scan rule set determines the kinds of information a scan will look for when it's running against one of your sources. Available rules depend on the kind of source you're scanning, but include things like the file types you should scan, and the kinds of classifications you need.

There are system scan rule sets already available for many data source types, but you can also create your own scan rule sets to tailor your scans to your organization.

Schedule your scan
Azure Purview gives you a choice of scanning weekly or monthly at a specific time you choose. Weekly scans may be appropriate for data sources with structures that are actively under development or frequently change. Monthly scanning is more appropriate for data sources that change infrequently. A good best practice is to work with the administrator of the source you want to scan to identify a time when compute demands on the source are low.

The technical metadata or classifications identified by the scanning process are then sent to Ingestion. The ingestion process is responsible for populating the data map and is managed by Azure Purview. Ingestion analyses the input from scan, applies resource set patterns, populates available lineage information, and then loads the data map automatically. Assets/schemas can be discovered or curated only after ingestion is complete. So, if your scan is completed but you haven't seen your assets in the data map or catalog, you'll need to wait for the ingestion process to finish.


To scan a source, Azure Purview requires a set of credentials. For Azure Data Lake Storage Gen2, Azure Purview supports the following authentication methods.

Managed Identity (recommended)
Service Principal
Account Key
In this module we will walk through how to grant the Azure Purview Managed Identity the necessary access to successfully configure and run a scan.

Navigate to your Azure Data Lake Storage Gen2 account (e.g. pvlab{randomId}adls) and select Access Control (IAM) from the left navigation menu.

Azure Purview

Click Add role assignments.

Azure Purview

Filter the list of roles by searching for Storage Blob Data Reader, click the row to select the role, and then click Next.

Access Control Role

Under Assign access to, select Managed identity, click + Select members, select Purview account from the Managed Identity drop-down menu, select the managed identity for your Azure Purview account (e.g. pvlab-{randomId}-pv), click Select. Finally, click Review + assign.

Access Control Members

Click Review + assign once more to perform the role assignment.

Access Control Assign

To confirm the role has been assigned, navigate to the Role assignments tab and filter the Scope to This resource. You should be able to see that the Azure Purview managed identity has been granted the Storage Blob Data Reader role.

Role Assignment

↥ back to top
2. Upload Data to Azure Data Lake Storage Gen2 Account
Before proceeding with the following steps, you will need to:

Download and install Azure Storage Explorer.
Open Azure Storage Explorer.
Sign in to Azure via View > Account Management > Add an account....
Download a copy of the Bing Coronavirus Query Set to your local machine. Note: This data set was originally sourced from Microsoft Research Open Data.

Locate the downloaded zip file via File Explorer and unzip the contents by right-clicking the file and selecting Extract All....

Extract zip file

Click Extract.

Extract

Open Azure Storage Explorer, click on the Toggle Explorer icon, expand the Azure Subscription to find your Azure Storage Account. Right-click on Blob Containers and select Create Blob Container. Name the container raw.

Create Blob Container

With the container name selected, click on the Upload button and select Upload Folder....

Upload Folder

Click on the ellipsis to select a folder.

Browse

Navigate to the extracted BingCoronavirusQuerySet folder (e.g. Downloads\BingCoronavirusQuerySet) and click Select Folder.

Folder

Click Upload.

Upload

Monitor the Activities until the transfer is complete.

Transfer Complete

↥ back to top
3. Create a Collection
💡 Did you know?

Collections in Azure Purview can be used to organize data sources, scans, and assets in a hierarchical model based on how your organization plans to use Azure Purview. The collection hierarchy also forms the security boundary for your metadata to ensure users don't have access to data they don't need (e.g. sensitive metadata).

For more information, check out Collection Architectures and Best Practices.

Open Purview Studio, navigate to Data Map > Collections, and click Add a collection.

New Collection

Provide the collection a Name (e.g. Contoso) and click Create.

New Collection

↥ back to top
4. Register a Source (ADLS Gen2)
Open Purview Studio, navigate to Data Map > Sources, and click on Register.

Register

Select Azure Data Lake Storage Gen2 and click Continue.

Sources

Select the Azure subscription, Storage account name, Collection, and click Register.

💡 Did you know?

At this point, we have simply registered a data source. Assets are not written to the catalog until after a scan has finished running.

Source Properties

↥ back to top
5. Scan a Source with the Azure Purview Managed Identity
Open Purview Studio, navigate to Data Map > Sources, and within the Azure Data Lake Storage Gen2 tile, click the New Scan button.

New Scan

Click Test connection to ensure the Azure Purview managed identity has the appropriate level of access to read the Azure Data Lake Storage Gen2 account. If successful, click Continue.

Test Connection

Expand the hierarchy to see which assets will be within the scans scope, and click Continue.

Scan Scope

Select the system default scan rule set and click Continue.

💡 Did you know?

Scan Rule Sets determine which File Types and Classification Rules are in scope. If you want to include a custom file type or custom classification rule as part of a scan, a custom scan rule set will need to be created.

Scan rule set

Select Once and click Continue.

Scan Trigger

Click Save and Run.

Run Scan

To monitor the progress of the scan run, click View Details.

View Details

Click Refresh to periodically update the status of the scan. Note: It will take approximately 5 to 10 minutes to complete.

Monitor Scan

↥ back to top
6. View Assets
Navigate to Purview Studio > Data catalog, and perform a wildcard search by typing the asterisk character (*) into the search box and hitting the Enter key to submit the query.



You should be able to see a list of assets within the search results, which is a result of the scan.



