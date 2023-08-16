![Rendering of a square representing the External Entity Element.](../media/external-entity.png)

The **external entity element** is depicted as a square. The external entity can be a process, data store, or even a full-fledged system outside of your direct control.

Examples include:

- A user interacting with your service.
- Tight integration with a third-party authentication service.
- Services created by other teams within your organization.

## When to use the external entity element

- When representing an entity that you can't directly modify.
- Data stores and external entities start the data flow, so verify you have either one in place.

## Include context

Include the following context with each external entity element:

|Context|Questions|
|-------|---------|
|Source|Is the entity internal or external?|
|Type|Is the entity human, a service provider, or web service?|
|Authentication|Does the process rely on Azure Active Directory for authentication? If not, on what does it rely?|
|Authorization|Does it rely on Access Control Lists (ACL) for authorization? If not, on what does it rely?|
