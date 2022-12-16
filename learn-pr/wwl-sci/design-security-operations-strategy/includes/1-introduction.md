In this module, you'll learn how to:

- Design a logging and auditing security strategy 
- Develop security operations for hybrid and multicloud environments 
- Design a strategy for Security Information and Event Management (SIEM) and Security Orchestration, Automation, and Response (SOAR) 
- Evaluate security workflows 
- Review security strategies for incident management 
- Evaluate security operations for technical threat intelligence  
- Monitor sources for insights on threats and mitigations. Develop Integration points in an architecture. 
 
The content in the module will help you prepare for exam SC-100: Microsoft Cybersecurity Architect.

## Prerequisites 

Conceptual knowledge of security policies, requirements, zero trust architecture, and management of hybrid environments 

Working experience with zero trust strategies, applying security policies, and developing security requirements based on business goals 

## Security Operations strategy overview 

One of the significant changes in perspectives that are a hallmark of a Zero Trust security framework is moving away from trust-by-default toward trust-by-exception. However, this still requires a reliable way to establish trust once trust is needed. Since you no longer assume that requests are trustworthy, establishing a means to attest to the trustworthiness of the request is critical to proving its point-in-time trustworthiness. This attestation requires gaining visibility into the activities on and around the request. 

All these investments increase your visibility, which gives you better data for making trust decisions. However, adopting a Zero Trust approach in other areas like identities, endpoints, infrastructure and networks, increases the number of incidents Security Operation Center (SOC) analysts need to mitigate.

![Diagram showing the integrated capabilities of a zero trust approach.](../media/provide-integrated-capabilities.png)

With each of these individual areas generating its relevant alerts, an integrated capability is needed to manage the resulting influx of data to better defend against threats and validate trust in a transaction. The following abilities are needed: 

- Detect threats and vulnerabilities
- Investigate
- Respond
- Hunt
- Provide additional context through threat analytics
- Assess vulnerabilities
- Get help from world class experts 
- Prevent or block events from happening across the pillars

Managing threats includes reactive and proactive detection and requires tools that support both. 

- **Reactive detection:** Incidents are triggered from one of the six Zero Trust pillars. Additionally, a management product like a SIEM will likely support another layer of analytics that will enrich and correlate data, resulting in flagging an incident as bad. The next step would then be to investigate to get the full narrative of the attack. 

- **Proactive detection:** Hunting with the available data is performed to prove a hypothesis of compromise. Threat hunting starts with the assumption that there has been a breach, and your goal is to hunt for proof which confirms that assumption. 

Each minute that an attacker has in the environment allows them to continue to conduct attacks and access sensitive or valuable systems. Maintaining control over the environment ensures compliance with industry or organizational security standards. 

An efficient security operations strategy is most beneficial when there are: 

- Multiple engineering teams working in Azure. 
- Multiple subscriptions to manage. 
- Regulatory requirements that must be enforced. 
- Standards that must be followed for all cloud resources. 
- Defined logging and auditing security process.