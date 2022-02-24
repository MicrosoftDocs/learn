### Data classifications – structured, semi-structured, and unstructured

To design Azure storage, you first must determine what type of data you have. 

:::image type="content" source="../media/storage-classification.png" alt-text="Structure, semi-structured, and unstructured data.":::


- **Structured data** includes relational data and has a shared schema. Structured data is often stored in database tables with rows, columns, and keys. Structured data is often used for application storage like an ecommerce website.

- **Semi-structured** is less organized than structured data and isn’t stored in a relational format. Semi-structured data fields don’t neatly fit into tables, rows, and columns. Semi-structured data contains tags that clarify how the data is organized. The expression and structure of the data in this style is defined by a serialization language. Examples of semi-structured data include Hypertext Markup Language (HTML) files, JavaScript Object Notation (JSON) files, and Extensible Markup Language (XML) files

- **Unstructured data** is the least organized type of data. The organization of unstructured data is ambiguous. Examples of unstructured data include:

	- Media files, such as photos, videos, and audio files

	- Office files, such as Word documents

	- Text files

> [!IMPORTANT]
> This module will only cover unstructured data. These data types are often referred to as non-relational data. 

### Azure non-relational storage objects

In Azure, non-relational data is contained in several different storage data objects. There are four data storage objects we’ll focus on.

:::image type="content" source="../media/non-relational-data-types.png" alt-text="Blobs, files, disks, and queues.":::


**Azure Blob storage** is an object store used for storing vast amounts unstructured data. Blob stands for Binary Large Object, which includes objects such as images and multimedia files.

**Azure Files** is a shared storage service. You can access files with Server Message Block (SMB) on Windows or Network File Share (NFS) on Linux.

**Azure managed disks** are block-level storage volumes that are managed by Azure and used with Azure virtual machines. Managed disks are like a physical disk in an on-premises server but, virtualized. 

**Azure Queue Storage** is a service for storing large numbers of messages. Queues are commonly used to create a backlog of work to process asynchronously. 

> [!TIP]
> Before beginning your study, think about which non-relational data types are of most interest to you or your organization. 