## Threat Modeling Framework Security Controls

Reduce or eliminate each potential threat by using security controls mapped to STRIDE threats (see **Use a Framework to Identify Threats and Find Ways to Reduce or Eliminate Risk** module):

### Spoofing

Pretending to be someone or something else

#### What to Ask

Have I authenticated both sides of the communication?

#### Security Control

**Authentication** verifies that users and systems are who they claim to be

#### Example

- Sending and receiving messages signed with digital signatures to authenticate origin and ensure message integrity
- Securing data transmissions with SSL/TLS to encrypt traffic between source and target
- Using unique credentials with expiring tokens, passwords or multi-factor authentication to help secure user, admin and service accounts

#### Common Security Controls to Reduce or Eliminate Risk

For Your Data:

- Hashes
- Message Authentication Codes
- Digital Signatures

For Your System:

- User Authentication
- Cookie Authentication
- Kerberos
- SSL/TLS
- Certificates
- IPSec
- Digitally Signed Packets

### Tampering

Changing data without authorization

#### What to Ask

How do I know someone can't change my data in transit or at rest?

#### Security Control

**Integrity** prevents data from being maliciously modified

#### Example

- Validating input to prevent the processing of malicious payloads and mishandling of unexpected behavior
- Signing messages with digital signatures to ensure message is not tampered with
- Using access control lists to apply permissions
- Using SSL/TLS to secure transmission
- Creating an IPSec tunnel to secure communication between endpoints

#### Common Security Controls to Reduce or Eliminate Risk

- Operating system integrity controls
- Access control lists (ACL)
- Digital signatures
- Message authentication codes

### Repudiation

Not claiming responsibility for an action taken

#### What to Ask

Can I tie every action to an identity?

#### Security Control

**Non-Repudiation** ensures each action can be traced back to its origin by creating and protecting security logs.

#### Example

- Creating event logs that trace actions to users

#### Common Security Controls to Reduce or Eliminate Risk

- Strong Authentication
- Secure Logging and Monitoring
- Digital Signatures
- Secure Timestamps
- Trusted Third Parties

### Information Disclosure

Seeing data without permission

#### What to Ask

Can I be sure no one can see my data in transit and at rest?

#### Security Control

**Confidentiality** ensures data is protected

#### Example

- Applying access control lists to ensure the right users can access to the right data
- Encrypting data at-rest, in-transit, and in-use
- Enforcing SSL/TLS to secure transmission
- Using IPSec tunnels to secure communication across endpoints

#### Common Security Controls to Reduce or Eliminate Risk

- Encryption
- Access Control Lists (ACL)

### Denial of Service

Overwhelming the system

#### What to Ask

Are there areas where my service is resource limited?

#### Security Control

**Availability** ensures your system is up and running for users

#### Example

- Using network access control lists to control incoming and outgoing traffic
- Using elastic resources to manage growing or shrinking usage
- Monitoring the system to detect anomalies
- Enabling operating system flags to handle memory and CPU processes
- 
#### Common Security Controls to Reduce or Eliminate Risk

- Access Control Lists (ACL)
- Filtering
- Quotas
- Authorization
- High Availability

### Elevation of Privilege

Having permissions I should not have

#### What to Ask

How do I know the user is allowed to do this action?

#### Security Controls

**Authorization** ensures users have proper permissions

#### Example

- Implementing authorization mechanisms to verify permissions to data and resources
- Applying security controls to run the service using the least possible amount of access
- Monitoring access to detect anomalies and unauthorized access attempts. 

#### Common Security Controls to Reduce or Eliminate Risk

- Access Control Lists (ACL)
- Role-Based Access Controls (RBAC)
- Group-Based Access
- Permissions
- Input Validation

## Prioritize Issues and Apply Security Controls

Bug management services, such as Azure DevOps, keeps track of each threat and security control using default templates and resolution categories. These templates foster collaboration between teams, prevent issues from slipping through the cracks, and provide issue history.

### Issue Prioritization

Apply the established risk management methods used by your organization to help prioritize the threats identified with threat modeling. Microsoft typically prioritizes security issues by (see **Prioritize Your Issues and Apply Security Controls** module):

- **Impact** - STRIDE categories
- **Severity** - Critical, Important, Moderate, Low, Defense-in-Depth (worst case scenarios assumed)
- **Risk** - Risk reduction or elimination is measured by implementation cost

### Issue Resolution

If your organization does not have a default set of resolution options, you can use the ones commonly used with threat modeling (see **Prioritize Your Issues and Apply Security Controls** module):

- **Reduce** - Issue will be addressed with bug fixes, redesign, or risk reduction strategies to reduces or eliminate threat impact or severity
- **Transfer** - Issue will be handled by another system
- **Avoid** - The part of the system containing the issue will be cut
- **Accept** - Risk will be accepted without a resolution. It will require the approval of an authorized risk decision maker, which may be based on threat severity. Critical severity threats may require approval from senior leadership, while a defense-in-depth risk may be approved by a senior engineer. Speak with your team for strategic guidance

### Security Control Types and Functions

Select security controls that can help secure your system across different functions and control types (see **Prioritize Your Issues and Apply Security Controls** module):

|Function|Physical|Logical|Administrative|
|--------|--------|-------|--------------|
|**Preventative**|Locks|Firewalls|Data classification|
|**Detective**|Surveillance|Honeypots|Audit logs|
|**Corrective**|Physical repair|System patches|Incident response plans|
|**Recovery**|Hot-sites|System Backups|Disaster recovery plan|
|**Deterrent**|Fences|Least privilege|Authorized use policy|