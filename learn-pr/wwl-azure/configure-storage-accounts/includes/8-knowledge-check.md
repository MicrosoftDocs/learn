Choose the best response for each question. Then select Check your answers.

## Multiple Choice
Which of the following replicates data to a secondary region, maintains six copies of the data, and is the default replication option? 
( ) Locally-redundant storage {{That's incorrect. Locally redundant storage (LRS) replicates data three times within a single data center in the primary region.}}
(x) Read-access geo-redundant storage {{That's correct. Read-access geo-redundant storage (GRS) is the default replication option. Geo-redundant storage (GRS) copies the data synchronously three times within a single physical location in the primary region using LRS. It then copies the data asynchronously to a single physical location in the secondary region.}}
( ) Zone-redundant storage {{That's incorrect. Zone-redundant storage (ZRS) replicates Azure Storage data synchronously across three Azure availability zones in the primary region.}}

## Multiple Choice
The name of a storage account must be which of the following?
( ) Unique within the containing resource group.{{That's incorrect. A storage account name does not have to be unique in a resource group.}}
( ) Unique within the organization's subscription. {{That's incorrect. A storage account name does not have to be unique in an Azure subscription.}}
(x) Globally unique. {{That's correct. The storage account name is used as part of the URI for API access, so it must be globally unique.}}

## Multiple Choice
A manufacturing company has several sensors that record time-relative data. Only the most recent data is useful. The company wants the lowest cost storage for this data. What is the best kind of storage account for the company?
(x) Locally-redundant storage {{That's correct. This option is the best because it's the lowest cost, the data is being continuously created, and data loss isn't an issue.}}
( ) Geo-redundant storage {{That' incorrect.  Is there a lower cost solution for temporary data?}}
( ) Zone-redundant storage {{That' incorrect. Is there a lower cost solution for temporary data?}}


