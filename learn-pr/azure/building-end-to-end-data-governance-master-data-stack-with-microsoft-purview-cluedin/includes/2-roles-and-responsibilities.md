Roles and Responsibilities

Considering that we are using multiple different technologies in this learning module, it is important that we establish the specific roles and responsibilities of each piece of technology so we are being very clear on what value each technology brings to the overal end to end data technology stack. 

ADLSv2

In this learning module, we are making the assumption that your company-wide data has landed into a single ADLSv2 instance and in a common file format. It is assumed (but not necessary) that Azure Data Factory was used to pull the data from these systems and there is a regular schedule on those integration jobs that makes sure that we are pulling in the delta changes of data on a regular cadence e.g. every 1 hour. We are also assuming that new systems will be onboarding brand new data sources into this ADLSv2 on a regular basis. Because of this, ADLSv2 is essentially playing the role of the ubiquotus Lake storage for low cost storage of raw data, but also the landing zone for the mastered data in a file format as well. This does not mean that the mastered data will only be provided in this format, but it is one of the formats that will be provided. This is mostly for the use case of Data Analysts, Data Engineers, Data Scientists to work with data that has been through a high level of curation, instead of having to use the raw data. It will not always be applicable that these personas will want or need to use the mastered data, but it is available for cases where we want to work with clean data instead of raw. 

Microsoft Purview

Microsoft Purview will have the responsibility of scanning the ADLSv2 on a regular cadence e.g. every 1 hour to identify new data sources, delta files and to run pre-movement and in-place classification scans as to identify the possible privacy and governance risks before we move the data downstream. On top of this, Purview will provide the end to end lineage of all data movement in the Azure ecosystem, including the lineage that will be built up through CluedIn as well. In addition to this, Microsoft Purview will be the public platform for end users to discover, request access to and explore that raw and mastered data assets for insights. It is also assumed that any other technology introduced into the stack at a later point will be writing its lineage into Purview as well. It is expected that Microsoft Purview will be the publicly facing catalog of data products and where consumers will discover, request access and comment on the data products. 

CluedIn

CluedIn will be responsible for standardisation of data into domains, abstracting away the systems and formats of the data so that the end users are working with Domains, instead of assets. In addition to this, CluedIn will standardise semantics, clean and standarise the data, enrich the data from external sources when necessary, deduplicate the data and then provide mechanisms for this data to be shared through Microsoft Purview to the downstream consumers. Azure Data Factory will be utilised to pull the data assets that are registered in Microsoft Purview from the ADLSv2 store and copy that data into CluedIn. It is worth mentioning that the data is not physically stored in Purview, but rather it is a metadata store that holds pointers to where the data is and some standard metadata around those assets. CluedIn will provide its processed data back into the ADLSv2 store into a folder called "Mastered" and Microsoft Purview will be setup to scan this folder and apply Tags to those assets so that they are easily disocverable in Microsoft Purview by the end consumers. If an end user requests access to a mastered asset, then Azure Data Share will be utilised to deliver this data in an apporiate format to the target system of choice e.g. Azure Synapse, Power BI, SQL Server, Files etc. 

Azure Event Hubs

One of the approaches to extending and interacting with the data in CluedIn is via its nativ integration to Azure Event Hubs. Once enabled, processing events that happen within CluedIn will be exposed as JSON events on the Azure Event Hub that has been integrated into CluedIn. This is predominantly used as a generic delivery mechanism of events to consuming applications. In this learning module, Azure Functions will be utilised as to consume these events, apply some transfomation and then provide the rsult back to CluedIn. This is only to highlight one approach that developers can use to interact with the processing pipeline of CluedIn, but it must be noted that the intended end user of the User Interface of CluedIn are Business users. 

Azure Functions

Azure Functions will be utilised as the way that developers can interact with CluedIn to extend the system and apply programatic transformations to the data. It must be noted that this is not a replacement for Azure Data Bricks or Azure Data Factory or Azure Synapse for data engineering code to be apploed to the data stream. There are however times when it does make sense to have cusom code running on the CluedIn procesing pipeline, such as:

 - Developers would like to customise the fuzzy merging logic for deduplication. 
 - Developers have complex Rule Actions that they would like to apply to data. 

Azure Data Factory

Azure Data Factory (ADF) will be utilised as a generic data integration and data movement pipeline. In addition to this, it can optionally be used as a data transformation service when necessary. 

Azure Synapse

Azure Synapse will be used to act as one of the downstream systems that is consuming data from the data landing zone that we are building as part of this learning module. 