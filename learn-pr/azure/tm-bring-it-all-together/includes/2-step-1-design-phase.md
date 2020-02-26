## Requirements and Assumptions

Reference the tables below to capture system requirements and security assumptions:

|High Level|Questions|
|----------|---------|
|**Description**|What does your system do? What are the business processes? Are they clearly defined?|
|**Environment**|Will the system be built on the cloud? on-premise? Which OS will it be built on? Will containers be used? Is your system an application? service?|
|**Scenarios**|How will the system be used? How it will not?|
|**Permissions**|Does the system have script execution, data, or hardware access requirements? If so, what are they?
|**Cloud Provider**| (if applicable) Which cloud provider will it use? What default security configuration options does the Cloud Provider offer? What is the required end-state security configuration for your system?|
|**Operating System**| (if applicable) Which Operating System will it use? What default security configuration options does the Operating System offer? What is the required end-state security configuration for your system?|
|**Third-Party Components**| (if applicable) Which third-party components will it use? What default security configuration options do these third-party components offer? What is the required end-state security configuration for your system?|

|Lower-Level|Questions|
|-----------|---------|
|**Components**|List all first and third-party components to be used|
|**Account Types**|List all account types, such as users, administrators, and DB accounts|
|**Account Context**|Are these accounts local? service?|
|**Identity & Access Control**|How does the system help secure these account types? Does it use Azure Active Directory (AAD)? Access Control Lists (ACL)? Multi-Factor Authentication (MFA)? Session controls?|
|**Tokens & Sessions**|Does the system process SOAP? REST? How does it handle different sessions?|
|**Bypass**|Does the system use or require back-doors? Explain|
|**Logging, Monitoring and Backup**|What are the mechanisms used? Which event types does it capture?|
|**Network**|What are all the intrusion detection and protection systems used? How is communication encrypted?|
|**Data**|What type of data is created or handled by the system? Is it general? PII? How does it trust the data source? How does it parse data? What are the expected input and output behaviors? How is validation handled? How is data encrypted across all states?|
|**Secrets Management**|How does the system handle keys? certificates? credentials?|

> [!IMPORTANT]
> The lists above are extensive, but not exhaustive. Speak with your colleagues and security team to capture all relevant context for the system.

## Data-Flow Diagram Elements

Use data-flow diagram elements properly by referencing the information below (see **Create a Threat Model Using Data-Flow Diagram Elements** module):

### Process

![Process](../media/process50.png)

Task that receives, modifies, or redirects input to output, like a web service

#### Use

- Use it to map a higher-level data-flow diagram to a lower-level data-flow diagram, like a zoom-in feature (refer to **Provide Context with the Right Depth Layer**)
- Place it between data stores to capture task and communication processing
- Place it between external entity interactions to capture task and communication processing
- Use it with other processes to capture task processing

#### Include

- **Code** - is it managed? native?
- **Permission Level** - kernel? local? administrator?
- **Isolation** - does it use a sandbox?
- **Input** - does it accept input from all? administrators? local?
- **Validation** - how is input parsed? validated? accepted?
- **Authentication and Authorization** - does it rely on Azure Active Directory? Access Control Lists (ACL)? Multi-factor authentication (MFA)?

### Data Store

![Data Store Element](../media/data-store50.png)

Permanent and temporary data storage, like a web cache and Azure DB.

#### Use

- Add a data store to start the flow in a data-flow diagram (if applicable)
- Add a process between two data stores to capture communication
- Add an Analytics Service or another consumption service to avoid data sinks in your data-flow diagram (if applicable)

#### Include

- **Type** - Azure SQL? cookies? local?
- **Function** - is it used for shared data? Backups? security logs? credentials? secrets?
- **Permission Level** - what are the access controls in place? who can read write?
- **Additional Controls** - is data encrypted? is disk encrypted? are digital signatures used?

### External Entity

![External Entity](../media/external-entity50.png)

Task, entity, or data store outside of your direct control, like users and third-party APIs

#### Use

- Add an external entity to start the flow in a data-flow diagram (if applicable)
- Add a trust boundary to indicate untrusted to trusted zone changes
- Verify security configurations to avoid inherited risks

#### Include

- **Source** - is it internal? external?
- **Type** - is it human? provider? web service?
- **Input** - does data come in through a graphical user interface? automated?
- **Authentication and Authorization** - does it rely on Azure Active Directory? Access Control Lists (ACL)? Multi-factor authentication (MFA)?

### Data-Flow

![Data-Flow Element](../media/data-flow50.png)

Data movement between elements is represented by directional arrows to indicate communication between data source and destination.

#### Use

- Include a data-flow between each element interaction
- Include a response to each request (if applicable)

#### Include

- **Description** - is it a session token? SQL string? User credentials?
- **Protocol** - HTTPS? SOAP?
- **Sequence** - does it use numeric? alphanumeric?
- **Type** - what is the data type? cookies? XML? SOAP payload? REST payload? JSON payload?
- **Additional Controls** - does it have forgery protection? Does it version TLS 1.2?
- **Authentication and Authorization** - must be included for both source and target elements. Does it rely on Azure Active Directory? Access Control Lists (ACL)? Multi-factor authentication (MFA)?

### Trust Boundary

Trust Boundary Box:

![Trust Boundary Box Element](../media/trust-boundary-box50.png)

Trust Boundary Line:

![Trust Boundary Line Element](../media/trust-boundary-line50.png)

Describes data-flow as it crosses different trust zone levels

#### Use

- Use trust boundary **lines** to represent data flow as it crosses large environments, like the internet
- Use trust boundary **boxes** represent smaller environments, like sandbox environments and corporate networks
- Needed when data originates from service process to local/remote data store
- Needed when data originates from service to another service on the same or a different network

#### Include

- Include trust boundaries to handle data-flow as it crosses different trust zones

## Tools

Microsoft engineers recommend using one of three tools available today (see **Use Recommended Tools to Create a Data-Flow Diagram** module):

- Threat Modeling Tool
- Visio
- Microsoft Threats Manager Platform