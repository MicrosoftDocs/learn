## Roles and responsibilities

Since we're using several technologies in this module, let's establish the specific roles and responsibilities of each piece of technology. In this way, you can understand the value that each brings to the data technology stack.

### Azure Data Lake Storage Gen2

In this module, ADLS (Azure Data Lake Storage) Gen2 is playing the role of storage for raw data and the landing zone for mastered data in a file format. We're making the assumption that your company-wide data is landing in a single ADLS Gen2 instance and uses a common file format. We assume that Azure Data Factory is used to pull the data from these systems, and that there's a regular schedule for these integration jobs. The schedule ensures that we're pulling in the delta changes of data on a regular cadence. Also, we're assuming that new systems are going to onboard brand new data sources into this ADLS Gen2 regularly.

The common file format doesn't mean that the mastered data is only provided in this format, but it's one of the provided formats. This format is mostly for data analysts, data engineers, and data scientists to work with highly curated data, instead of having to use the raw data. We might not always want or need to use the mastered data, but it's available for cases where we want to work with clean data instead of raw.

### Microsoft Purview

Microsoft Purview has the responsibility of scanning the ADLS Gen2 on a regular cadence (for example, daily) to identify new data sources and delta files. It also runs premovement and in-place classification scans to identify possible privacy and governance risks before we move the data downstream.

It's worth mentioning that the data isn't physically stored in Microsoft Purview. Rather, Microsoft Purview is a metadata store that holds pointers to where the data is, and maintains some standard metadata about those assets.

Microsoft Purview also provides the end to end lineage of all data movement in the Azure ecosystem, including the lineage that is built up through CluedIn. In addition to this, Microsoft Purview is the public platform for end users to discover, request access to, and explore the raw and mastered data assets for insights.

### CluedIn

CluedIn is responsible for standardization of data into domains, abstracting away the systems and formats of the data so that the end users are working with domains, instead of assets. CluedIn also standardizes semantics, cleans, and standardizes the data, enriches the data from external sources when necessary, and deduplicates the data. Then, it provides mechanisms for this data to be shared through Microsoft Purview to the downstream consumers.

Azure Data Factory is utilized to pull the data assets that are registered in Microsoft Purview from the ADLS Gen2 store and copy that data into CluedIn. CluedIn provides its processed data back into the ADLS Gen2 store into a folder called  *Mastered*. Microsoft Purview is set up to scan this folder and apply tags to those assets so that they're easily discoverable in Microsoft Purview by the end consumers.

### Azure Data Factory

Azure Data Factory (ADF) is utilized as a generic data integration and data movement pipeline. It copies data from the ADLS Gen2 storage account to CluedIn. It can also optionally be used as a data transformation service when necessary.

### Azure Key Vault

We use Azure Key Vault to securely house our credentials for our Storage Account so that it's accessible by both Microsoft Purview and Azure Data Factory. There are several ways both of these services can connect to Azure Data Lake Storage Gen2. Azure Key Vault and the account key are used so that CluedIn can automatically create pipelines to move the data through our environment.