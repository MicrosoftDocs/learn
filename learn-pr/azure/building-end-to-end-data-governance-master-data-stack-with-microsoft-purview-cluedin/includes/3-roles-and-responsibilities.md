## Roles and responsibilities

Since we're using several technologies in this learning module, we'll establish the specific roles and responsibilities of each piece of technology so you can understand what value each technology brings to the end to end data technology stack.

### Azure Data Lake Storage Gen2

In this learning module, ADLS Gen2 is playing the role of storage for raw data and the landing zone for mastered data in a file format. We're making the assumption that your company-wide data has landed into a single ADLS Gen2 instance and in a common file format. It's assumed (but not necessary) that Azure Data Factory was used to pull the data from these systems and there's a regular schedule on those integration jobs that makes sure that we're pulling in the delta changes of data on a regular cadence. We're also assuming that new systems will be onboarding brand new data sources into this ADLS Gen2 regularly.

This doesn't mean that the mastered data will only be provided in this format, but it's one of the formats that will be provided. This is mostly for the use case of Data Analysts, Data Engineers, Data Scientists to work with data that has been through a high level of curation, instead of having to use the raw data. It will not always be applicable that these personas will want or need to use the mastered data, but it's available for cases where we want to work with clean data instead of raw.

### Microsoft Purview

Microsoft Purview will have the responsibility of scanning the ADLS Gen2 on a regular cadence (for example, every hour) to identify new data sources and delta files. It will also run pre-movement and in-place classification scans to identify possible privacy and governance risks before we move the data downstream.

It's worth mentioning that the data isn't physically stored in Purview, but rather it's a metadata store that holds pointers to where the data is and some standard metadata around those assets.

Microsoft Purview will also provide the end to end lineage of all data movement in the Azure ecosystem, including the lineage that will be built up through CluedIn. In addition to this, Microsoft Purview will be the public platform for end users to discover, request access to, and explore that raw and mastered data assets for insights. It's also assumed that any other technology introduced into the stack at a later point will be writing its lineage into Purview as well.

If an end user requests access to a mastered asset, then Data Sharing will be utilized to deliver this data in an appropriate format to the target system of choice. For example: Azure Synapse, Power BI, SQL Server, Files etc.

### CluedIn

CluedIn will be responsible for standardization of data into domains, abstracting away the systems and formats of the data so that the end users are working with domains, instead of assets. CluedIn will also standardize semantics, clean and standardize the data, enrich the data from external sources when necessary, deduplicate the data and then provide mechanisms for this data to be shared through Microsoft Purview to the downstream consumers. 

Azure Data Factory will be utilized to pull the data assets that are registered in Microsoft Purview from the ADLS Gen2 store and copy that data into CluedIn.  CluedIn will provide its processed data back into the ADLS Gen2 store into a folder called "Mastered" and Microsoft Purview will be set up to scan this folder and apply tags to those assets so that they're easily discoverable in Microsoft Purview by the end consumers.

### Azure Event Hubs

One of the approaches to extending and interacting with the data in CluedIn is via its native integration to Azure Event Hubs. Once enabled, processing events that happen within CluedIn will be exposed as JSON events on the Azure Event Hubs that has been integrated into CluedIn. This is predominantly used as a generic delivery mechanism of events to consuming applications.

### Azure Functions

In this learning module, Azure Functions will be utilized as to consume Event Hubs events, apply some transformation and then provide the result back to CluedIn. This is only to highlight one approach that developers can use to interact with the processing pipeline of CluedIn, but it must be noted that the intended end users for CluedIn are business users.

Azure Functions will be utilized as the way that developers can interact with CluedIn to extend the system and apply programmatic transformations to the data. It must be noted that this isn't a replacement for Azure Databricks or Azure Data Factory or Azure Synapse for data engineering code to be applied to the data stream. There are however times when it does make sense to have custom code running on the CluedIn processing pipeline, such as:

 - Developers would like to customize the fuzzy merging logic for deduplication.
 - Developers have complex Rule Actions that they would like to apply to data.

### Azure Data Factory

Azure Data Factory (ADF) will be utilized as a generic data integration and data movement pipeline. In addition to this, it can optionally be used as a data transformation service when necessary.

### Azure Synapse

Azure Synapse will be used to act as one of the downstream systems that is consuming data from the data landing zone that we're building as part of this learning module.