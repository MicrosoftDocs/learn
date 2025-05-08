| :::image type="icon" source="../media/goal.svg"::: Make security a part of your design and operations with minimal hassle.  |
| :----------------------------------------------------------------------------------------------------------------------------- |

As a workload owner, you share the responsibility to protect assets with your organization. You should create a security readiness plan that aligns with business priorities and leads to clear processes, proper investments, and defined responsibilities. The plan should include workload requirements and factor into your strategy for reliability, health modeling, and self-preservation.

You need to protect the organizational assets and the workload itself from attacks by using Zero Trust principles and the CIA Triad.

Don't let functional and nonfunctional requirements, budget constraints, and other considerations restrict security investments. Engineer and plan security investments with those constraints and restrictions in mind.

**Example scenario**

Contoso Supermarket wants to create a customer loyalty program by using Near Field Communication (NFC) on customer phones for self-checkout and cashier-assisted checkout. Customers can self-enroll at kiosks in the store. The back-end processing solution will be cloud-hosted, but the design isn't finalized yet. 

## Optimize security through segmentation

**Use segmentation to plan security boundaries in the workload environment, processes, and team structure to isolate access and function.**

**Base your segmentation strategy on business needs, like the importance of components, division of labor, privacy concerns, and other factors.**

To reduce operational friction, define roles and responsibility clearly. This exercise helps you identify the level of access for each role, especially for important accounts.

Isolation limits exposure of sensitive flows to only roles and assets that need access. Too much exposure can lead to information leaks.

*Contoso's challenge*

- In the spirit of simplicity, the team has historically favored low overhead approaches. These approaches have included grouping components and organizing individuals into security groups to simplify access management.

- A QA intern had broad access because of their security group membership. Unfortunately, their account was compromised in a social engineering attack.
- This attack compromised the confidentiality of that deployment and all other deployments on the same application platform.

*Applying the approach and outcomes*

- Luckily, the compromised environment was just an early test prototype for the new customer loyalty program, so no production systems were affected.

- The security team plans to invest time and money to isolate components that handle personal data, like addresses and emails, from components that don't, like coupons. They'll design access controls that are need-to-know and just-in-time (JIT) where possible, and isolate networks within the workload and back into Contoso to protect the organization.

- Segmentation helps contain the impact of a compromise. 

## Respond to incidents efficiently

**Make sure there's an incident response plan for your workload. Use industry frameworks that define the standard operating procedure for preparedness, detection, containment, mitigation, and post-incident activity.**

During a crisis, avoid confusion by having a clear security incident response plan. Responsible roles can focus on execution without wasting time on uncertain actions. A comprehensive plan helps you meet remediation requirements.

*Contoso's challenge*

- The workload team is setting up retailer support channels, customer support channels, and technical on-call rotations for support escalations and outages.

- They haven't addressed security specifically and don't know what Contoso offers for support.

*Applying the approach and outcomes*

- The workload team works with the Contoso security team to understand compliance requirements for handling personal data from both an organization perspective and external compliance perspective.

- The team builds a security detection, mitigation, and escalation plan, including communication for incidents.
- The team now feels just as comfortable with security incident preparedness as they do with their reliability support. They plan to practice handling incidents before they go live.

## Codify secure operations and development practices

**Set clear team-level security standards for your workload's life cycle and operations, including how to write code, approve changes, release updates, and handle data.**

Having robust security habits helps avoid mistakes and keeps things running smoothly. When everyone follows the same approach, it's easier to stay on track and work efficiently.

Over time, sticking to these standards helps you spot ways to improve and maybe even automate steps to save time and boost consistency.

*Contoso's challenge*

- After getting ready to handle incidents, the team realized they need to invest in preventing problems before they happen.

- They don't have a specific secure development process yet. They plan to reuse processes that they used on past projects.

*Applying the approach and outcomes*

- This workload doesn't store highly sensitive data like credit card information, but the team still treats their customers' data with care. They're aware of local and federal regulations that must be followed for the types of data that they store.

- The team invests in learning about current industry-standard secure development and operations practices and starts using measures that they hadn't used before.
- The team also shares their learnings with the Contoso security team so that everyone across the company can benefit from the improvements.

