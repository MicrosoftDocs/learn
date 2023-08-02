**Repudiation** occurs when someone, with or without malicious intent, takes an action but claims otherwise. 

Examples include:

- Denying the modification of logs containing sensitive actions.
- Using someone else's account to avoid getting caught.
- Claiming not to have deleted database records.

> [!NOTE]
> System logs are a goldmine for an attacker, not just to manipulate, but also to gather data about users, environment, and weaknesses.

## Elements and interactions at risk from repudiation attacks

### Element

|Name|Shape|Definition|
|----|-----|----------|
|Process|![Process.](../media/process50.png)|Activity that modifies or redirects input to an output|
|External entity|![External Entity.](../media/external-entity50.png)|Process, data store, or even full-fledged applications outside your control|
|Data store|![Data Store.](../media/data-store50.png)|Permanent or temporary data storage|

### Interaction

|Name|Interaction|Definition|
|----|-----------|----------|
|Process <-> Process|![Process to Process Interaction.](../media/process-process.png)|A task sends or receives data to or from another task|
|Process <-> External Entity|![Process to External Entity Interaction.](../media/process-externalentity.png)|A task sends or receives data to or from a user|
|Process <-> Data Store|![Process to Data Store Interaction.](../media/process-datastore.png)|A task sends or receives data to or from a data store|

## How to prevent repudiation

**Non-repudiation** ensures each action can be traced back to its origin by creating and protecting security logs.

### Common security controls to reduce or eliminate risk

- Strong authentication
- Secure logging and monitoring
- Digital signatures
- Secure timestamps
- Trusted third parties

> [!TIP]
> **Good question to ask:**
> Can I tie every action to an identity?
