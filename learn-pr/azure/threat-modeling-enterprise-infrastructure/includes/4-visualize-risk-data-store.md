---
author: Rodrigo Santos
ms.service: non-product-specific
ms.topic: include
ms.date: 03/01/2021
ms.author: rodsan
---

### What is data store?

Data store refers to either permanent and temporary data storage.

### Data store context to include

|Context|Questions|
|-------|---------|
|Type|Does the system use Azure SQL, cookies, local or some other type of storage? If so, what is it?|
|Function|How is the storage used? Is it used to share data, store backups, security logs, credentials, secrets?|
|Permission level|How is access control implemented? Who has read and write permissions?|
|Additional controls|Is data encrypted? What about the disk? Are digital signatures used?|

### Woodgrove data store elements

<ul><li>Credentials and tokens VPN store</li><li>NAS store</li><li>Logging and monitoring store</li><li>Active directory store</li><li>Removable drive store</li></ul>

### Data store labeling example

**NAS** - (file share, backup, creds, secrets)