Azure Files offers fully managed file shares in the cloud. A file share is a network storage location that you can surface as local storage to your client operating system. Azure Files supports two industry-standard file sharing protocols: Server Message Block (SMB) and Network File System (NFS). SMB can be used with Windows, Linux, and macOS clients. NFS can be used with Linux and macOS clients. Azure Files also has a REST API (application programming interface).

You can mount Azure file shares concurrently on cloud or on-premises deployments. SMB Azure file shares can also be cached on Windows servers with Azure File Sync to provide fast access near where the data is being used.

## Key features of Azure Files

- Azure Files makes it easy to move all your on-premises files and applications to the cloud and enables you to effectively manage your files in the cloud.

- Azure Files makes it easy to "lift and shift" applications to the cloud that expect a file share to store application or user data.

- Azure Files offers multiple tiers that you can select based on your budget and performance needs.

- Azure file shares can be used as persistent volumes for stateful containers. For the containers that access raw data at every start, a shared file system is required to allow these containers to access the file system no matter which instance they run on.