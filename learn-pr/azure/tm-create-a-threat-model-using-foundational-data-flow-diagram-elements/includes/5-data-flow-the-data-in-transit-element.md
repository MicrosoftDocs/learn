![Data Flow Element](../media/data-flow.png)

Data movement between elements is represented by directional arrows to indicate communication between data source and destination. Examples include:

- Credentials submitted by a user to access your service
- Request from a process to add an entry to your data store
 
What to look out for:

- Include a data-flow between each element interaction
- Call out the data type being transmitted and include how you're transmitting it
- In most cases, include responses to each request

Include the following context to each data-flow element:

- **Data description** - Session token? SQL string? User credentials?
- **Protocol** - HTTPS? SOAP?
- **Flow sequence** - 1-n? a-z?
- **Data type** - Cookies? XML? SOAP payload? REST payload? JSON payload?
- **Additional controls** - Forgery protection?
- **Authentication and authorization mechanisms** - for both source and destination elements
