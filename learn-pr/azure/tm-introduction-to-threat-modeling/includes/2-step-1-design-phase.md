The design phase is the starting ground for your threat modeling activities. Gather as much data as possible about what you're building and what you're using to build it.

## Goals

- Develop a clear picture of how your system works
- List every service consumed by your system
- Enumerate all the assumptions about the environment and default security configurations
- Create a data-flow diagram that uses the right context depth level

> [!IMPORTANT]
> If you don't complete this phase, you might overlook important security-design considerations for your system, which can put your customers at risk.

## Ask questions about your system

Ask as many questions as possible about your system. Here are a few questions to consider:

|Area|Questions|
|----|---------|
|**System description**|What does the system do? What are the business processes handled by the service? Are they clearly defined?|
|**System environment**|Will the system be built on the cloud or on-premises? On which operating system is it built? Does it use containers? Is the system an application, service, or something entirely different?|
|**Scenarios**|How will the system be used? How will it not be used?|
|**Permissions**|Does the system have script-execution, data, or hardware-access requirements? If so, what are they?|
|**Cloud provider**|Which cloud provider does the system use? What default security configuration options does the provider offer? How do these options affect the system security requirements?|
|**Operating system**|Which Operating System will the system use? What default security configuration options does the operating system offer? How do these options affect the system security requirements?|
|**First- and third-party**|Which first- and third-party services will the system use? What default security configuration options do they offer? How do these options affect the system security requirements?|
|**Accounts**|What are the account types that the system uses, like users and administrators? Are these accounts be local or cloud-enabled? What access do they need and why?|
|**Identity & access control**|How does the system help secure those accounts? Does it rely on Microsoft Entra ID? Does it use features like Access Control Lists (ACL), multifactor authentication (MFA), and Session control?|
|**Tokens & sessions**|Will the system process requests like SOAP or REST APIs? How does it handle different sessions?|
|**Bypass**|Will the system use or require back doors? If so, how does that bypass work?|
|**Logging, monitoring and backing up**|What are the mechanisms the system uses to log security events, monitor for anomalies, and back up system data? Which event types does capture?|
|**Network**|What are all the intrusion, detection, and protection systems that will be used? How is communication encrypted?|
|**Data**|What type of data will the system create or handle? What will the data classification type be? How does the system trust data sources? How does it parse data? What are the expected input and output behaviors? How is validation handled? How is data encrypted across all states?|
|**Secrets management**|How does the system handle keys, certificates, and credentials?|

> [!IMPORTANT]
> This list is extensive, but not exhaustive. Speak with your colleagues and security team to capture all relevant context for the system.

> [!NOTE]
> If you have a dedicated security team, schedule a whiteboarding session with them to go over the initial design. This contact can save you a considerable amount of time.

## Create a data-flow diagram

Use the answers to create a data-flow diagram. Your diagram shows data across each stage in the data lifecycle, and includes changes in trust zones. Examples include:

- Human users sign into your web application hosted in Azure to access data
- Administrators change default security configurations for elastic resources used by the web application
- Automated daily scripts monitor activity logs for the web application and notify administrators of any anomalies

Microsoft engineering teams submit data-flow diagrams as part of their security-compliance requirements. These diagrams make it easier to conduct security conversations.

### Diagraming tools

Microsoft engineers recommend using one of two tools available today:

- Threat Modeling Tool
- Visio

### Diagram elements

A data-flow diagram shows the flow of data in a given system. It usually starts with requests from users or data stores and ends with data stores or Analytics Services. The data-flow diagram uses distinct shapes to indicate the elements they represent.

|Element|Shape|Definition|
|-------|-----|----------|
|Process|:::image type="content" source="../media/process50.png" alt-text="Diagram shows the Process shape, which is a circle.":::|Task that receives, modifies, or redirects input to output, like a web service.|
|Data store|:::image type="content" source="../media/data-store50.png" alt-text="Diagram shows the Data Store shape, which is two parallel horizontal lines.":::|Permanent and temporary data storage, like a web cache and Azure-managed databases.|
|External entity|:::image type="content" source="../media/external-entity50.png" alt-text="Diagram shows the External Entity shape, which is a square.":::|Task, entity, or data store outside of your direct control, like users and third-party APIs.|
|Data-flow|:::image type="content" source="../media/data-flow50.png" alt-text="Diagram shows the Data-flow shape, which is two parallel diagonal arrows.":::|Data movement between processes, data stores, and external entities, like connection strings and payloads.|
|Trust boundary|:::image type="content" source="../media/trust-boundary-box50.png" alt-text="Diagram shows the Trust Boundary Box shape, which is a square composed of a dashed line."::: :::image type="content" source="../media/trust-boundary-line50.png" alt-text="Diagram shows Trust Boundary Line shape, which is a dashed line.":::|Trust-zone changes as data flows through the system, like users using the internet to access a secured corporate network.|

Data-flow diagram elements also need context to help anyone understand how they're used and secured in the system.

## Information to include in the data-flow diagram

The amount of information to include in the data-flow diagram depends on a few key factors:

|Factor|Explanation|
|------|-----------|
|Type of system you're building|Systems that don't handle sensitive data or are used only internally might not need as much context as an externally facing system|
|Required context from your security team|Security teams are precise with what they look for in threat models. Speak with your security team to confirm the required depth layer|

Failure to include the right context leads to incomplete security reviews and potentially vulnerable systems.

### Diagram layers

To help you understand how much information to include, choose between these four context depth layers:

|Depth layer|Title|Description|
|-----------|-----|-----------|
|0|System|Starting point for any system. Data-flow diagram contains major system parts with enough context to help you understand how they work and interact with each other.|
|1|Process|Focus on data-flow diagrams for each part of the system by using other data-flow diagrams. Use this layer for every system, especially if it handles sensitive data. The context at this layer helps you identify threats and ways to reduce or eliminate risks more efficiently.|
|2|Subprocess|Focus on data-flow diagrams for each subpart of a system part. Used for systems considered critical. Examples include systems for secured environments, systems that handle highly sensitive data, or systems that contain a high risk rating.|
|3|Lower-Level|Focus on highly critical and kernel-level systems. Data-flow diagrams describe each subprocess in minute detail.|

> [!NOTE]
> Most data-flow diagrams should contain *both Layers 0 and 1* depth layers. Speak with your security team to confirm the required layer depth.
