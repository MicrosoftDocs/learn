Azure Files offers [soft delete for Server Message Block (SMB) file shares](/azure/storage/files/storage-files-enable-soft-delete?toc=%2Fazure%2Fstorage%2Ffile-sync). Soft delete lets you recover deleted files and file shares.

:::image type="content" source="../media/files-enable-soft-delete-new-ui.png" alt-text="Illustration that depicts how to enable soft delete on an Azure file share." border="false":::

### Things to know about soft delete for Azure Files

Let's take a look at the characteristics of soft delete for Azure Files. 

- Soft delete for file shares is enabled at the storage account level. 

- Soft delete transitions content to a soft deleted state instead of being permanently erased.

- Soft delete lets you configure the retention period. The retention period is the amount of time that soft deleted file shares are stored and available for recovery. 

- Soft delete provides a retention period between 1 and 365 days. 

- Soft delete can be enabled on either new or existing file shares. 

- Soft delete doesn't work for Network File System (NFS) shares.

### Things to consider when using soft delete for Azure Files

There are many advantages to using soft delete for Azure Files. Consider the following scenarios, and think about how you can use soft delete.

- **Recovery from accidental data loss**. Use soft delete to recover data that is deleted or corrupted.

- **Upgrade scenarios**. Use soft delete to restore to a known good state after a failed upgrade attempt.

- **Ransomware protection**. Use soft delete to recover data without paying ransom to cybercriminals.

- **Long-term retention**. Use soft delete to comply with data retention requirements.

- **Business continuity**. Use soft delete to prepare your infrastructure to be highly available for critical workloads.-

