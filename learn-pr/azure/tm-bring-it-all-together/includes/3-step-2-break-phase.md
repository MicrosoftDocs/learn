## Focused Threat Modeling Approach

Use the system-focused approach to provide you with a framework to help analyze the system and how it affects both logical and physical assets (see Approach Your Data-Flow Diagram with the Right Threat Model Focus module).

> [!NOTE]
> The STRIDE framework is integrated with the system focused approach

## Depth Layer

Talk to your colleagues and security team to select the right depth layer for your data-flow diagram.

Regardless of layer depth, data-flow diagrams should fit in a single page. Provide as much as context as possible and clearly label each element so anyone understands how it works.

Use this summary as reference (see Provide Context with the Right Depth Layer module).

### Layer 0 - System

The System Layer is the starting ground for any system and must be created for all your systems. Data-flow diagrams in this layer contain major system parts with enough context to help you understand how they work and interact with each other.

### Layer 1 - Process

The Process Layer focuses on data-flow diagrams for each system part. Use the Process Layer for every system, especially if it handles sensitive data. The likelihood of a breach in these systems would be higher. The context at this level helps you identify threats and ways to reduce or eliminate risks more efficiently.

> [!NOTE]
> Most data-flow diagrams should have this level of context

### Layer 2 - Subprocess

The Subprocess Layer focuses on data-flow diagrams for each system subpart. It is used for systems considered critical by the organization, such as the ones used in secured environments, handle sensitive data or have a high risk rating. A breach in a system subpart could put the entire system, customers, and organization at critical risk.

### Layer 3 - Lower-Level

Highly critical and kernel-level systems should be threat modeled at this layer. Data-flow diagrams at this level describe each subprocess in minute detail. Also, it's common to have multiple rounds of security reviews just for one subprocess.

## Threat Modeling Framework

Look at each element and individual interaction to come up with potential system threats. Use the information below as reference (see Use a Framework to Identify Threats and Find Ways to Reduce or Eliminate Risk module):

### Spoofing

Pretending to be someone or something else

#### Example

- Attacker sends an email to users from an account that seems legitimate with malicious links and attachments to capture their credentials, data, and device access
- Attacker spoofs SSIDs and IP addresses while using open and inherently insecure TCP/IP protocols to send malicious payloads to victims

#### Elements to Look At

- Process
- External Entity

#### Interactions to Look At

- Process <-> Process
- Process <-> Data Store
- Process <-> External Entity

### Tampering

Changing data without authorization

#### Example

- Modifying data temporarily stored in cache, sent over-the-wire or permanently stored in databases to compromise data integrity
- Inserting malicious payloads into browser caches to cause erratic behavior in processes and data stores
- Modifying memory through weak API call handling to cause crashes and disclosure of sensitive error messages
- Redirecting data to compromised machines to take over the system
- Tricking users into joining a network or downloading a file, which grants them traffic and device access (used in combination with spoofing)

#### Elements to Look At

- Process
- Data store
- Data-flow

#### Interactions to Look At

- Process <-> Data Store
- Data-flow <-> Trust boundary

### Repudiation

Not claiming responsibility for an action taken

#### Example

- Denying the modification of logs containing sensitive actions
- Using someone else's account to avoid getting caught
- Claiming to not have deleted database records

#### Elements to Look At

- Process
- External Entity
- Data Store

#### Interactions to Look At

- Process <-> Process
- Process <-> External Entity
- Process <-> Data Store

### Information Disclosure

Seeing data without permission

#### Example

- System discloses sensitive data through error messages
- Users access unauthorized documents and folders with weak security controls
- Users access data flowing through an unsecured network

#### Elements to Look At

- Process
- Data store
- Data-flow

#### Interactions to Look At

- Process -> Process
- Process <-> External Entity
- Process <-> Data Store
- Data Flow <-> Trust Boundary

### Denial of Service

Overwhelming the system

#### Example

- Flooding the network with requests
- Absorbing memory and CPU processes
- Crashing data stores with an overwhelming number of requests
- 
#### Elements to Look At

- Process
- Data store
- Data-flow
- 
#### Interactions to Look At

- Process -> Process
- Process <-> External Entity
- Process <-> Data Store
- Data Flow <-> Trust Boundary

### Elevation of Privilege

Having permissions I should not have

#### Example

- Extracting data by exploiting weaknesses in input handling logic or memory
- Finding and using privileged accounts to corrupt the service (used in combination with spoofing and tampering threats)

#### Elements to Look At

- Process
 
#### Interactions to Look At

- Process <-> Process
- Process <- External Entity
- Process <- Data Store
