Data-flow diagrams are graphical representations of your system and should specify:

|Element|Definition|
|-------|----------|
|Process|Task that receives, modifies, or redirects input to output, like a web service|
|Data store|Permanent and temporary data storage, like a web cache and Azure DB|
|External entity|Task, entity or data store outside of your direct control, like users and third-party APIs|
|Data-flow|Data movement between processes, data stores, and external entities, like connection strings and payloads|
|Trust boundary|Trust zone changes as data flows through the system, like users using the internet to access a secured corporate network|

Elements and interactions are analyzed against STRIDE to help identify threats and reduce or eliminate risk. This process helps engineers collaborate with colleagues, security teams, and managers while securing their systems against the most common threats.

In this module, you'll explore each element in a data-flow diagram. These elements are made up of distinct shapes, functions, and require specific context.

## Learning objectives

In this module, you'll learn:

- The shape and function of each element
- The context to include when creating a data-flow diagram

## Prerequisites

- None