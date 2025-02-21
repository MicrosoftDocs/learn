This unit describes areas of security optimization to consider as you move through the [Ready methodology](/azure/cloud-adoption-framework/secure/ready/) phase of your journey.

:::image type="content" source="../media/caf-secure-ready.png" alt-text="Diagram that shows the Ready phase of the Secure methodology." lightbox="../media/caf-secure-ready.png" border="false":::

The Ready phase of cloud adoption focuses on building your estate's foundation. A landing zone approach offers a secure, scalable design for large organizations. Smaller organizations might not need landing zones but can still benefit from understanding this approach to create a secure and scalable foundation.

## Modernize your security posture

To modernize your security posture, start by building your landing zone or cloud foundation and modernizing your identity, authorization, and access platform.

**Adopt a landing zone approach** to provide controlled environments for deploying cloud resources. Use the landing zone design principles to optimize your implementation. To enhance security and manageability, separate different domains of your cloud estate. Even if you don't adopt a full enterprise landing zone, understand and apply relevant design areas and controls. For example, you might use management groups to govern your cloud estate.

**Adopt modern identity, authorization, and access** based on Zero Trust principles. Allow access only as needed. Apply the same strict controls to foundational elements like subscriptions, networking resources, governance solutions, and the identiy and access management (IAM) platform.

## Azure facilitation

**Use Azure landing zone accelerators.** Microsoft offers prepackaged deployments for various workloads, such as Azure Integration Services, Azure Kubernetes Service (AKS), and Azure API Management. These accelerators help you quickly set up landing zones. For a full list, see the Modern application platform scenario section in the Cloud Adoption Framework for Azure documentation.

**Use the Azure landing zones Terraform module** to automate your landing zone deployments. To help ensure consistent and secure landing zones, deploying through your continuous integration and continuous deployment (CI/CD) pipeline.

**Use Microsoft Entra** to verify identities, validate access conditions, check permissions, encrypt connections, and monitor for compromise. Microsoft Entra includes identity and network access products that help you incorporate a Zero Trust security strategy.

## Prepare for incident preparedness and response

After you define your strategy and plan for incident preparedness and response, you can begin implementation. Network segregation is crucial for security, whether you use a full enterprise landing zone or a smaller design.

To reduce attack surfaces and contain breaches, design your network with segmentation and isolation. To control traffic, use virtual private clouds (VPCs), subnets, and security groups.

Use Azure Virtual WAN to consolidate networking, security, and routing functions into a single interface. Its hub-and-spoke architecture supports branches, users, Azure ExpressRoute circuits, and virtual networks. Use Azure Virtual WAN to optimize your landing zones with segmentation and security mechanisms.

## Prepare for confidentiality

During the Ready phase, implement and enforce your IAM policies and standards to secure data by default when you deploy workloads. Key policies and standards include:

- **The principle of least privilege:** Grant users minimal access needed for their tasks.

- **Role-based access control (RBAC):** Assign roles based on job responsibilities to manage access and reduce unauthorized access risks.
- **Multifactor authentication (MFA):** Add an extra layer of security.
- **Conditional access controls:** Enforce policies based on specific conditions, such as geography or MFA requirements. Ensure that your IAM platform supports these controls.

Microsoft Entra Conditional Access is the Microsoft Zero Trust policy engine. It takes signals from various sources into account when enforcing policy decisions.

## Prepare for integrity

Ensure that you have well-governed policies and standards for your data and system integrity. Define standards for the following areas.

- **Data management**
  - *Data classification:* Create a framework and sensitivity-label taxonomy to define data security risk categories. Use this taxonomy to simplify data inventory, policy management, and investigation prioritization.

  - *Data verification and validation*: Automate these processes to reduce the burden on data engineers and minimize human error.

  - *Backup policies:* Establish and regularly test backup policies to ensure data is backed up, correct, and consistent. Align with your recovery target objective (RTO) and recovery point objective (RPO) targets.

  - *Strong encryption:* Ensure that your cloud provider encrypts data at rest and data in transit by default. Verify that services in your workloads support and are configured for strong encryption.

- **System integrity design patterns**
  - *Security monitoring:* Design a robust security monitoring platform to detect unauthorized changes.

  - *SIEM and threat detection:* Use security information and event management (SIEM), security orchestration, automation, and response (SOAR), and threat detection tools to identify suspicious activities and potential threats.

  - *Automated configuration management:* Automate configuration management to ensure consistency and eliminate human error.

  - *Automated patch management:* Automate patch management for virtual machines to ensure regular updates and consistent system versions.

  - *Automated infrastructure deployments:* Use infrastructure as code (IaC) for all deployments. Integrate IaC into your CI/CD pipelines, and apply safe deployment practices.