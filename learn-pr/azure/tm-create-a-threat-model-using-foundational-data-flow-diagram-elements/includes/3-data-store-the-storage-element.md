![Data Store Element](../media/data-store.png)

## What Is It?

Depicted by parallel lines, this element represents data stored on a temporary or permanent basis. Examples include:

- Using the browser cache to store user session-related data
- Adding a security log event to a database

## When Should I Use the Data Store Element?

- Use the data store element whenever you're storing data somewhere, like Azure DB or local cache
- If you're establishing communication between two data-stores, don't forget to add a process between them
- Data stores and external entities start the data-flow, so verify you have either one in place
- Avoid data sinks by including Analytics Services and other processes to handle data post-storage

## What Context Should I Include?

Include the following context to each data store element:

|Context|Questions|
|-------|---------|
|Type|Does the system use Azure SQL, cookies, local or some other type of storage? If so, what is it?|
|Function|How is the storage used? Is it used to share data, store Backups, Security logs, Credentials, Secrets?|
|Permission Level|How is access control implemented? Who has read and write permissions?|
|Additional Controls|Is data encrypted? What about the disk? Are digital signatures used?|