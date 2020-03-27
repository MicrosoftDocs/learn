## What is It?

**Denial of service** occurs when an attacker causes the system to be unavailable. Examples include:

- Flooding the network with requests
- Absorbing memory and CPU processes
- Crashing data stores with an overwhelming number of requests

## What's at Risk?

### Elements

|Name|Shape|Definition|
|----|-----|----------|
|Process|![Process](../media/process50.png)|Activity that modifies or redirects input to an output|
|Data store|![Data Store](../media/data-store50.png)|Permanent or temporary data storage|
|Data-flow|![Data-Flow](../media/data-flow50.png)|Data movement between elements|

### Interactions

|Name|Interaction|Definition|
|----|-----------|----------|
|Process -> Process|![Process to Process Unilateral Interaction](../media/process-process-unilateral.png)|A task sends data to another task|
|Process <-> External Entity|![Process to External Entity Interaction](../media/process-externalentity.png)|A task sends or receives data to or from a user|
|Process <-> Data Store|![Process to Data Store Interaction](../media/process-datastore.png)|A task sends or receives data to or from a data store|
|Data Flow <-> Trust Boundary|![Data-Flow to Trust Boundary Interaction](../media/flow-trustboundary.png)|Data is transmitted from a trusted environment to someone over the internet (and vice-versa)|

## How Can I Prevent It?

**Availability** ensures your system is up and running for users. Examples include:

- Using network access control lists to control incoming and outgoing traffic
- Using elastic resources to manage growing or shrinking usage
- Monitoring the system to detect anomalies
- Enabling operating system flags to handle memory and CPU processes

### Common Security Controls to Reduce or Eliminate Risk

- Access Control Lists (ACL)
- Filtering
- Quotas
- Authorization
- High Availability

> [!TIP]
> **Good Question to Ask**
> Are there areas where my service is resource limited?