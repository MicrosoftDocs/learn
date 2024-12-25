
Azure Cosmos DB automatically backups yours data. These backups are taken at regular intervals. The backup process happens behind the scenes and doesn't affect either the performance or availability of your database operations. The backups are encrypted with Microsoft managed keys and stored in a separate storage service. The backups are globally replicated for resiliency against regional disasters. The backups are encrypted while in transfer since they're transferred over a secure non-public network. Restores of backups are done on the same region they were created in. These backups are done in one of two modes, either a periodic or a continuous backup mode.


After completing this module, you'll be able to:

- Understand the different backup and restore options Azure Cosmos DB provides 
- Evaluate periodic backups
- Configure continuous backups
- Do point in time recovery
