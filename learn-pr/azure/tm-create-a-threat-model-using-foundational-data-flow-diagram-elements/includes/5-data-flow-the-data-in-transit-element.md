![Data-Flow Element](../media/data-flow.png)

## What Is It?

Data movement between elements is represented by directional arrows to indicate communication between data source and destination. Examples include:

- Credentials submitted by a user to access your service
- Request from a process to add an entry to your data store

## What Do I Have To Do?

You should look out for:

- Include a data-flow between each element interaction
- Call out the data type being transmitted and include how you're transmitting it
- In most cases, include responses to each request

## What Context Should I Include?

Include the following context to each data-flow element:

|Context|Questions|
|-------|---------------|
|Description|Is it a session token? SQL string? User credentials?|
|Protocol|HTTPS? SOAP?|
|Flow sequence|Does use a numerical or an alphanumerical sequence?|
|Type|Is it cookies? XML? SOAP payload? REST payload? JSON payload?|
|Additional Controls|Does it have forgery protection?|
|Authentication and Authorization|Source and target must be specified - Does it use Azure Active Directory? Access Control Lists (ACL)?|