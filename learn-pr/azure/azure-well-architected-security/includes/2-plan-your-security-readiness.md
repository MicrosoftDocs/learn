| :::image type="icon" source="../media/goal.svg"::: Strive to adopt and implement security practices in architectural design decisions and operations with minimal friction. |
| :----------------------------------------------------------------------------------------------------------------------------- |

As a workload owner, you have a shared responsibility with the organization to protect assets. Create a security readiness plan that's aligned with business priorities. It will lead to well-defined processes, adequate investments, and appropriate accountabilities. The plan should provide the workload requirements to the organization, which also shares responsibility for protecting assets. Security plans should factor into your strategy for reliability, health modeling, and self-preservation.

In addition to organizational assets, the workload itself needs to be protected from intrusion and exfiltration attacks. All facets of Zero Trust and the CIA triad should be factored into the plan.

Functional and non-functional requirements, budget constraints, and other considerations shouldn't restrict security investments or dilute assurances. At the same time, you need to engineer and plan security investments with those constraints and restrictions in mind.

**Example scenario**

Contoso Supermarket has never had a customer loyalty program before, but have decided it makes business sense to build one. NFC functionality on customer phones will be used as the solution at point-of-sale for both self-checkout and cashier-assisted checkout. A self-registration kiosk at the store entrance and exit will enable customers to enroll in the program. The backend processing solution will be cloud hosted, but the design isn’t finalized yet. 

## Optimize security through segmentation

**Use segmentation as a strategy to plan security boundaries in the workload environment, processes, and team structure to isolate access and function.**

**Your segmentation strategy should be driven by business requirements. You can base it on criticality of components, division of labor, privacy concerns, and other factors.**

You'll be able to minimize operational friction by defining roles and establishing clear lines of responsibility. This exercise also helps you identify the level of access for each role, especially for critical-impact accounts.

Isolation enables you to limit exposure of sensitive flows to only roles and assets that need access. Excessive exposure could inadvertently lead to information flow disclosure.

*Contoso's challenge*

- In the spirit of simplicity, the team has historically favored low overhead approaches. These approaches have included co-locating disparate workload components to reduce management surface area and organizing disparate individuals into security groups to simplify access management.
- Unfortunately, a QA intern who was granted broad access to the new deployment environment due to their security group membership was subject to a social engineering attack that led to a compromise of their account.
- The attacker was able to compromise the confidentiality of not just that deployment, but all of the others running on the same application platform.

*Applying the approach and outcomes*

- Luckily, the compromised environment was hosting an early test prototype of the workload; while they are designing the new customer loyalty program system for the point-of-sale system, so no production systems were breached.
- The workload security team plans on investing time and money to design the workload to isolate systems that handle personally identifiable information (PII), such as the address and email of customers, from those components that don’t (such as the coupons for products); design access controls that are need-to-know and just-in-time (JIT) where possible; and isolate networks both within the workload to protect other components and back into Contoso to protect the organization.
- Through segmentation, a compromise may still have an impact to aspects of the workload, but the blast radius will be contained. 

## Respond to incidents efficiently

**Make sure there's an incident response plan for your workload. Use industry frameworks that define the standard operating procedure for preparedness, detection, containment, mitigation, and post-incident activity.**

At the time of crisis, confusion must be avoided. If you have a well-documented plan, responsible roles can focus on execution without wasting time on uncertain actions. Also, a comprehensive plan can help you ensure that all remediation requirements are fulfilled.

*Contoso's challenge*

- The workload team is starting to formalize retailer support channels, customer support channels, and technical on-call rotations for support escalations and for outages.
- They haven’t addressed security specifically in these plans. They also don’t know what Contoso, as an organization offers for support.

*Applying the approach and outcomes*

- The workload team works with the Contoso security team to understand compliance requirements for dealing with PII of this nature, both from an organization perspective and from external compliance perspective.
- The team builds a security detection, mitigation, and escalation plan, including standardized communication requirements for incidents.
- The workload team now feels just as comfortable with security incident preparedness as they do with their reliability support. They plan on drilling on security incidents to dry run and refine the plan before they go live with the system.

## Codify secure operations and development practices

**Define and enforce team-level security standards across the lifecycle and operations of the workload. Strive for consistent practices in operations like coding, gated approvals, release management, and data protection and retention.**

Defining good security practices can minimize negligence and the surface area for potential errors. The team will optimize efforts and the outcome will be predictable because approaches are made more consistent.

Observing security standards over time will enable you to identify opportunities for improvement, possibly including automation, which will streamline efforts further and increase consistency.

*Contoso's challenge*

- After preparing for incident response, the workload team decides they need to invest time and effort to prevent issues in the first place.
- They currently don’t have any specific secure development lifecycle in mind, and plan on using the same processes they used on prior projects.

*Applying the approach and outcomes*

- While this workload won't hold highly confidential data like credit card information, the team treats their customers' data with respect and are aware that there are local and federal regulations that must be followed for the types of data that will be held.
- The team invests in learning about current industry-standard secure development and operations practices and adopts measures that they had previously lacked.
- The team also shares their learnings with the Contoso security team to ensure that best practices are being adopted across the enterprise.
