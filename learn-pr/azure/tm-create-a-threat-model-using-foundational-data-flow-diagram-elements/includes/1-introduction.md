Data-flow diagrams are graphical representations of your system and should specify:

# add more here in the beginning
# goal of introductory unit is motivation
# 1st paragraph - universe of discourse (area we're talking about)
# 2nd paragraph - real world example (motivational)
# 3rd paragraph - Prose table of contents (in this module you'll .......)

# Add unit "1.5"


|Element|Shape|Definition|
|-------|-----|----------|
|Process|![Process](../media/process50.png)|Task that receives, modifies, or redirects input to output, like a web service|
|Data store|![Data Store](../media/data-store50.png)|Permanent and temporary data storage, like a web cache and Azure DB|
|External entity|![External Entity](../media/external-entity50.png)|Task, entity or data store outside of your direct control, like users and third-party APIs|
|Data-flow|![Data-flow](../media/data-flow50.png)|Data movement between processes, data stores, and external entities, like connection strings and payloads|
|Trust boundary|![Trust Boundary Box](../media/trust-boundary-box50.png) ![Trust Boundary Line](../media/trust-boundary-line50.png)|Trust zone changes as data flows through the system, like users using the internet to access a secured corporate network|

Elements and interactions are analyzed against STRIDE to help identify threats and reduce or eliminate risk. This process helps engineers collaborate with colleagues, security teams, and managers while securing their systems against the most common threats.

In this module, you'll explore each element in a data-flow diagram. These elements are made up of distinct shapes, functions, and require specific context.

## Learning objectives

In this module, you'll learn:

- The shape and function of each element
- The context to include when creating a data-flow diagram

## Prerequisites

- None