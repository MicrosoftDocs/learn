## What is It?

**Information disclosure** occurs when sensitive data is exposed to unauthorized individuals. It can happen with or without intention. Examples include:

- System discloses sensitive data through error messages
- Users access unauthorized documents and folders with weak security controls
- Users access data flowing through an unsecured network

## What's at Risk?

### Elements

|Name|Definition|
|----|----------|
|Process|Activity that modifies or redirects input to an output|
|Data store|Permanent or temporary data storage|
|Data-flow|Data movement between elements|

### Interactions

|Name|Definition|
|----|-----------|
|Process -> Process|A task sends data to another task|
|Process <-> External Entity|A task sends or receives data to or from a user|
|Process <-> Data Store|A task sends or receives data to or from a data store|
|Data Flow <-> Trust Boundary|Data is transmitted from a trusted environment to someone over the internet (and vice-versa)|

## How Can I Prevent It?

**Confidentiality** ensures data is protected. Examples include:

- Applying access control lists to ensure the right users can access to the right data
- Encrypting data at-rest, in-transit, and in-use
- Enforcing SSL/TLS to secure transmission
- Using IPSec tunnels to secure communication across endpoints

### Common Security Controls

- Encryption
- Access Control Lists (ACL)

> [!TIP]
> **Good Question to Ask**: Can I be sure no one can see my data in transit and at rest?