![Rendering of two diagonal arrows representing the Data-Flow Element.](../media/data-flow.png)

The **data-flow element** is depicted as directional arrows. This element represents data movement between elements. The directional arrows indicate communication between the data source and destination.

Examples include:

- Credentials submitted by a user to access your service.
- Request from a process to add an entry to your data store.

## When to use the data-flow element

- Between each element interaction.
- To call out the data type being transmitted, and include how you're transmitting it.
- In most cases, include responses to each request.

## Include context

Include the following context with each data-flow element:

|Context|Questions|
|-------|---------|
|Description|Is the data flow passing a session token, SQL string, or user credentials? If not, what's it passing?|
|Protocol|Does the flow use HTTPS or SOAP? If not, what does it use?|
|Flow sequence|Is the data flow enumerated to make it easier to follow the flow sequence?|
|Type|What type of data is in the data flow? Cookies? XML? SOAP payload? REST payload? JSON payload?|
|Additional controls|Does the data flow have forgery protection enabled? Other security flags enabled?|
|Authentication|Does the process rely on Azure Active Directory for authentication? If not, on what does it rely?|
|Authorization|Does it rely on Access Control Lists (ACL) for authorization? If not, on what does it rely?|
