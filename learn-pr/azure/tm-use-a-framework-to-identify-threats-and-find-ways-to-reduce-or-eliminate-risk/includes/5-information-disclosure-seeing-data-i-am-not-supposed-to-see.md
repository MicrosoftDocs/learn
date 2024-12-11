**Information disclosure** occurs when sensitive data is exposed to unauthorized individuals. It can happen with or without intention. 

Examples include:

- System reveals sensitive data through error messages.
- Users access unauthorized documents and folders with weak security controls.
- Users access data flowing through an unsecured network.

## Elements and interactions at risk from information disclosure

### Element

|Name|Shape|Definition|
|----|-----|----------|
|Process|![Process.](../media/process50.png)|Activity that modifies or redirects input to an output|
|Data store|![Data Store.](../media/data-store50.png)|Permanent or temporary data storage|
|Data-flow|![Data-Flow.](../media/data-flow50.png)|Data movement between elements|

### Interaction

|Name|Interaction|Definition|
|----|-----------|----------|
|Process -> Process|![Process to Process Unilateral Interaction.](../media/process-process-unilateral.png)|A task sends data to another task|
|Process <-> External entity|![Process to External Entity Interaction.](../media/process-externalentity.png)|A task sends or receives data to or from a user|
|Process <-> Data store|![Process to Data Store Interaction.](../media/process-datastore.png)|A task sends or receives data to or from a data store|
|Data Flow <-> Trust boundary|![Data-Flow to Trust Boundary Interaction.](../media/flow-trustboundary.png)|Data is transmitted from a trusted environment to someone over the internet (and vice-versa)|

## How to prevent information disclosure

**Confidentiality** ensures data is protected.

Examples include:

- Applying access-control lists to ensure the right users can access the right data.
- Encrypting data at rest, in transit, and in use.
- Enforcing SSL/TLS to secure transmission.
- Using IPSec tunnels to secure communication across endpoints.

### Common security controls to reduce or eliminate risk

- Encryption
- Access Control Lists (ACL)

> [!TIP]
> **Good question to ask:**
> Can I be sure no one can see my data in transit and at rest?
