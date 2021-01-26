The fix phase is where the fate of all threats is decided. Each STRIDE threat maps to one or more security controls, which offer different functions and types to choose from.

## Goals

- Measure each threat against a prioritization framework or security bug bar
- Track each threat as a task or work item in a bug management service
- Generate security control recommendations that are mapped to STRIDE threats
- Select one or more security control types and functions to address each threat
- Resolve tasks

> [!IMPORTANT]
> If you don't complete this phase, you won't find the security controls to help reduce risk or track each threat properly.

## Set up a threat tracking workflow

### Prioritize threats

Start by measuring each threat against a prioritization framework or security bug bar. This process helps you arrange resources to fix issues deemed most important to your organization.

The process uses three key variables:

|Variable|Description|
|--------|-----------|
|**Impact**|Uses STRIDE categories to assign impact.|
|**Severity**|Uses internal bug bar or prioritization framework to assign severity using worst case scenarios.|
|**Risk**|Uses a calculation of security control effectiveness and implementation cost.|

> [!TIP]
> Microsoft engineers use an internal security bug bar that assigns threats with a Critical, Important, Moderate, Low, or Information severity rating. Check with your security team to confirm how to prioritize your issues.

### Create tasks

Next, add each threat in a bug management solution like Azure DevOps Services. Some of the benefits include:

- Reinforces issue ownership
- Effectively tracks history
- Gives you the ability to use standardized templates for priority and resolution exercises

## Rate threat effectiveness and cost

Visit each security control recommendation mapped to STRIDE threats. Write down the ones that are most effective and least expensive to implement. Here are a few examples:

| Threat | Security Control | Security Control Example |
| ------ | ---------------- | ------------------------ |
|**Spoofing**|Authentication|Sending and receiving messages signed with digital signatures to authenticate origin and ensure message integrity.|
|**Tampering**|Integrity|Validating input to prevent the processing of malicious payloads and mishandling of unexpected behavior.|
|**Repudiation**|Non-repudiation|Creating and protecting security logs containing user actions and timestamps.|
|**Information disclosure**|Confidentiality|Applying access control lists to ensure the right users can access to the right data.|
|**Denial of service**|Availability|Using elastic resources to manage growing or shrinking usage.|
|**Elevation of privilege**|Authorization|Running the service using the least possible amount of access.|

> [!TIP]
> You may come across security controls that can reduce or completely eliminate multiple threats at once. As an example, using SSL/TLS creates secure transmission channels to help prevent malicious data modification or disclosure.

## Security control types and functions

Security controls have different types and functions. When combined, they help secure your system and create multiple layers of security, also known as defense-in-depth.

You can choose one or more security control types:

- Physical, like cameras
- Technical, like encryption
- Administrative, like policies

They may have one or more security control functions:

|Function|Description|
|--------|-----------|
|**Preventive**|Reduces the probability or impact of a threat, like firewalls.|
|**Detective**|Identifies attacks as they happen, like surveillance.|
|**Corrective**|Controls how the system responds to an ongoing attack, like system patches.|
|**Recovery**|Recovers system from an attack, like backups.|
|**Deterrent**|Keeps attackers away from the system, like least privilege.|

## Add security control details to each issue

Add the details to each issue in the bug management solution, then resolve each issue with one of the following resolutions. They'll vary slightly from organization to organization:

|Resolution|Description|
|----------|-----------|
|**Reduce**|Issue will be addressed with bug fixes or redesign to reduce or eliminate threat impact and severity.|
|**Transfer**|Issue will be handled by another system or team.|
|**Avoid**|The part of the system containing the issue will be cut.|
|**Accept**|Risk will be accepted without a resolution. It will require the approval of an authorized risk decision maker, which may be based on threat severity. Critical severity threats may require approval from senior leadership, while a defense-in-depth risk may be approved by a senior engineer. Speak with your team for strategic guidance.|