This unit describes areas of security optimization to consider as you move through the [Plan methodology](/azure/cloud-adoption-framework/secure/plan/) phase of your journey.

:::image type="content" source="../media/caf-secure-plan.svg" alt-text="Diagram that shows the Plan phase of the Secure methodology." lightbox="../media/caf-secure-plan.svg" border="false":::

A cloud adoption plan often has many technical challenges. You must carefully plan each step of your cloud adoption process, specifically when you update legacy workloads for cloud infrastructure. Prioritize security over performance and cost efficiency when you start your designs. This approach helps ensure that you don't introduce risks that could require you to redesign workloads later.

## Plan for landing zone adoption

To build your cloud estate foundation, use the [landing zone approach](/azure/cloud-adoption-framework/secure/plan#plan-for-landing-zone-adoption), especially for enterprise and large organizations. Smaller organizations might not need a landing zone initially but should understand the [landing zone design areas](/azure/cloud-adoption-framework/ready/landing-zone/design-areas) for their cloud adoption plan.

Landing zones are preconfigured, highly secure, scalable cloud environments that include network topology, identity management, security, and governance components. They help you standardize your cloud environment, ensure consistency and compliance with security policies, and facilitate easier management and scalability.

## Modernize your security posture

When you develop a [security modernization plan](/azure/cloud-adoption-framework/secure/plan#security-posture-modernization), focus on adopting new technologies and operational practices while aligning security measures with business objectives.

### Plan for Zero Trust adoption

Incorporate Zero Trust principles to structure phases and steps for teams. The Microsoft Zero Trust approach covers seven [technology pillars](/azure/cloud-adoption-framework/secure/plan#zero-trust-technology-pillars):

- [Identity](/security/zero-trust/deploy/identity): Guidance for verifying identities with strong authentication and controlling access under the principle of least privilege.

- [Endpoints](/security/zero-trust/deploy/endpoints): Guidance for securing endpoints, including devices and apps, that interact with your data. You can apply this guidance regardless of where the endpoints connect from and how they connect.

- [Data](/security/zero-trust/deploy/data): Guidance for securing data by using a defense-in-depth approach.

- [Apps](/security/zero-trust/deploy/applications): Guidance for securing the cloud apps and services that you consume.

- [Infrastructure](/security/zero-trust/deploy/infrastructure): Guidance for securing cloud infrastructure through strict policies and enforcement strategies.

- [Networks](/security/zero-trust/deploy/networks): Guidance for securing your cloud network through segmentation, traffic inspection, and end-to-end encryption.

- [Visibility, automation, and orchestration](/security/zero-trust/deploy/visibility-automation-orchestration): Guidance for operational policies and practices that help enforce Zero Trust principles.

### Consider business alignment

Ensure [alignment between technology and business stakeholders](/azure/cloud-adoption-framework/secure/plan#business-alignment). Approach plan development collaboratively, and negotiate with stakeholders to fine the best way to adapt processes and policies. Business stakeholders must understand how the modernization plan affects business functions. Technology stakeholders should know where to make concessions to maintain security.

## Plan for incident preparedness and response

- **Evaluate vulnerability management solutions, threat detection systems, and infrastructure monitoring.**

- **Plan for infrastructure hardening** to reduce attack surfaces.
- **Build a robust incident response plan.**
- **Identify roles and key phases**, such as investigation, mitigation, and communications.
- **Add details about roles and phases** as you develop your cloud estate.

## Plan for confidentiality

- **Plan data loss prevention policies and procedures meticulously** to help ensure organizational data confidentiality.

- **Identify and classify data** based on sensitivity and regulatory requirements to apply appropriate security measures.
- **Encrypt data at rest and data in transit** by using strong encryption standards.
- **Implement strict access controls**, including multifactor authentication and role-based access control. Follow the Zero Trust principle by verifying explicitly based on user identity, location, device health, service or workload, data classification, and anomalies.

## Plan for integrity

- **Plan to monitor data and systems** for unauthorized changes and establish data hygiene policies.

- **Incorporate integrity considerations** in your incident response plan to address and remediate unauthorized changes or corrupted data.

## Plan for availability

- **Standardize infrastructure and application design patterns.** To help ensure workload reliability, standardize design patterns, avoid unnecessary complexity, and follow [best practices for high availability](/azure/well-architected/reliability/redundancy) and [resilience](/azure/well-architected/reliability/self-preservation).

- **Standardize development tools and practices.** To help ensure that deployments adhere to the CIA Triad principles and best practices for safe deployments, develop enforceable [standards for development tools and practices](/azure/well-architected/operational-excellence/formalize-development-practices).
- **Standardize operational tools and practices.** To maintain confidentiality, integrity, and availability, enforce standards for operators. Consistently follow and train on these standards to help ensure system resilience and efficient incident response.

## Plan for security sustainment

- **Adopt a mindset of continuous improvement**, and seek enhancement opportunities. To foster your mindset, implement a training program.

- **Adhere to operational standards**, and regularly review policies.
- **Understand your current posture** to plan your security baseline. Use tools like Microsoft Secure Score to quickly establish your baseline and identify areas for improvement.