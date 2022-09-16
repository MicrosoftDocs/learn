The first step in your design for Azure storage is to determine what types of data are required to support the Tailwind Traders organization. In general, data can be classified in three ways: structured, semi-structured, and unstructured. Most organizations need to provide storage options for all data types. 

### Things to know about types of data

The following table describes three data types. Consider how these different types are used in your organization.

| <!-- Blank --> | Data classification | Examples |
| --- | --- | --- |
| :::image type="icon" source="../media/structured-icon.png"::: | **Structured** <br><br> Structured data is stored in a relational format that has a shared schema. Structured data is often contained in a database table with rows, columns, and keys. | - Relational databases, such as medical records, phone books, and financial accounts <br> - Application data for an e-commerce website  |
| :::image type="icon" source="../media/semi-structured-icon.png":::  | **Semi-structured** <br><br> Semi-structured data isn't stored in a relational format. This data is less organized than structured data. The data fields don't fit neatly into tables, rows, and columns. Semi-structured data contains tags that clarify how the data is organized. The expression and structure of the data is defined by using a serialization language. | - Hypertext Markup Language (HTML) files <br> - JavaScript Object Notation (JSON) files <br> - Extensible Markup Language (XML) files |
| :::image type="icon" source="../media/unstructured-icon.png":::  | **Unstructured** <br><br> Unstructured data is the least organized. This data is a mix of information that's stored together, but the data doesn't have a clear relationship. The format of unstructured data is referred to as _non-relational_. | - Media files like photos, videos, and audio recordings <br> - Office files, such as Microsoft Word documents and Microsoft PowerPoint slide decks <br> - Text files like PDF, TXT, and RTF |

> [!Note]
> In this module, we review storage options for unstructured non-relational data. You can discover how to work with structured and relational data in the next module in this learning path, [Design a data storage solution for relational data](/training/modules/design-data-storage-solution-for-relational-data/).

### Things to consider when choosing data storage

Non-relational data in Azure can be stored in several different data objects. We'll look at scenarios that implement four storage objects. As you review these options for Tailwind Traders, think about what types of non-relational data are of most interest to your organization. Consider the storage objects that you might need to implement.

- **Consider Azure Blob Storage**. Store vast amounts of unstructured data by using Azure Blob Storage. Blob stands for Binary Large Object. Blob Storage is often used for images and multimedia files.

- **Consider Azure Files**. Provide fully managed file shares in the cloud with Azure Files. This storage data is accessible via the industry standard Server Message Block (SMB) protocol, Network File System (NFS) protocol, and the Azure Files REST API. 

- **Consider Azure managed disks**. Support Azure Virtual Machines by using Azure managed disks. These disks are block-level storage volumes that are managed by Azure. Managed disks perform like physical disks in an on-premises server, but in a virtual environment. 

- **Consider Azure Queue Storage**. Use Azure Queue Storage to store large numbers of messages. Queue Storage is commonly used to create a backlog of work to process asynchronously. 