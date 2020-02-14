![External Entity Element](../media/external-entity.png)

Depicted by a square, an external entity can be a process, data store, or even a full-fledged system outside of your direct control. Examples include:

- A user interacting with your service
- Tight integration with a third-party authentication service
- Services created by other teams within your organization

> [!NOTE]
> Using this element ensures everyone understands what can and cannot be changed by your team.
 
Include the following context to each external entity element:

|Context|What to Include|
|-------|---------------|
|Flow|Data-flow begins with either an external entity or data store|
|Entity source|Internal or External|
|Entity type|Human? Provider? Web service?|
|Authentication and authorization mechanisms|Azure Active Directory? Access Control Lists (ACL)?|