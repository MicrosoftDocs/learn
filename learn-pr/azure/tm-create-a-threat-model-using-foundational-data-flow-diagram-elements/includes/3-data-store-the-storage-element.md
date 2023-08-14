![Rendering of a two parallel horizontal lines representing the Data Store Element.](../media/data-store.png)

The **data store element** is depicted as parallel lines. This element represents data stored on a temporary or permanent basis.

Examples include:

- Using the browser cache to store user session-related data.
- Adding a security log event to a database.

## When to use the data store element

- Whenever you're storing data somewhere, like Azure DB or a local cache.
- If you're establishing communication between two data stores, don't forget to add a process between them.
- Data stores and external entities start the data flow, so verify you have either one in place.
- Make sure to include any post-processing of data, such as analytics services like Azure Analytics. This process is often missed.

## Include context

Include the following context with each data store element:

|Context|Questions|
|-------|---------|
|Type|Does the system use Azure SQL, cookies, local, or some other type of storage? If so, what is it?|
|Function|How is the storage used? Is it used to share data, store backups, security logs, credentials, secrets?|
|Permission level|How is access control implemented? Who has read and write permissions?|
|Additional controls|Is data encrypted? What about the disk? Are digital signatures used?|
