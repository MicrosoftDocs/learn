Azure Blob Storage enables you to store large amounts of unstructured ("object") data in a single hierarchy – AKA a flat namespace - and can be accessed using HTTP or HTTPs. Azure Data Lake Storage Gen2 builds on blob storage, optimizing I/O of high-volume data using hierarchical namespaces we turned on in the previous exercise.

Hierarchical namespaces organize blob data into _directories_ and store metadata about each directory and the files within it. This structure allows operations like directory renames and deletes to be done in a single atomic operation. Flat namespaces, by contrast, require several operations proportionate to the number of objects in the structure. As hierarchical namespaces keep the data organized, it yields better storage and retrieval performance for an analytical use case, which lowers the cost of analysis.

## Azure Blob Storage vs. Azure Data Lake Storage

If your use case is to store data _without performing analysis on the data_, then set up the storage account as an Azure Blob Storage account by setting the **Hierarchical Namespace** option to **Disabled**. A great use case for blob storage is archiving rarely used data or storing website assets such as images and media. 

If you are performing analytics on the data, then you should set the storage for Azure Data Lake Storage Gen2 by setting the **Hierarchical Namespace** to **Enabled**. Since Azure Data Lake Storage Gen2 is integrated into the Azure Storage platform, applications can use either the Blob APIs or Azure Data Lake Storage Gen2 file system APIs for accessing data.