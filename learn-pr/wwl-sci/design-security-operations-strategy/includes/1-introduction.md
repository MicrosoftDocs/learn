## Design a Security Operations Strategy 

In this module, you'll learn how to: 

- Design a logging and auditing security strategy 

- Develop security operations for hybrid and multi-cloud environments 

- Design a strategy for Security Information and Event Management (SIEM) and Security Orchestration, Automation, and Response (SOAR) 

- Evaluate security workflows 

- Review security strategies for incident management 

- Evaluate security operations for technical threat intelligence  

- Monitor sources for insights on threats and mitigations. Develop Integration points in an architecture. 
 
The content in the module will help you prepare for Exam SC-100: Cybersecurity Architecture. The module concepts are covered in: 

- Design a Zero Trust Strategy and Architecture 

- Design a Security Operations Strategy 

### Prerequisites 

Conceptual knowledge of security policies, requirements, zero trust architecture, and management of hybrid environments 

Working experience with zero trust strategies, applying security policies, and developing security requirements based on business goals 

### Security Operations Strategy Overview 

One of the significant changes in perspectives that is a hallmark of a Zero Trust security framework is moving away from trust-by-default toward trust-by-exception. 
However, a reliable way to establish trust once trust is needed. Since you no longer assume that requests are trustworthy, establishing a means to attest to the trustworthiness of 
the request is critical to proving its point-in-time trustworthiness. This attestation requires gaining visibility into the activities on and around the request. 

Our other Zero Trust guides defined the approach to implementing an end-to-end Zero Trust approach across [identities](https://aka.ms/ZTIdentity), [endpoints](https://aka.ms/ZTEndpoints) and devices, [data](https://aka.ms/ZTData), [apps](https://aka.ms/ZTApplications), [infrastructure](https://aka.ms/ZTInfrastructure), and [networks](https://aka.ms/ZTNetwork). 
All these investments increase your visibility, which gives you better data for making trust decisions. However, adopting a Zero Trust approach in other areas like identities, endpoints, infrastructure and networks, increases the number of incidents Security Operation Center (SOC) analysts need to mitigate.

![Provide integrated capabilities](../media/)

With each of these individual areas generating its relevant alerts, an integrated capability is needed to manage the resulting influx of data to better defend against threats and validate trust in a transaction. The following abilities are needed: 

- Detect threats and vulnerabilities. 

- Investigate. 

- Respond. 

- Hunt. 

- Provide additional context through threat analytics. 

- Assess vulnerabilities. 

- Get help from world class experts 

- Prevent or block events from happening across the pillars. 


Managing threats includes reactive and proactive detection and requires tools that support both. 

- **Reactive detection:** Incidents are triggered from one of the six pillars that can be investigated. Additionally, a management product like a SIEM will likely support another layer of analytics that will enrich and correlate data, resulting in flagging an incident as bad. The next step would then be to investigate to get the full narrative of the attack. 

- **Proactive detection:** Hunting to the data is applied to prove a compromised hypothesis. Threat hunting starts with the assumption there has been a breach, hence hunt for proof that there is indeed a breach. 

Each minute that an attacker has in the environment allows them to continue to conduct attack operations and access sensitive or valuable systems. Maintaining control over environment ensures that compliancy with industry standards, such as information security management and corporate or organizational standards, such as ensuring that network data is encrypted. 

An efficient Security Operations Strategy is most beneficial when there are: 

- Multiple engineering teams working in Azure. 

- Multiple subscriptions to manage. 

- Regulatory requirements that must be enforced. 

- Standards that must be followed for all cloud resources. 

- Defined logging and auditing security process. 
