### Data-store

![Data store element.](../media/elements/data-store-50.png)

#### What is data store?

Data store refers to permanent and temporary storing of data.

#### Data store context to include

|Context|Questions|
|-------|---------|
|Type|Does the system use Azure SQL, cookies, local or some other type of storage? If so, what is it?|
|Function|How is the storage used? Is it used to share data, store backups, security logs, credentials, secrets?|
|Permission level|How is access control implemented? Who has read and write permissions?|
|Extra controls|Is data encrypted? What about the disk? Are digital signatures used?|

#### Woodgrove data store elements

- Credentials and tokens VPN store
- NAS store
- Logging and monitoring store
- Active directory store
- Removable drive store

#### Data store labeling example

**NAS** - (file share, backup, credentials, secrets)