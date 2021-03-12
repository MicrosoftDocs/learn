In Security Center, there are various alerts for many different resource types. Security Center generates alerts for resources deployed on Azure and for resources deployed on on-premises and hybrid cloud environments.  Security alerts are triggered by advanced detections and are available only with Azure Defender. 

## Respond to today's threats

There have been significant changes in the threat landscape over the last 20 years. In the past, companies typically only had to worry about website defacement by individual attackers who were mostly interested in seeing "what they could do". Today's attackers are much more sophisticated and organized. They often have specific financial and strategic goals. They also have more resources available to them, as they might be funded by nation states or organized crime.

These changing realities have led to an unprecedented level of professionalism in the attacker ranks. No longer are they interested in web defacement. They are now interested in stealing information, financial accounts, and private data – all of which they can use to generate cash on the open market or use a particular business, political, or military position. Even more concerning than those attackers with a financial objective are the ones who breach networks to harm infrastructure and people.

In response, organizations often deploy various point solutions focused on defending either the enterprise perimeter or endpoints by looking for known attack signatures. These solutions tend to generate a high volume of low fidelity alerts, which require a security analyst to triage and investigate. Most organizations lack the time and expertise required to respond to these alerts – so many go unaddressed.

In addition, attackers have evolved their methods to subvert many signature-based defenses and adapt to cloud environments. New approaches are required to more quickly identify emerging threats and expedite detection and response.

## What are security alerts and security incidents?

Alerts are the notifications that Security Center generates when it detects threats on your resources. Security Center prioritizes and lists the alerts, along with the information needed for you to quickly investigate the problem. Security Center also provides recommendations for how you can remediate an attack.

A security incident is a collection of related alerts instead of listing each alert individually. Security Center uses Cloud Smart Alert Correlation to correlate different alerts and low fidelity signals into security incidents.

Using incidents, Security Center provides you with a single view of an attack campaign and all of the related alerts. This view enables you to quickly understand what actions the attacker took, and what resources were affected. For more information, see Cloud smart alert correlation.

## How does Security Center detect threats?

Microsoft security researchers are constantly on the lookout for threats. Because of our global presence in the cloud and on-premises, we have access to an expansive set of telemetry. The wide-reaching and diverse collection of datasets enable us to discover new attack patterns and trends across our on-premises consumer and enterprise products, as well as our online services. As a result, Security Center can rapidly update its detection algorithms as attackers release new and increasingly sophisticated exploits. This approach helps you keep pace with a fast-moving threat environment.

To detect real threats and reduce false positives, Security Center collects, analyzes, and integrates log data from your Azure resources and the network. It also works with connected partner solutions, like firewall and endpoint protection solutions. Security Center analyzes this information, often correlating information from multiple sources, to identify threats.

Security Center employs advanced security analytics, which go far beyond signature-based approaches. Breakthroughs in big data and machine learning technologies are used to evaluate events across the entire cloud fabric – detecting threats that would be impossible to identify using manual approaches and predicting the evolution of attacks. These security analytics include:

- **Integrated threat intelligence**: Microsoft has an immense amount of global threat intelligence. Telemetry flows in from multiple sources, such as Azure, Microsoft 365, Microsoft CRM online, Microsoft Dynamics AX, outlook.com, MSN.com, the Microsoft Digital Crimes Unit (DCU), and Microsoft Security Response Center (MSRC). Researchers also receive threat intelligence information shared among major cloud service providers and feeds from other third parties. Azure Security Center can use this information to alert you to threats from known bad actors.

- **Behavioral analytics**: Behavioral analytics is a technique that analyzes and compares data to a collection of known patterns. However, these patterns are not simple signatures. They are determined through complex machine learning algorithms that are applied to massive datasets. They are also determined through careful analysis of malicious behaviors by expert analysts. Azure Security Center can use behavioral analytics to identify compromised resources based on analysis of virtual machine logs, virtual network device logs, fabric logs, and other sources.

- **Anomaly detection**: Azure Security Center also uses anomaly detection to identify threats. In contrast to behavioral analytics (which depends on known patterns derived from large data sets), anomaly detection is more "personalized" and focuses on baselines specific to your deployments. Machine learning is applied to determine normal activity for your deployments. Then, rules are generated to define outlier conditions that could represent a security event.

## How are alerts classified?

Security Center assigns a severity to alerts to help you prioritize the order in which you attend to each alert, so when a resource is compromised, you can get to it right away. The severity is based on how confident Security Center is in the finding or the analytic used to issue the alert and the confidence level that there was malicious intent behind the activity that led to the alert.

- High: There is a high probability that your resource is compromised. You should look into it right away. Security Center has high confidence in both the malicious intent and in the findings used to issue the alert. For example, an alert detects the execution of a known malicious tool such as Mimikatz, a common tool used for credential theft.

- Medium: This is probably a suspicious activity that might indicate that a resource is compromised. Security Center's confidence in the analytic or finding is medium, and the confidence of malicious intent is medium to high. These would usually be machine learning or anomaly-based detections. For example, a sign-in attempt from an anomalous location.

- Low: This might be a benign positive or a blocked attack.

  - Security Center is not confident enough that the intent is malicious, and the activity might be innocent. For example, log clear is an action that might happen when an attacker tries to hide their tracks, but in many cases it is a routine operation performed by admins.

  - Security Center doesn't usually tell you when attacks were blocked unless it's an interesting case that we suggest you look into.

- Informational: You will only see informational alerts when you drill down into a security incident or if you use the REST API with a specific alert ID. An incident is typically made up of a number of alerts, some of which might appear on their own to be only informational, but in the context of the other alerts might be worthy of a closer look.

## Continuous monitoring and assessments

Azure Security Center benefits from having security research and data science teams throughout Microsoft who continuously monitor for changes in the threat landscape. This includes the following initiatives:

- **Threat intelligence monitoring**: Threat intelligence includes mechanisms, indicators, implications, and actionable advice about existing or emerging threats. This information is shared in the security community, and Microsoft continuously monitors threat intelligence feeds from internal and external sources.

- **Signal sharing**: Insights from security teams across Microsoft's broad portfolio of cloud and on-premises services, servers, and client endpoint devices are shared and analyzed.

- **Microsoft security specialists**: Ongoing engagement with teams across Microsoft that work in specialized security fields, like forensics and web attack detection.

- **Detection tuning**: Algorithms are run against real customer data sets, and security researchers work with customers to validate the results. True and false positives are used to refine machine learning algorithms.

## Understand alert types

The current alert reference list contains over 500 types of alerts.  The reference list can be reviewed at: [Security alerts - a reference guide](https://docs.microsoft.com/azure/security-center/alerts-reference?azure-portal=true)

Each alert type has a description, severity, and MITRE ATTA&CK tactic

### **MITRE ATT&CK tactics**

Understanding the intention of an attack can help you investigate and report the event more easily. To help with these efforts, Azure Security Center alerts include the MITRE tactics with many alerts.  The series of steps that describe the progression of a cyberattack from reconnaissance to data exfiltration is often referred to as a "kill chain".

Security Center's supported kill chain intents are based on version 7 of the MITRE ATT&CK matrix and described in the table below.

| Tactic| Description|
| :--- | :--- |
| PreAttack| PreAttack could be either an attempt to access a certain resource regardless of malicious intent or a failed attempt to gain access to a target system to gather information prior to exploitation. This step is usually detected as an attempt, originating from outside the network, to scan the target system and identify an entry point.|
| InitialAccess| InitialAccess is the stage where an attacker manages to get a foothold on the attacked resource. This stage is relevant for compute hosts and resources such as user accounts, certificates, etc. Threat actors will often be able to control the resource after this stage.|
| Persistence| Persistence is any access, action, or configuration change to a system that gives a threat actor a persistent presence on that system. Threat actors will often need to maintain access to systems through interruptions such as system restarts, loss of credentials, or other failures that would require a remote access tool to restart or provide an alternate backdoor for them to regain access.|
| PrivilegeEscalation| Privilege escalation is the result of actions that allow an adversary to obtain a higher level of permissions on a system or network. Certain tools or actions require a higher level of privilege to work and are likely necessary at many points throughout an operation. User accounts with permissions to access specific systems or perform specific functions necessary for adversaries to achieve their objective may also be considered an escalation of privilege.|
| DefenseEvasion| Defense evasion consists of techniques an adversary may use to evade detection or avoid other defenses. Sometimes these actions are the same as (or variations of) techniques in other categories that have the added benefit of subverting a particular defense or mitigation.|
| CredentialAccess| Credential access represents techniques resulting in access to or control over system, domain, or service credentials used within an enterprise environment. Adversaries will likely attempt to obtain legitimate credentials from users or administrator accounts (local system administrator or domain users with administrator access) to use within the network. With sufficient access within a network, an adversary can create accounts for later use within the environment.|
| Discovery| Discovery consists of techniques that allow the adversary to gain knowledge about the system and internal network. When adversaries gain access to a new system, they must align themselves to what they now have control of and what benefits operating from that system give to their current objective or overall goals during the intrusion. The operating system provides many native tools that aid in this post-compromise information-gathering phase.|
| LateralMovement| Lateral movement consists of techniques that enable an adversary to access and control remote systems on a network and could, but does not necessarily, include execution of tools on remote systems. The lateral movement techniques could allow an adversary to gather information from a system without needing more tools, such as a remote access tool. An adversary can use lateral movement for many purposes, including remote Execution of tools, pivoting to more systems, access to specific information or files, access to additional credentials, or to cause an effect.|
| Execution| The execution tactic represents techniques that result in execution of adversary-controlled code on a local or remote system. This tactic is often used in conjunction with lateral movement to expand access to remote systems on a network.|
| Collection| Collection consists of techniques used to identify and gather information, such as sensitive files, from a target network prior to exfiltration. This category also covers locations on a system or network where the adversary may look for information to exfiltrate.|
| Exfiltration| Exfiltration refers to techniques and attributes that result or aid in the adversary removing files and information from a target network. This category also covers locations on a system or network where the adversary may look for information to exfiltrate.|
| CommandAndControl| The command and control tactic represents how adversaries communicate with systems under their control within a target network.|
| Impact| Impact events primarily try to directly reduce the availability or integrity of a system, service, or network, including manipulation of data to impact a business or operational process. This would often refer to techniques such as ransomware, defacement, data manipulation, and others.|

