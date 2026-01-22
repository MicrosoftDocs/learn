An organization can never have perfect security, but it can become resilient to security attacks. Like we're never perfectly immune to all health and safety risks in the physical world, the data, and information systems we operate are also never 100 percent safe from all attacks, all the time.

Focus your security efforts on increasing the resilience of business operations in the face of security incidents. These efforts can reduce risk and enable continuous improvements in security posture and your ability to respond to incidents.

Resilience requires taking a pragmatic view that assumes a breach. It needs continuous investment across the full lifecycle of security risk.

![Diagram that shows the security resilience Cycle.](/azure/cloud-adoption-framework/secure/media/security-resilience-cycle.png)

-   **Before an incident:** Continuously improve security posture and the organization's ability to respond to an incident. Continuously improving security posture helps limit the likelihood and potential impact of a security incident on your business operations and assets. There are many techniques covered throughout the security disciplines, but all of them are designed to raise the cost of attack. Make the attackers develop and try new techniques because you've made their old ones stop working. These techniques raise their costs and friction, slowing them down and limiting their success.
-   **During an incident:** Business operations must continue during an incident, even if they're degraded, slower, or limited to only critical systems. During an attack, a hospital can't stop caring for patients, ships need to move cargo, and planes must continue to fly safely. The two main priorities during an incident are:
    -   **Protect critical operations:** If threatened, all efforts should focus on protecting and sustaining critical business operations over all other functions.
    -   **Prevent further damage:** The default priority for security operations is to discover the full extent of attacker access, and then rapidly evict them from the environment. This eviction prevents further damage by the attackers, including retaliation.
-   **After an incident:** If business operations are damaged during an attack, repairs must start immediately to restore full business operations. These repairs apply even if that means restoring operations without data that was lost in an attack, for example ransomware or a destructive attack like NotPetya.
-   **Feedback loop:** Attackers repeat themselves, or repeat what other attackers have found to work. Attackers learn from attacking your organization, so you must continuously learn from their attacks. Focus on taking the proven and available techniques that were attempted before. Then ensure you can block, detect, rapidly respond, and recover from them. Your efforts raise the cost of attack on your organization and deter or slow down future attacks.

## Resilience goals

Security resiliency is focused on supporting the resiliency of your business.

-   **Enable your business** to rapidly innovate and adapt to the ever changing business environment. Security should always be seeking safe ways to say _yes_ to business innovation and technology adoption. Your organization can then adapt to unexpected changes in the business environment, like the sudden shift to working from home during COVID-19.
-   **Limit the impact** and likelihood of disruptions before, during, and after active attacks to business operations.
## Identifying and prioritizing threats to business-critical assets

Effective business resiliency requires identifying which assets are most critical to business operations and understanding the threats that could disrupt them. This risk-based approach ensures security investments align with business priorities.

Key steps include:

1. **Identify business-critical assets**: Work with business stakeholders to determine which systems, data, and processes are essential for maintaining operations. Consider both customer-facing services and internal capabilities. In modern organizations, this increasingly includes:
   - AI and machine learning systems that support business decisions
   - AI-powered customer service and support systems
   - Predictive analytics platforms
   - Automated business process systems

2. **Assess threats and vulnerabilities**: For each critical asset, identify the most likely and impactful threats:
   - Ransomware and extortion attacks
   - Distributed denial-of-service (DDoS) attacks
   - Data breaches and exfiltration
   - Insider threats
   - Supply chain compromises
   - AI-specific threats (model poisoning, prompt injection, training data exfiltration)
   - Natural disasters and infrastructure failures

3. **Prioritize based on business impact**: Evaluate threats based on:
   - Likelihood of occurrence
   - Potential business impact (financial, operational, reputational, regulatory)
   - Time to recover
   - Complexity of mitigation

4. **Map controls to threats**: For each prioritized threat, identify specific security controls and recovery capabilities:
   - Preventive controls to reduce likelihood
   - Detective controls for early warning
   - Response procedures to contain damage
   - Recovery capabilities to restore operations

5. **Establish recovery objectives**: Define specific Recovery Time Objectives (RTO) and Recovery Point Objectives (RPO) for each critical asset based on business requirements, not technical convenience.

This threat-informed, business-aligned approach ensures security strategies directly support business resiliency goals rather than implementing generic security measures.
## Security resilience and assume breach

Good security starts with assuming breach or assuming compromise. Understand that information technology (IT) systems operate over the open internet where criminals are constantly attacking and compromising organizations. This assumption is a key principle of Zero Trust, which drives healthy and pragmatic security behaviors. Zero Trust prepares your organization to prevent attacks, limit their damage, and quickly recover from them.

Assuming compromise should drive changes across people, process, and technology in your organization. Education, exercises, and other incident preparation activities are good examples. For more information, see [Incident preparation](/azure/cloud-adoption-framework/organize/cloud-security-incident-preparation).

Assuming compromise is a significant shift from the classic security mindset. That mindset assumed organizations could establish a perfectly safe network protected by a security perimeter, restricting all valuable business activity to that network. Elements of this strategy provide value in a resilient enterprise. But the assumption of a perfectly safe network didn't in the world of mobile work and evolving business models, technology platforms, and security threats.

Resiliency requires a close partnership between business stakeholders, IT professionals and leaders, and security professionals.
