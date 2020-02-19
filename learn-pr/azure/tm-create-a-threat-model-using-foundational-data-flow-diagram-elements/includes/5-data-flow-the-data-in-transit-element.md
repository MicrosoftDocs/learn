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

|Context|Examples to Include|
|-------|---------------|
|Data description|Session token? SQL string? User credentials?|
|Protocol|HTTPS? SOAP?|
|Flow sequence|1-n? a-z?|
|Data type|Cookies? XML? SOAP payload? REST payload? JSON payload?|
|Additional controls|Forgery protection?|
|Authentication and authorization mechanisms|for both source and destination elements|
