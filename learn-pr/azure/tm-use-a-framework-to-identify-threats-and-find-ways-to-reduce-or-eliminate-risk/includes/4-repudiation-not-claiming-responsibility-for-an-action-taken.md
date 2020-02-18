## What is It?

**Repudiation** occurs when someone, with or without malicious intent, takes an action but claims otherwise. Examples include:

- Denying the modification of logs containing sensitive actions
- Using someone else's account to avoid getting caught
- Claiming to not have deleted database records

> [!NOTE]
> System logs are a goldmine for an attacker, not just to manipulate but also gather data about users, environment and weaknesses.

## What's at Risk?

### Elements

|Name|Definition|
|----|----------|
|Process|Activity that modifies or redirects input to an output|
|External Entity|Process, data store, or even full fledged applications outside of your control|
|Data Store|Permanent or temporary data storage|

### Interactions

|Name|Definition|
|----|-----------|
|Process <-> Process|A task sends or receives data to or from another task|
|Process <-> External Entity|A task sends or receives data to or from a user|
|Process <-> Data Store|A task sends or receives data to or from a data store|

## How Can I Prevent It?

**Non-Repudiation** ensures each action can be traced back to its origin by creating and protecting security logs.

### Common Security Controls

- Strong Authentication
- Secure Logging and Monitoring
- Digital Signatures
- Secure Timestamps
- Trusted Third Parties

> [!TIP]
> **Good Question to Ask**: Can I tie every action to an identity?