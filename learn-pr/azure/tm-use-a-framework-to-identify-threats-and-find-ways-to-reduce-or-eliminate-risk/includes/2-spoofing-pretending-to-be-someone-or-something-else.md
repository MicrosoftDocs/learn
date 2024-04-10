**Spoofing** occurs when a malicious person or a program successfully impersonates you or your system to conduct malicious activities. 

Examples include:

- An attacker sends an email to users from an account that seems legitimate with malicious links and attachments to capture their credentials, data, and device access.
- An attacker spoofs SSIDs and IP addresses while using open and inherently insecure TCP/IP protocols to send malicious payloads to victims.

## Elements and interactions at risk from spoofing attacks

### Element

|Name|Shape|Definition|
|----|-----|-----------|
|Process|![Process.](../media/process50.png)|Activity that modifies or redirects input to an output|
|External Entity|![External Entity.](../media/external-entity50.png)|Process, data store, or even full fledged applications outside your control|

### Interaction

|Name|Interaction|Definition|
|----|-----------|----------|
|Process <-> Process|![Process to Process Interaction.](../media/process-process.png)|A task receives or sends data to or from a task|
|Process <-> Data store|![Process to Data Store Interaction.](../media/process-datastore.png)|A task sends or receives data to or from a data store|
|Process <-> External entity|![Process to External Entity Interaction.](../media/process-externalentity.png)|A task sends or receives data to or from an external entity|
 
## How to prevent spoofing

**Authentication** verifies that users and systems are who they claim to be.

Examples include:

- Sending and receiving messages signed with digital signatures to authenticate origin and ensure message integrity.
- Securing data transmissions with SSL/TLS to encrypt traffic between source and target.
- The use of unique credentials with expiring tokens, passwords, or multi-factor authentication to help secure user, admin, and service accounts.

### Common security controls to reduce or eliminate risk

For your data:

- Hashes
- Message Authentication Codes
- Digital Signatures

For your system:

- User Authentication
- Cookie Authentication
- Kerberos
- SSL/TLS
- Certificates
- IPSec
- Digitally Signed Packets

> [!TIP]
> **Good question to ask:**
> Have I authenticated both sides of the communication?
