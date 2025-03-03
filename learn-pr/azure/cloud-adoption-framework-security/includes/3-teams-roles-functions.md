This unit describes the [security roles required for cloud security](/azure/cloud-adoption-framework/secure/teams-roles). It also describes the functions that they perform related to cloud infrastructure and platforms. These roles help integrate security into every stage of the cloud lifecycle, from development to continuous improvement. Depending on your organization's size, individuals that perform multiple functions or specialized teams might fulfill these roles.

:::image type="content" source="../media/caf-secure-teams-roles.svg" alt-text="Diagram that shows the teams and roles phase of the Secure methodology." lightbox="../media/caf-secure-teams-roles.svg" border="false":::

## Transformation of security roles

[Security roles are evolving](/azure/cloud-adoption-framework/secure/teams-roles#transformation-of-security-roles) because of several factors:

- **SaaS-based security tools:** There's less need to design, implement, test, and operate security tool infrastructure because software as a service (SaaS) tools simplify the process.

- **Collaborative approach:** There's a growing recognition that security is everyone's job, which requires collaboration between security and technical teams. Security teams are shifting from a quality control role to a role that enables technical teams to implement their own security measures.
- **More skills:** Security teams are increasingly broadening their skills so that they can identify security problems across multiple technologies and systems.
- **The speed of innovation:** The increased rate of change for technology and security cloud services requires that security processes are continuously updated to align with changes and manage risk effectively.
- **Zero Trust approach:** Security threats now reliably bypass network-based security controls, so security teams need to adopt a Zero Trust approach that includes extra controls.
- **DevOps and DevSecOps:** DevOps and DevSecOps processes require more agile security roles that can integrate security seamlessly into the faster development life cycle.

## Overview of roles and teams

This section describes which [teams and roles](/azure/cloud-adoption-framework/secure/teams-roles#overview-of-roles-and-teams) typically perform key cloud security functions. Your organization might not need all of these functions.

To determine your needs, map out your existing approach, look for gaps, and assess whether your organization can or should invest to address those gaps. To ensure that everyone understands their security role and collaboration method, document cross-team processes and a shared responsibility model. 

- **[Cloud service providers](/azure/cloud-adoption-framework/secure/teams-roles#cloud-service-provider)** equip you with security functions and capabilities for the underlying cloud platform. They also provide security features that your teams can use to manage your security posture and incidents.

- **[Infrastructure or platform teams](/azure/cloud-adoption-framework/secure/teams-roles#infrastructureplatform-teams-architecture-engineering-and-operations)** include architecture, engineering, and operations teams. They implement and integrate security, privacy, and compliance controls across cloud environments. These teams help ensure availability, scalability, security, and privacy for cloud services. They work collaboratively with security, risk, compliance, and privacy experts to meet organizational requirements.

- **[Security architecture, engineering, and posture management teams](/azure/cloud-adoption-framework/secure/teams-roles#security-architecture-engineering-and-posture-management-teams)** collaborate with infrastructure and platform roles to translate security strategy, policy, and standards into actionable solutions. These teams help cloud teams succeed because they evaluate and influence the security of infrastructure and management processes and tools.

  - *Security architects and engineers* work with infrastructure teams to design and implement security controls. They adapt existing security policies, standards, and guidelines to fit cloud environments. They also collaborate with several other roles to establish foundational network security capabilities.

  - *Software security engineers* evaluate code and scripts that are used to manage the infrastructure. They help protect formal code and configurations from manipulation through threat model analysis, code review, and security scanning tools.

  - *Posture management teams* focus on security enablement for technical operations teams to help prioritize and implement controls to block or mitigate attacks. Key tasks include monitoring and assessing the security posture, identifying risks, training, and reporting on incidents.

- **[Security operations teams](/azure/cloud-adoption-framework/secure/teams-roles#security-operations-secopssoc)** handle incident response, threat hunting, and detection engineering. They focus on continuous monitoring and management of security incidents.

- **[Security governance, risk, and compliance (GRC) teams](/azure/cloud-adoption-framework/secure/teams-roles#security-governance-risk-and-compliance)** manage security policies, risk assessments, and compliance requirements. They ensure that security practices align with regulatory standards and organizational policies. GRC disciplines operate across all technologies and systems. They rely on high-fidelity data and context from other teams.

- **[Security training and awareness teams](/azure/cloud-adoption-framework/secure/teams-roles#security-education-and-policy)** provide training and resources to ensure that all stakeholders understand their security responsibilities and how to work with other teams.

Properly assign roles to help ensure that you deploy your workload correctly and that you continuously monitor, manage, and improve it. This practice helps protect your workload from evolving threats.