This unit describes areas of security optimization to consider as you move through the [Ready methodology](/azure/cloud-adoption-framework/secure/ready/) phase of your journey.

:::image type="content" source="../media/caf-secure-ready.png" alt-text="Diagram that shows the Ready phase of the Secure methodology." lightbox="../media/caf-secure-ready.png" border="false":::

The Ready phase of cloud adoption focuses on building your estate's foundation. A landing zone approach provides a secure, scalable design for large organizations. Smaller organizations might not need landing zones but can still benefit from understanding this approach to create a secure and scalable foundation.

## Modernize your security posture

To [modernize your security posture](/azure/cloud-adoption-framework/secure/ready#security-posture-modernization), first build your landing zone or cloud foundation and modernize your identity, authorization, and access platform.

- **Adopt a landing zone approach** to provide controlled environments to deploy cloud resources. Use the [landing zone design principles](/azure/cloud-adoption-framework/ready/landing-zone/design-areas) to optimize your implementation. To enhance security and manageability, separate different domains of your cloud estate. Even if you don't adopt a full enterprise landing zone, understand and apply relevant design areas and controls. For example, you might use management groups to govern your cloud estate.

- **Adopt modern identity, authorization, and access** based on Zero Trust principles. Allow access only as needed. Apply the same strict controls to foundational elements like subscriptions, networking resources, governance solutions, and the identity and access management (IAM) platform.

### Azure facilitation

- Azure landing zone accelerators are prepackaged deployments for various workloads, such as [Azure Integration Services](/azure/cloud-adoption-framework/scenarios/app-platform/integration-services/landing-zone-accelerator), [Azure Kubernetes Service (AKS)](/azure/cloud-adoption-framework/scenarios/app-platform/aks/landing-zone-accelerator), and [Azure API Management](/azure/cloud-adoption-framework/scenarios/app-platform/api-management/landing-zone-accelerator). These accelerators help you quickly set up landing zones. For a full list, see [Modern application platform scenario](/azure/cloud-adoption-framework/scenarios/app-platform/).

- [The Azure landing zones Terraform module](https://registry.terraform.io/modules/Azure/caf-enterprise-scale/azurerm/latest) automates your landing zone deployments. To help ensure consistent and secure landing zones, deploy landing zones through your continuous integration and continuous deployment (CI/CD) pipeline.

- [Microsoft Entra](/entra/fundamentals/what-is-entra) verifies identities, validates access conditions, checks permissions, encrypts connections, and monitors for compromise. Microsoft Entra includes identity and network access products that help you incorporate a Zero Trust security strategy.

## Prepare for incidents and response

After you define your strategy and plan for incident preparedness and response, you can [begin implementation](/azure/cloud-adoption-framework/secure/ready#prepare-for-incident-preparedness-and-response). Network segregation is crucial for security, whether you use a full enterprise landing zone or a simpler design.

- **Design your network with segmentation and isolation** to reduce attack surfaces and contain breaches.

- **Use virtual private clouds (VPCs), subnets, and security groups** to control traffic.

### Azure facilitation

[Azure Virtual WAN](/azure/virtual-wan/virtual-wan-about) consolidates networking, security, and routing functions into a single interface. Its hub-and-spoke architecture supports branches, users, Azure ExpressRoute circuits, and virtual networks. Virtual WAN helps optimize your landing zones via segmentation and security mechanisms.

## Prepare for confidentiality

To [help secure data by default](/azure/cloud-adoption-framework/secure/ready#prepare-for-confidentiality) when you deploy workloads, implement and enforce your IAM policies and standards. Key policies and standards include:

- **The principle of least privilege:** Grant users minimal access needed for their tasks.

- **Role-based access control (RBAC):** Assign roles based on job responsibilities to manage access and reduce unauthorized access risks.
- **Multifactor authentication (MFA):** Add an extra layer of security.
- **Conditional access controls:** Enforce policies based on specific conditions, such as geography or MFA requirements. Ensure that your IAM platform supports these controls.

### Azure facilitation

[Microsoft Entra Conditional Access](/entra/identity/conditional-access/overview) is the Microsoft Zero Trust policy engine. It evaluates signals from various sources to make informed policy decisions.

## Prepare for integrity

Ensure that you have [well-governed policies and standards](/azure/cloud-adoption-framework/secure/ready#prepare-for-integrity) for your data and system integrity. Define standards for the following areas.

- **Data management:**
  - Create a framework and sensitivity-label taxonomy to define data security risk categories. Use this taxonomy to simplify data inventory, policy management, and investigation prioritization.

  - Automate data verification and validation processes to reduce the burden on data engineers and minimize human error.

  - Establish and regularly test backup policies to help ensure that data is backed up, correct, and consistent. Align with your recovery target objective (RTO) and recovery point objective (RPO) targets.

  - Ensure that your cloud provider encrypts data at rest and data in transit by default. Verify that services in your workloads support and are configured for strong encryption.

- **System integrity design patterns:**
  - Design a robust security monitoring platform to detect unauthorized changes.

  - Use security information and event management (SIEM), security orchestration, automation, and response (SOAR), and threat detection tools to identify suspicious activities and potential threats.

  - Automate configuration management to help ensure consistency and reduce human error.

  - Automate patch management for virtual machines to help ensure regular updates and consistent system versions.

  - Use infrastructure as code (IaC) for all deployments. Integrate IaC into your CI/CD pipelines, and apply safe deployment practices.

### Azure facilitation

- [Azure Policy](/azure/governance/policy/overview) and [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) help define and enforce security policies across your cloud estate. They support the governance of foundational elements and workload resources.

- [Azure Update Manager](/azure/update-manager/overview) is a native Azure solution that manages updates and patches. It's extendable to on-premises and Azure Arc-enabled systems.

- [Microsoft Sentinel](/azure/sentinel/overview) is a SIEM and SOAR solution that provides cyberthreat detection, investigation, response, proactive hunting, and a comprehensive enterprise view.

## Prepare for availability

Design resilient workloads to [help ensure business continuity during malfunctions and security incidents](/azure/cloud-adoption-framework/secure/ready#prepare-for-availability). Consider the following key recommendations:

- **Use patterns that enhance resilience and incorporate self-healing mechanisms** to help ensure continuous operation and rapid recovery.

- **Use platform as a service (PaaS), software as a service (SaaS), and function as a service (FaaS) technologies** to reduce server management, scale automatically, and improve availability.
- **Break down applications** into smaller, independent services for better scalability and agility.
- **Isolate services** to minimize the impact of failures.
- **Ensure that your architecture supports varying loads** to maintain availability during traffic spikes.
- **Design your application to isolate failures to individual tasks or functions.** This approach prevents widespread outages.
- **Include redundancy and disaster recovery mechanisms.**
- **Deploy applications across multiple regions** for seamless failover and uninterrupted service.

## Prepare for security sustainment

Ensure that your estate's foundational elements follow security best practices and are scalable. This approach helps prevent security problems and complex management as your estate grows. Plan for long-term business goals without major redesigns or operational overhauls. If you have a simpler foundation, ensure that it can transition to an enterprise architecture without redeploying major elements. A scalable, secure design is key to cloud success.
