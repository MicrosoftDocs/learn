Data-flow diagrams are made up of shapes that create graphical representations of your system. Each shape represents a unique function. Each interaction is analyzed to help you identify potential threats and ways to reduce risk.

Using shapes correctly helps you receive better input from colleagues and security teams. They allow everyone to understand how the system works. It can also help everyone avoid going through countless design documents and development plans to get them up and running.

> [!NOTE]
> If you fail to properly account for all the parts of a system in the data-flow diagram, you'll risk deploying the system with potential vulnerabilities.

|Element|Shape|Definition|Example|
|-------|-----|----------|-------|
|Process|![Process.](../media/process50.png)|Task that receives, modifies, or redirects input to output|Web service|
|Data store|![Data Store.](../media/data-store50.png)|Permanent and temporary data storage|Web cache and Azure DB|
|External entity|![External Entity.](../media/external-entity50.png)|Task, entity, or data store outside of your direct control|Users and third-party APIs|
|Data-flow|![Data-flow.](../media/data-flow50.png)|Data movement between processes, data stores, and external entities|Connection strings and payloads|
|Trust boundary|![Trust Boundary Box.](../media/trust-boundary-box50.png) ![Trust Boundary Line](../media/trust-boundary-line50.png)|Trust zone changes as data flows through the system|Users connecting to a secured corporate network over the internet|

In the next few units, we discuss each of the elements.
