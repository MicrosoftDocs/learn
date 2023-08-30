You can access your data from Azure Blob Storage by using different protocols such as representational state transfer (REST), Hadoop Distributed File System (HDFS), Network File System (NFS), and Secure File Transfer Protocol (SFTP).

## Example scenario

Suppose you work for a media company that has several departments, each generating large amounts of data in diverse formats:

- Your main business units have an extensive library of video clips, which users access multiple times a day. Your company uses Azure Blob Storage (Blob Storage) to store these videos because it provides a convenient space for storing large quantities of data in a safer and more reliable manner.

- Accounting data from the media servers is uploaded daily on the Blob Storage account. After these reports are uploaded, you need to connect from a Linux server to read the data and organize it based on the date it was uploaded and the contents. You plan to use a network file system (NFS) client to connect to Blob Storage.

- Your web-services team operates dozens of web servers that each generate huge amounts of log data. These log files are used to troubleshoot customer issues. Your web-service team often performs bulk transfers of large files concurrently, and maintaining data integrity and security during these file transfers is critical. You analyze the uploaded data to gain insights and identify user-issue trends. Company employees can then download a data summary to use in Microsoft Excel.

Currently, these business units maintain separate data stores, resulting in data silos that can't be easily used or analyzed together. Your company wants to eliminate the requirements of refactoring the data prior to moving it to the cloud. They also want to eliminate the data silos by enabling multiprotocol support for data that resides in Blob Storage.

### What will we be doing?

In this module, you'll explore the various protocols that Blob Storage supports and the configuration requirements for each protocol. You’ll learn to access data from Blob Storage accounts by using multiple protocols.

### What is the main goal?

By the end of this module, you'll be able to describe the different protocols that Azure Storage accounts support. You'll also practice accessing data from Blob Storage accounts by using multiple protocols, such as Representational State Transfer (REST), SSH File Transfer Protocol (SFTP), Hadoop Distributed File System (HDFS), and Network File System (NFS v3).
