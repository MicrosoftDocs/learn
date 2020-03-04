Data-flow diagrams are made up of shapes that create graphical representations of your system. 

Each shape is used to represent a unique function, and their interactions are analyzed in threat modeling to help you identify potential threats and ways to reduce risk:

|Element|Shape|Definition|
|-------|-----|----------|
|Process|![Process](../media/process50.png)|Task that receives, modifies, or redirects input to output, like a web service|
|Data store|![Data Store](../media/data-store50.png)|Permanent and temporary data storage, like a web cache and Azure DB|
|External entity|![External Entity](../media/external-entity50.png)|Task, entity, or data store outside of your direct control, like users and third-party APIs|
|Data-flow|![Data-flow](../media/data-flow50.png)|Data movement between processes, data stores, and external entities, like connection strings and payloads|
|Trust boundary|![Trust Boundary Box](../media/trust-boundary-box50.png) ![Trust Boundary Line](../media/trust-boundary-line50.png)|Trust zone changes as data flows through the system, like users using the internet to access a secured corporate network|

Let's discuss each element in the next few units.