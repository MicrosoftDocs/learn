
Azure Files provides the capability to take share snapshots of file shares. File share snapshots capture a point-in-time, read-only copy of your data.

:::image type="content" source="../media/file-share-snapshot-cbda2136.png" alt-text="Screenshot of a file share snapshot that shows the snapshot name and date it was created.":::

### Things to know about file share snapshots

Let's review some characteristics of file share snapshots.

- The Azure Files share snapshot capability is provided at the file share level.

- Share snapshots are incremental in nature. Only data changed since the most recent share snapshot is saved.

- Incremental snapshots minimize the time required to create share snapshots and saves on storage costs.

- Even though share snapshots are saved incrementally, you only need to retain the most recent share snapshot to restore the share.

- You can retrieve a share snapshot for an individual file. This level of support helps with restoring individual files rather than having to restore to the entire file share.

- If you want to delete a share that has share snapshots, you must first delete all its snapshots.

### Things to consider when using file share snapshots

There are several benefits to using file share snapshots and having access to incremental point-in-time data storage. As you review the following suggestions, think about how you can implement file share snapshots in your Azure Files storage solution.

| Benefit | Description |
| --- | --- |
| **_Protect against application error and data corruption_** | Applications that use file shares perform operations like writing, reading, storage, transmission, and processing. When an application is misconfigured or an unintentional bug is introduced, accidental overwrite or damage can happen to a few data blocks. To help protect against these scenarios, you can take a share snapshot before you deploy new application code. When a bug or application error is introduced with the new deployment, you can go back to a previous version of your data on that file share. |
| **_Protect against accidental deletions or unintended changes_** | Imagine you're working on a text file in a file share. After the text file is closed, you lose the ability to undo your changes. In this scenario, you need to recover a previous version of your file. You can use share snapshots to recover previous versions of the file if it's accidentally renamed or deleted. |
| **_Support backup and recovery_** | After you create a file share, you can periodically create a snapshot of the file share to use it for data backup. A share snapshot, when taken periodically, helps maintain previous versions of data that can be used for future audit requirements or disaster recovery. |