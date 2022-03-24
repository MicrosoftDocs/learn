Security is a team sport. It is critical that individuals on the security team see each other as part of a whole security team, part of the whole organization, and part of a larger security community defending against the same adversaries. This holistic worldview enables the team to work well in general. It is especially important as the teams work through any unplanned gaps and overlaps discovered during the evolution of roles and responsibilities.

## Security responsibilities (functions)

This diagram depicts the specific organizational functions within security. It represents an ideal view of a complete enterprise security team and may be an aspirational view for some security teams. Each function may be performed by one or more people, and each person may perform one or more functions depending on various factors such as culture, budget, and available resources.

:::image type="content" source="../media/security-organizational-functions.png" alt-text="A diagram illustrating the organizational functions within security." border="false":::

Each of the following articles provides information about each function including a summary of objectives, how the function can evolve because of the threat environment or cloud technology changes, and the relationships and dependencies that are critical to its success.

- [Policy and standards](/azure/cloud-adoption-framework/organize/cloud-security-policy-standards)
- [Security operations](/azure/cloud-adoption-framework/organize/cloud-security-operations-center)
- [Security architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture)
- [Security compliance management](/azure/cloud-adoption-framework/organize/cloud-security-compliance-management)
- [People security](/azure/cloud-adoption-framework/organize/cloud-security-people)
- [Application security and DevSecOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)
- [Data security](/azure/cloud-adoption-framework/organize/cloud-security-data-security)
- [Infrastructure and endpoint security](/azure/cloud-adoption-framework/organize/cloud-security-infrastructure-endpoint)
- [Identity and key management](/azure/cloud-adoption-framework/organize/cloud-security-identity-keys)
- [Threat intelligence](/azure/cloud-adoption-framework/organize/cloud-security-threat-intelligence)
- [Posture management](/azure/cloud-adoption-framework/organize/cloud-security-posture-management)
- [Incident preparation](/azure/cloud-adoption-framework/organize/cloud-security-incident-preparation)

The following diagram summarizes the roles and responsibilities in a security program to help you familiarize yourself with these roles.

:::image type="content" source="../media/security-roles-responsibilities.png" alt-text="A diagram summarizing the roles and responsibilities of a security program." border="false":::

For more information, see [Cloud security functions](/azure/cloud-adoption-framework/organize/cloud-security).

## Mapping security to business outcomes

At the organizational level, the security disciplines map to standard plan-build-run phases seen widely across industries and organizations. While this cycle is accelerating into a continuous change cycle with the digital age and the advent of DevOps, this illustrates how security maps to normal business processes.

Security is both a discipline with its own unique functions and a critical element to integrate into normal business operations.

## Role types

The middle (dark blue) section groups these responsibilities into typical roles that have common skill sets and career profiles. These groupings also help provide clarity on how industry trends are affecting security professionals:

- **Security leadership**: These roles frequently span across functions, ensuring that teams coordinate with each other, providing prioritization and setting cultural norms, policies, and standards for security.
- **Security architect**: These roles span across functions and provide a key governance capability to ensure all the technical functions work harmoniously within a consistent architecture
- **Security posture and compliance**: This is a newer role type that represents the increasing convergence of compliance reporting with traditional security disciplines like vulnerability management and configuration baselines. While the scope and audience are different for security and compliance reporting, they are answering different versions of the question of "how secure is the organization?" The way that question is answered is growing more similar via tools like Microsoft Secure Score and Microsoft Defender for Cloud:
  - The use of on-demand data feeds from cloud services is reducing the time required to report compliance.
  - The increased scope of data available is enabling security governance to look beyond traditional software updates/patches and discover/track "vulnerabilities" from security configurations and operational practices.
- **Platform security engineer**: These are technology roles focused on platforms that host multiple workloads, focused on both access control and asset protection. These roles are often grouped into teams with specialized technical skill sets including network security, infrastructure and endpoints, identity and key management, and others. These teams work on both preventive controls and detective controls, with detective controls being a partnership with SecOps and preventive controls being primarily a partnership with IT operations. For more information, see [Security integration](/azure/cloud-adoption-framework/secure/security-integration).
- **Application security engineer**: These technology roles focused on security controls for specific workloads, supporting both classic development models and modern DevOps/DevSecOps model. This is a blend of application/development security skills for unique code and infrastructure skills for common technical components like VMs, databases, and containers. These roles may be in central IT or security organizations or within business and development teams, depending on organizational factors.

## Modernization

Security architecture is affected by different factors:

- Continuous engagement model: Continuous release of software updates and cloud features makes fixed engagement models obsolete. Architects should be engaged with all teams working in technical topic areas to guide decision making along those teams' capability lifecycles.
- Security from the cloud: Incorporate security capabilities from the cloud to reduce enablement time and ongoing maintenance costs (hardware, software, time, and effort).
- Security of the cloud: Ensure coverage of all cloud assets including software as a service (SaaS) applications, infrastructure as a service (IaaS) VMs, and platform as a service (PaaS) applications and services. This should include discovery and security of both sanctioned and unsanctioned services.
- Identity integration: Security architects should ensure tight alignment with identity teams to help organizations meet the dual goals of enabling productivity and providing security assurances.
- Integration of internal context in security designs such as context from posture management and incidents investigated by security operations [center] (SOC). This should include elements like relative risk scores of user accounts and devices, sensitivity of data, and key security isolation boundaries to actively defend.

## Recommended content

- [Microsoft Cybersecurity Reference Architectures (MCRA) - People](https://aka.ms/MCRA-IG-People)  
An interactive training guide for people who are new to security.

- [MCRA Security Roles - YouTube](https://www.youtube.com/watch?v=GlqjvlX93gY&list=PLtVMyW0H7aiOQwZSsn2d-tg2z729ce1BZ&index=13)  
Overview of the roles and responsibilities in a security program and how they are evolving to meet the needs of modern attacks, cloud technology, and zero trust. This is a top to bottom view of roles including the board and executives.
