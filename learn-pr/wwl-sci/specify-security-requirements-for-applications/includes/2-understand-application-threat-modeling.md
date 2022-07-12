
Do a comprehensive analysis to identify threats, attacks,
vulnerabilities, and countermeasures. Having this information can
protect the application and its threats to the system. Start with simple
questions to gain insight into potential risks. Then, progress to
advanced techniques using threat modeling.

#### 1- Gather information about the basic security controls

A threat modeling tool will produce a report of all threats identified.
This report is typically uploaded into a tracking tool or converted to
work items that can be validated and addressed by the developers. The
threat model should be updated and integrated into the code management
process as new features are added to the solution. If a security issue
is found, there should be a process to triage issue severity and
determine when and how to remediate (such as in the next release cycle
or a faster release).

Start by gathering information about each component of the application.
The answers to these questions will identify gaps in basic protection
and clarify the attack vectors.

#### 2- Evaluate the application design progressively

Analyze application components and connections and their relationships.
Threat modeling is a crucial engineering exercise that includes defining
security requirements, identifying and mitigating threats, and
validating those mitigations. This technique can be used at any
application development or production stage, but it's most effective
during the design stages of new functionality.

Popular methodologies include:

[STRIDE](/azure/security/develop/threat-modeling-tool-threats):

| Category               | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|:--|:--|
| Spoofing               | Involves illegally accessing and then using another user's authentication information, such as username and password                                                                                                                                                                                                                                                                                                                                                                                        |
| Tampering              | Involves the malicious modification of data. Examples include unauthorized changes made to persistent data, such as that held in a database and the alteration of data as it flows between two computers over an open network, such as the Internet                                                                                                                                                                                                                                                         |
| Repudiation            | Associated with users who deny performing an action without other parties having any way to prove otherwise for example, a user performs an illegal operation in a system that lacks the ability to trace the prohibited operations. Non-Repudiation refers to the ability of a system to counter repudiation threats. For example, a user who purchases an item might have to sign for the item upon receipt. The vendor can then use the signed receipt as evidence that the user did receive the package |
| Information Disclosure | Involves the exposure of information to individuals who are not supposed to have access to it for example, the ability of users to read a file that they were not granted access to, or the ability of an intruder to read data in transit between two computers                                                                                                                                                                                                                                            |
| Denial of Service      | Denial of service (DoS) attacks deny service to valid users for example, by making a Web server temporarily unavailable or unusable. You must protect against certain types of DoS threats simply to improve system availability and reliability                                                                                                                                                                                                                                                            |
| Elevation of Privilege | An unprivileged user gains privileged access and thereby has sufficient access to compromise or destroy the entire system. Elevation of privilege threats include those situations in which an attacker has effectively penetrated all system defenses and become part of the trusted system itself, a dangerous situation indeed                                                                                                                                                                           |

Microsoft Security Development Lifecycle uses STRIDE and provides a tool
to assist with this process. This tool is available at no additional
cost. For more information, see [Microsoft Threat Modeling Tool](https://www.microsoft.com/securityengineering/sdl/threatmodeling).

-   [Open Web Application Security Project (OWASP)](https://owasp.org/www-community/Threat_Modeling_Process) has documented a threat modeling approach for applications.

 Integrate threat modeling through automation using secure operations.
Here are some resources:

-   Toolkit for [Secure DevOps on Azure](https://azsk.azurewebsites.net/).

-   [Guidance on DevOps pipeline security](https://owasp.org/www-project-devsecops-guideline/) by OWASP.

#### 3- Mitigate the identified threats

The threat modeling tool produces a report of all the threats
identified. After identifying a potential threat, determine how it can
be detected and respond to that attack. Define a process and timeline
which minimizes exposure to any identified vulnerabilities in the
workload so that those vulnerabilities can't be left unaddressed.

Use the *Defense-in-Depth* approach. This can help identify controls
needed in the design to mitigate risk if a primary security control
fails. Evaluate how likely it is for the primary control to fail. If it
does, what is the extent of the potential organizational risk? Also,
what is the effectiveness of the additional control (especially in cases
that would cause the primary control to fail)? Based on the evaluation,
apply Defense-in-Depth measures to address potential failures of
security controls.

The principle of *least privilege* is one way of implementing
Defense-in-Depth. It limits the damage that a single account can do.
Grant the least number of privileges to accounts that allows them to
accomplish the required permissions within a time period. This helps
mitigate the damage of an attacker who gains access to the account to
compromise security assurances.

### Microsoft Threat Modeling Tool mitigations

The Threat Modeling Tool is a core element of the Microsoft Security
Development Lifecycle (SDL). It allows software architects to identify
and mitigate potential security issues early when they're relatively
easy and cost-effective to resolve. As a result, it greatly reduces the
total cost of development. Also, we designed the tool with non-security
experts in mind, making threat modeling easier for all developers by
providing clear guidance on creating and analyzing threat models.

#### Mitigation categories

The Threat Modeling Tool mitigations are categorized according to the
Web Application Security Frame, which consists of the following:

| Category                 | Description                                                                                                                                                                                                                                                                                                                                             |
|:--|:--|
| Auditing and Logging     | Who did what and when? Auditing and logging refer to how your application records security-related events                                                                                                                                                                                                                                               |
| Authentication           | Who are you? Authentication is the process where an entity proves the identity of another entity, typically through credentials, such as a user name and password                                                                                                                                                                                       |
| Authorization            | What can you do? Authorization is how your application provides access controls for resources and operations                                                                                                                                                                                                                                            |
| Communication Security   | Who are you talking to? Communication Security ensures all communication done is as secure as possible                                                                                                                                                                                                                                                  |
| Configuration Management | Who does your application run as? Which databases does it connect to? How is your application administered? How are these settings secured? Configuration management refers to how your application handles these operational issues                                                                                                                    |
| Cryptography             | How are you keeping secrets (confidentiality)? How are you tamper-proofing your data or libraries (integrity)? How are you providing seeds for random values that must be cryptographically strong? Cryptography refers to how your application enforces confidentiality and integrity                                                                  |
| Exception Management     | When a method call in your application fails, what does your application do? How much do you reveal? Do you return friendly error information to end users? Do you pass valuable exception information back to the caller? Does your application fail gracefully?                                                                                       |
| Input Validation         | How do you know that the input your application receives is valid and safe? Input validation refers to how your application filters, scrubs, or rejects input before additional processing. Consider constraining input through entry points and encoding output through exit points. Do you trust data from sources such as databases and file shares? |
| Sensitive Data           | How does your application handle sensitive data? Sensitive data refers to how your application handles any data that must be protected either in memory, over the network, or in persistent stores                                                                                                                                                      |
| Session Management       | How does your application handle and protect user sessions? A session refers to a series of related interactions between a user and your Web application                                                                                                                                                                                                |


