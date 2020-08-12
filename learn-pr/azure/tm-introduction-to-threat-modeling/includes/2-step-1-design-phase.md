The design phase is the starting ground for your threat modeling activities. You'll gather as much data as possible about what you're building, and what you're using to build it with.

## Goals

- Develop a clear picture of how your system works
- List every service consumed by your system
- Enumerate all the assumptions about the environment and default security configurations
- Create a data-flow diagram using the right context depth level

> [!IMPORTANT]
> If you don't complete this phase, you might overlook important security design considerations for your system, which can put your customers at risk.

## Ask questions about your system

Ask as many questions as possible about your system. Here are a few questions to consider:

|Area|Questions|
|----|---------|
|**System description**|What does the system do? What are the business processes handled by the service? Are they clearly defined?|
|**System environment**|Will the system be built on the cloud or on-premise? Which OS will it be built on? Will containers be used? Is the system an application, service, or something entirely different?|
|**Scenarios**|How will the system be used? How will it not be used?|
|**Permissions**|Does the system have script execution, data, or hardware access requirements? If so, what are they?|
|**Cloud provider**|Which cloud provider will the system use? What default security configuration options does it provide? How do these options affect the system security requirements?|
|**Operating system**|Which Operating System will the system use? What default security configuration options does it offer? How do these options affect the system security requirements?|
|**First- and third-party**|Which first- and third-party services will the system use? What default security configuration options do they offer? How do these options affect the system security requirements?|
|**Accounts**|What are the account types that will be used in the system, like users and administrators? Will these accounts be local or cloud enabled? What access do they need and why?|
|**Identity & access control**|How will the system help secure those accounts? Will it rely on Azure Active Directory (Azure AD)? Will it use features like Access Control Lists (ACL), Multi-Factor Authentication (MFA) and Session control?|
|**Tokens & sessions**|Will the system process requests like SOAP or REST APIs? How will it handle different sessions?|
|**Bypass**|Will the system use or require back-doors? If so, how will it work?|
|**Logging, monitoring and backing up**|What are the mechanisms used by the system to log security events, monitor for anomalies and back up system data? Which event types will it capture?|
|**Network**|What are all the intrusion, detection, and protection systems that will be used? How will communication be encrypted?|
|**Data**|What type of data will be created or handled by the system? What will the data classification type be? How will the system trust data sources? How will it parse data? What will be the expected input and output behaviors? How will validation be handled? How will data be encrypted across all states?|
|**Secrets management**|How will the system handle keys, certificates, and credentials?|

> [!IMPORTANT]
> The list above is extensive, but not exhaustive. Speak with your colleagues and security team to capture all relevant context for the system.

> [!NOTE]
> If you have a dedicated security team, schedule a white-boarding session with them to go over the initial design. It will save you a considerable amount of time.

## Create a data-flow diagram

Use the answers to create a data-flow diagram. It shows data across each stage in the data lifecycle, and includes changes in trust zones. Examples include:

- Human users signing into your web application hosted in Azure to access data
- Administrators changing default security configurations for elastic resources used by the web application
- Automated daily scripts that monitor activity logs for the web application and notifies administrators of any anomalies

Microsoft engineering teams are required to submit data-flow diagrams as part of their security compliance requirements. These diagrams make it easier to conduct security conversations.

### Diagraming tools

Microsoft engineers recommend using one of two tools available today:

- Threat Modeling Tool
- Visio

### Diagram elements

A data-flow diagram shows the flow of data in a given system. It usually starts with requests from users or data stores and ends with data stores or Analytics Services. The data-flow diagram uses distinct shapes to indicate the elements they represent.

|Element|Shape|Definition|
|-------|-----|----------|
|Process|![Process](../media/process50.png)|Task that receives, modifies, or redirects input to output, like a web service.|
|Data store|![Data Store](../media/data-store50.png)|Permanent and temporary data storage, like a web cache and Azure-managed databases.|
|External entity|![External Entity](../media/external-entity50.png)|Task, entity, or data store outside of your direct control, like users and third-party APIs.|
|Data-flow|![Data-flow](../media/data-flow50.png)|Data movement between processes, data stores, and external entities, like connection strings and payloads.|
|Trust boundary|![Trust Boundary Box](../media/trust-boundary-box50.png) ![Trust Boundary Line](../media/trust-boundary-line50.png)|Trust zone changes as data flows through the system, like users using the internet to access a secured corporate network.|

Data-flow diagram elements also need context to help anyone understand how they're used and secured in the system.

## Information to include in the data-flow diagram

The amount of information to include in the data-flow diagram depends on a few key factors:

|Factor|Explanation|
|------|-----------|
|Type of system you're building|Systems that don't handle sensitive data or are used only internally, may not need as much context as an externally facing system|
|Required context from your security team|Security teams are precise with what they look for in threat models. Speak with your security team to confirm the required depth layer|

Failure to include the right context leads to incomplete security reviews and potentially vulnerable systems.

### Diagram layers

To help you understand how much information to include, choose between these four context depth layers:

|Depth layer|Title|Description|
|-----------|-----|-----------|
|0|System|Starting point for any system. Data-flow diagram contains major system parts with enough context to help you understand how they work and interact with each other.|
|1|Process|Focus on data-flow diagrams for each part of the system using additional data-flow diagrams. Used for every system, especially if it handles sensitive data. The context at this layer should help you identify threats and ways to reduce or eliminate risks more efficiently.|
|2|Subprocess|Focus on data-flow diagrams for each subpart of a system part. Used for systems considered critical. Examples include systems for secured environments, systems that handle highly sensitive data, or systems that contain a high risk rating.|
|3|Lower-Level|Focus on highly critical and kernel-level systems. Data-flow diagrams describe each subprocess in minute detail.|

> [!NOTE]
> Most data-flow diagrams should contain **both Layers 0 and 1** depth layers. Speak with your security team to confirm the required layer depth.

## Tools

Microsoft engineers recommend using a few tools available today:

- Threat Modeling Tool
- Visio
