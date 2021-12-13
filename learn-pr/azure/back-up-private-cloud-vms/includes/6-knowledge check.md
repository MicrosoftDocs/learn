1. An administrator plans to mount Blob Storage on a Linux machine using the NFS 3.0 protocol. What are the requirements for Blob Storage?

a.   Hierarchical namespace (Correct. You can use the NFS 3.0 protocol to access data in Blob Storage if the hierarchical namespace feature is enabled.)

b.   Flat namespace provided with blobs (Incorrect. You need to enable hierarchical namespace on Blob Storage to use the NFS 3.0 protocol for accessing data.)

c.   Page blobs (Incorrect. You can use the NFS 3.0 protocol to access data in Blob Storage using block blobs.)

2. Which of the following protocols does Blob Storage not support for data access?

a.   Server Message Block (SMB) (Correct. You use SMB primarily for accessing data in Azure Files.)

b.   NFS 3.0 (Incorrect. Blob Storage supports the NFS protocol for accessing data.)

c.   SFTP (Incorrect. Blob Storage supports the SFTP protocol for accessing data.)

3. An administrator is planning to access data in Blob Storage using an SFTP client. Which authentication model can you use for connecting SFTP clients?

a.   SAS (Incorrect. Blob Storage doesn’t support SAS authentication.)

b.   Azure AD authentication (Incorrect. Blob Storage doesn’t support Azure AD authentication.)

c.   Local users with either password or SSH key pairs (Correct. To grant access to a connecting client, the storage account must have an identity associated with that credential. That identity is called a *local user*.)
