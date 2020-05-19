One of the key benefits of using Azure Synapse Analytics is the fast loading of data. Importing data can be either a manual process that requires an understanding of PolyBase and the necessary steps to transfer data. More commonly however, you will use a data ingestion tool such as Azure Data Factory to schedule this data movement on a regular basis. Once understood, the loading of Terabytes or even Petabytes of data can take minutes instead of hours.

Suppose you want to resolve a long-running data load that is delaying the daily population of an on-premises data warehouse within Contoso. You've decided that the best approach to solve this problem is to create an Azure Synapse Analytics and use PolyBase to perform data loads. Your goal is to explore and understand the steps required so that you can explain it to the rest of the data team at Contoso.

## Learning objectives

In this module, you:

- Explore how PolyBase works
- Upload text data to Azure Blob store
- Collect the security keys for Azure Blob store
- Create an Azure Synapse Analytics server
- Import data from Blob Storage to the Azure Synapse Analytics
