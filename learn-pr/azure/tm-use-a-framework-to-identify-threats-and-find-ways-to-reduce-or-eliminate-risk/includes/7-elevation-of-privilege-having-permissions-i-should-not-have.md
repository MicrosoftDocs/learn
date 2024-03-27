**Elevation of privilege** occurs when individuals access resources without permission. Examples include:

- Extracting data by exploiting weaknesses in input-handling logic or memory.
- Finding and using privileged accounts to corrupt the service (used in combination with spoofing and tampering threats).

## Elements and interactions at risk from elevation of privilege

### Element

|Name|Shape|Definition|
|----|-----|----------|
|Process|![Process.](../media/process50.png)|Activity that modifies or redirects input to an output|

### Interaction

|Name|Interaction|Definition|
|----|-----------|----------|
|Process <-> Process|![Process to Process Interaction.](../media/process-process.png)|A task sends data to another task|
|Process <- External entity|![Process to External Entity Unilateral Interaction.](../media/process-externalentity-unilateral.png)|A task receives data from a user|
|Process <- Data store|![Process to Data Store Unilateral Interaction.](../media/process-datastore-unilateral.png)|A task receives data from a data store|

## How to prevent elevation of privilege

**Authorization** ensures users have proper permissions. Examples include:

- Implementing authorization mechanisms to verify permissions to data and resources.
- Applying security controls to run the service using the least possible amount of access.
- Monitoring access to detect anomalies and unauthorized access attempts.

### Common security controls to reduce or eliminate risk

- Access-control lists (ACL)
- Role-based access controls (RBAC)
- Group-based access
- Permissions
- Input validation

> [!TIP]
> **Good question to ask:**
> How do I know the user is allowed to do this?
