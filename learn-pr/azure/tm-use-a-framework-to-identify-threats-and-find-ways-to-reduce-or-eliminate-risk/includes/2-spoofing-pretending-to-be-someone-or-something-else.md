## What is It?

**Spoofing** occurs when a malicious person or a program successfully impersonates you or your system to conduct malicious activities. Examples include:

- Attacker sends an email to users from an account that seems legitimate with malicious links and attachments to capture their credentials, data, and device access
- Attacker spoofs SSIDs and IP addresses while using open and inherently insecure TCP/IP protocols to send malicious payloads to victims

## What's at Risk?

### Elements

|Name|Definition|
|----|-----------|
|Process|Activity that modifies or redirects input to an output|
|External Entity|Process, data store, or even full fledged applications outside of your control|

### Interactions

|Name|Definition|
|----|-----------|
|Process <-> Process|A task receives or sends data to or from a task|
|Process <-> Data Store|A task sends or receives data to or from a data store|
|Process <-> External Entity|A task sends or receives data to or from an external entity|
 
## How Can I Prevent It?

**Authentication** verifies that users and systems are who they claim to be. Examples include:

- Sending and receiving messages signed with digital signatures to authenticate origin and ensure message integrity
- Securing data transmissions with SSL/TLS to encrypt traffic between source and target
- Using unique credentials with expiring tokens, passwords or multi-factor authentication to help secure user, admin and service accounts

### Common Security Controls

To authenticate data:

- Hashes
- Message Authentication Codes
- Digital Signatures

To authenticate system:

- User Authentication
- Cookie Authentication
- Kerberos
- SSL/TLS
- Certificates
- IPSec
- Digitally Signed Packets

> [!TIP]
> **Good Question to Ask**: Have I authenticated both sides of the communication?
