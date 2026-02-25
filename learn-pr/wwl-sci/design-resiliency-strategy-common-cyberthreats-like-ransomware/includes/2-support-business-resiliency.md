An organization can never have perfect security, but it can become resilient to security attacks. Like we're never perfectly immune to all health and safety risks in the physical world, the data and information systems we operate are also never 100 percent safe from all attacks, all the time.

Focus your security efforts on increasing the resilience of business operations in the face of security incidents. These efforts can reduce risk and enable continuous improvements in security posture and your ability to respond to incidents.

Resilience requires taking a pragmatic view that assumes a breach. It needs continuous investment across the full lifecycle of security risk.

:::image type="content" source="../media/security-resilience-cycle.png" alt-text="Diagram that shows the security resilience Cycle." lightbox="../media/security-resilience-cycle.png":::

- **Before an incident:** Continuously improve security posture and the organization's ability to respond to an incident. Continuously improving security posture helps limit the likelihood and potential impact of a security incident on your business operations and assets. Make the attackers develop and try new techniques because you've made their old ones stop working. These techniques raise their costs and friction, slowing them down and limiting their success.
- **During an incident:** Business operations must continue during an incident, even if they're degraded, slower, or limited to only critical systems. During an attack, a hospital can't stop caring for patients, ships need to move cargo, and planes must continue to fly safely. The two main priorities during an incident are:
    - **Protect critical operations:** If threatened, all efforts should focus on protecting and sustaining critical business operations over all other functions.
    - **Prevent further damage:** The default priority for security operations is to discover the full extent of attacker access, and then rapidly evict them from the environment. This eviction prevents further damage by the attackers, including retaliation.
- **After an incident:** If business operations are damaged during an attack, repairs must start immediately to restore full business operations. These repairs apply even if that means restoring operations without data that was lost in an attack, for example ransomware or a destructive attack like NotPetya.
- **Feedback loop:** Attackers repeat themselves, or repeat what other attackers have found to work. Attackers learn from attacking your organization, so you must continuously learn from their attacks. Focus on taking the proven and available techniques that were attempted before. Then ensure you can block, detect, rapidly respond, and recover from them. Your efforts raise the cost of attack on your organization and deter or slow down future attacks.

## Resilience goals

Security resiliency is focused on supporting the resiliency of your business.

- **Enable your business** to rapidly innovate and adapt to the ever changing business environment. Security should always be seeking safe ways to say *yes* to business innovation and technology adoption. Your organization can then adapt to unexpected changes in the business environment, like the sudden shift to working from home during COVID-19.
- **Limit the impact** and likelihood of disruptions before, during, and after active attacks to business operations.

## Identifying and prioritizing threats to business-critical assets

Effective business resiliency requires identifying which assets are most critical to business operations and understanding the threats that could disrupt them. This risk-based approach ensures security investments align with business priorities.

### Identify business-critical assets

Work with business stakeholders to determine which systems, data, and processes are essential for maintaining operations. Microsoft documentation identifies five priority categories:

- **Identity systems**: Required for users to access all other systems, including Active Directory, Microsoft Entra Connect, and domain controllers.
- **Human life systems**: Any system that supports human life or could put it at risk, such as medical systems, safety systems, large machinery controls, and chemical or biological systems.
- **Financial systems**: Systems that process monetary transactions and keep the business operating, such as payment systems and financial reporting databases.
- **Product or service enablement**: Systems required to provide business services or produce products, including factory control systems, delivery infrastructure, and dispatch systems.
- **Security systems (minimum)**: Security systems needed to monitor for attacks and provide minimum security services. This should focus on ensuring current attacks can't immediately regain access to restored systems.

In modern organizations, this identification must also account for AI and machine learning systems that support business decisions, AI-powered customer service platforms, predictive analytics that drive revenue, and automated business process systems.

### Classify asset criticality

Microsoft Security Exposure Management provides asset criticality classification to support prioritization:

- **Very High**: Core business assets whose compromise would cause major organizational damage.
- **High**: Assets that threat actors could use to gain access to Very High criticality assets.
- **Medium**: Assets with limited risk exposure or lesser importance to business continuity.
- **Low**: Assets with minimal business impact or security exposure.

This classification helps security teams focus protective measures and incident response efforts where they matter most.

### Assess and prioritize threats

For each critical asset, identify the most likely and impactful threats:

- Ransomware and extortion attacks
- Distributed denial-of-service (DDoS) attacks
- Data breaches and exfiltration
- Insider threats
- Supply chain compromises
- AI-specific threats (model poisoning, prompt injection, training data exfiltration)
- Natural disasters and infrastructure failures

Evaluate threats based on likelihood of occurrence, potential business impact (financial, operational, reputational, regulatory), time to recover, and complexity of mitigation.

### Map controls and establish recovery objectives

For each prioritized threat, identify specific security controls and recovery capabilities:

- **Preventive controls** to reduce likelihood
- **Detective controls** for early warning
- **Response procedures** to contain damage
- **Recovery capabilities** to restore operations

Define specific Recovery Time Objectives (RTO) and Recovery Point Objectives (RPO) for each critical asset based on business requirements, not technical convenience. RTO defines how quickly systems must be restored, while RPO defines the acceptable amount of data loss measured in time.

## Security resilience and assume breach

Good security starts with assuming breach or assuming compromise. Understand that information technology (IT) systems operate over the open internet where criminals are constantly attacking and compromising organizations. This assumption is a key principle of Zero Trust, which drives healthy and pragmatic security behaviors. Zero Trust prepares your organization to prevent attacks, limit their damage, and quickly recover from them.

Assuming compromise should drive changes across people, process, and technology in your organization. Education, exercises, and other incident preparation activities are good examples. For more information, see [Incident preparation](/azure/cloud-adoption-framework/organize/cloud-security-incident-preparation).

Assuming compromise is a significant shift from the classic security mindset. That mindset assumed organizations could establish a perfectly safe network protected by a security perimeter, restricting all valuable business activity to that network. Elements of this strategy provide value in a resilient enterprise. But the assumption of a perfectly safe network didn't hold in the world of mobile work and evolving business models, technology platforms, and security threats.

### AI considerations for business resiliency

As organizations increasingly depend on AI systems for business operations, resiliency planning must account for AI-specific considerations:

- **AI system dependencies**: Map dependencies between AI systems and business processes. When AI services become unavailable, determine which business operations are affected and define fallback procedures.
- **Model integrity validation**: After any security incident, validate that AI models haven't been tampered with or poisoned. Establish baseline model behavior metrics and automated integrity checks.
- **Data pipeline resilience**: AI systems depend on data pipelines that may span multiple services and regions. Ensure data pipeline resilience with appropriate redundancy and failover capabilities.
- **AI governance continuity**: Maintain AI governance, monitoring, and safety controls during incident response and recovery operations. Degraded AI governance during an incident can introduce more risk.
- **Vendor and supply chain considerations**: Many organizations use third-party AI models and services. Evaluate vendor resiliency commitments and develop contingency plans for vendor service disruptions.

Resiliency requires a close partnership between business stakeholders, IT professionals and leaders, and security professionals.
