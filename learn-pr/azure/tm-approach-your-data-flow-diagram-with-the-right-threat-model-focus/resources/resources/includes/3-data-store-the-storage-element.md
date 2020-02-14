Data Store:

![Data Store Element](../media/data-store.png)

Depicted by parallel lines, this element represents data stored on a temporary or permanent basis. Examples include:

- Using the browser cache to store user session-related data
- Adding a security log event to a database

Data stores require security controls to keep data accessible, intact, and safe from prying eyes. These controls are easier to implement when the right context is included.

What to look out for:
 
- Data stores do not handle tasks; include a process element for each one
- Data stores or external entities start the data-flow, so verify you have either one in place
- Avoid data sinks by including Analytics Services and other processes to handle data post-storage

Include the following context to each data store element:

|Context|What to Include|
|-------|---------------|
|Type|Azure SQL storage? Cookies? Local storage?|
|Function|Shared data? Backups? Security logs? Credentials? Secrets?|
|Permission level|Access Controls? Read? Write?|
|Additional controls|Data encryption? Disk encryption? Digital signatures?|