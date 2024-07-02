The following capabilities are available across multiple products that make up the Microsoft Defender for Endpoint platform.

#### Attack surface reduction

The attack surface reduction set of capabilities provides the first line of defense in the stack. By ensuring configuration settings are properly set and exploit mitigation techniques are applied, this set of capabilities resists attacks and exploitations.

Attack surface reduction capabilities in Microsoft Defender for Endpoint help protect the devices and applications in your organization from new and emerging threats.

 -  **Hardware-based isolation:** Protects and maintains the integrity of the system as it starts and while it's running, and validates system integrity through local and remote attestation. In addition, container isolation for Microsoft Edge helps protect host-operating system from malicious websites.
 -  **Application control:** Moves away from the traditional application trust model where all applications are assumed trustworthy by default to one where applications must earn trust to run.
 -  **Exploit protection:** Applies exploit mitigation techniques to apps your organization uses, both individually and to all apps. Works with third-party antivirus solutions and Microsoft Defender Antivirus (Microsoft Defender AV).
 -  **Network protection:** Extends the malware and social engineering protection offered by Microsoft Defender SmartScreen in Microsoft Edge to cover network traffic and connectivity on your organization's devices. Requires Microsoft Defender AV.
 -  **Controlled folder access:** Helps protect files in key system folders from changes made by malicious and suspicious apps, including file-encrypting ransomware malware. Requires Microsoft Defender AV.
 -  **Attack surface reduction:** Reduces the attack surface of your applications with intelligent rules that stop the vectors used by Office-, script- and mail-based malware. Requires Microsoft Defender AV.
 -  **Network firewall:** Host-based, two-way network traffic filtering that blocks unauthorized network traffic flowing into or out of the local device.

#### Next generation protection

To further reinforce the security perimeter of your network, Microsoft Defender for Endpoint uses next generation protection designed to catch all types of emerging threats. Microsoft Defender Antivirus is a built-in anti-malware solution that provides next generation protection for desktops, portable computers, and servers.

Microsoft Defender Antivirus includes:

 -  Cloud-delivered protection for near-instant detection and blocking of new and emerging threats. Along with machine learning and the Intelligent Security Graph, cloud-delivered protection is part of the next-gen technologies that power Microsoft Defender Antivirus.
 -  Always-on scanning, using advanced file and process behavior monitoring and other heuristics (also known as "real-time protection").
 -  Dedicated protection updates based on machine-learning, human and automated big-data analysis, and in-depth threat resistance research.

#### Endpoint detection and response

Endpoint detection and response capabilities are implemented to detect, investigate, and respond to advanced threats that may have surpassed the first two security pillars. Microsoft Defender for Endpoint offers endpoint detection and response capabilities that detect advanced attacks in near real time. This feature enables security analysts to prioritize alerts effectively, uncover the extent of a breach, and take necessary response actions to remediate the threat.

When a threat is detected, alerts are created in the system for an analyst to investigate. Alerts with the same attack techniques or attributed to the same attacker are aggregated into an entity called incident. Aggregating alerts in this manner makes it easy for analysts to collectively investigate and respond to threats.

Embracing the "assume breach" philosophy, Microsoft Defender for Endpoint persistently gathers a wide range of behavioral cyber telemetry data. This encompasses process details, network activities, in-depth insights into the kernel and memory manager, user sign-in activities, as well as registry and file system modifications. This data is retained for six months, allowing analysts to trace back to the origin of an attack and explore various perspectives during an investigation by pivoting between different views and examining multiple potential vectors.

The response capabilities give you the power to promptly remediate threats by acting on the affected entities.

#### Auto investigation and remediation

With being able to quickly respond to advanced attacks, Microsoft Defender for Endpoint offers automatic investigation and remediation capabilities that help reduce the volume of alerts in minutes at scale. The Microsoft Defender for Endpoint service has a wide breadth of visibility on multiple machines. With this kind of optics, the service generates a multitude of alerts. The volume of alerts generated can be challenging for a typical security operations team to individually address.

To address this challenge, Microsoft Defender for Endpoint uses Automated investigations to significantly reduce the volume of alerts that need to be investigated individually. The Automated investigation feature applies various inspection algorithms and processes used by analysts (such as playbooks) to examine alerts and take immediate remediation action to resolve breaches.

The Automated investigations list shows all the investigations that have been initiated automatically and shows other details such as its status, detection source, and the date for when the investigation was initiated.

#### Secure score

Microsoft Defender for Endpoint provides a security posture capability to help you dynamically assess the security state of your enterprise network, identify unprotected systems, and take recommended actions to improve the overall security state of your network. The Secure score dashboard expands your visibility into the overall security posture of your organization. From this dashboard, can assess the security posture of your organization, see machines that require attention, and recommendations for actions to further reduce the attack surface in your organization. From there you can take action based on the recommended configuration baselines.

This feature is available for machines on Windows 10, version 1703 or later.

The Secure score dashboard displays a snapshot of:

 -  Microsoft secure score
 -  Secure score over time
 -  Top recommendations
 -  Improvement opportunities

The Microsoft secure score tile is reflective of the sum of all the Microsoft Defender security controls that are configured according to the recommended baseline and Microsoft 365 controls. It allows you to drill down into each portal for further analysis. You can also improve this score by taking the steps in configuring each of the security controls in the optimal settings.

#### Advanced hunting

Advanced hunting allows you to hunt for possible threats across your organization using a search and query tool. You can also create custom detection rules based on the queries you created and surface alerts in Microsoft 365 Security Center.

With advanced hunting, you can:

 -  **Use query language with IntelliSense:** Built on top of a query language that gives you the flexibility you need to make hunting more advanced with better results.
 -  **Query the stored telemetry:** The telemetry data is accessible in tables for you to query. For example, you can query process creation, network communication, and other event types.
 -  **Use links to the portal:** Certain query results, such as machine names and file names are direct links to the portal.
 -  **Use query examples:** A welcome page provides examples to get you started with the tables and the query language.

#### Management and APIs

Integrate Microsoft Defender for Endpoint into your existing workflows. Microsoft Defender for Endpoint supports a wide variety of options to ensure that customers can easily adopt the platform. Microsoft Defender for Endpoint has granular control to fit varying environments and requirements.

Machine onboarding is fully integrated into Configuration Manager and Microsoft Intune for client machines and Azure Security Center for server machines, providing end-to-end experience of configuration, deployment, and monitoring. Microsoft Defender for Endpoint supports Group Policy and other third-party tools used for machines management.

Microsoft Defender for Endpoint provides fine-grained control over what users with access to the portal can see and do through the flexibility of role-based access control (RBAC). The RBAC model supports a wide variety of security team structures:

 -  Globally distributed organizations and security teams
 -  Tiered model security operations teams
 -  Fully segregated divisions with single centralized global security operations teams
