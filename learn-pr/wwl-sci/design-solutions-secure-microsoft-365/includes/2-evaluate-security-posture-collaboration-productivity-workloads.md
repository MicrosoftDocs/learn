Evaluating security posture for productivity and collaboration workloads requires a metrics-driven approach. Microsoft provides two complementary tools for this purpose: **Microsoft Secure Score** and **Microsoft Security Exposure Management**. Together, these tools give you quantitative measurements and contextual insights to assess risk exposure across Microsoft 365 services and guide your security design decisions.

## Evaluate posture with Microsoft Secure Score

[Microsoft Secure Score](/defender-xdr/microsoft-secure-score) is a numerical measurement of your organization's security posture, available in the [Microsoft Defender portal](https://security.microsoft.com/securescore). A higher score indicates that more recommended security actions are implemented. Secure Score helps your organization:

- **Report** on the current state of security posture across productivity workloads.
- **Improve** posture by providing discoverability, visibility, guidance, and control.
- **Benchmark** against similar organizations and establish key performance indicators (KPIs).

Your score updates in near-real time to reflect configuration changes, and Secure Score syncs daily to receive system data about your achieved points. Each recommended action is worth up to 10 points, with most scored in a binary fashion. You either implement the action fully or receive partial points based on the percentage of completion. For example, if a recommended action awards 10 points for protecting all users with multifactor authentication and you've protected 50 out of 100 users, you receive five points.

> [!NOTE]
> Secure Score represents the extent to which you're using security controls in your Microsoft environment. It isn't an absolute measurement of breach likelihood.

### Products covered by Secure Score

Secure Score provides recommendations for productivity and collaboration workloads across these products:

- Exchange Online and SharePoint Online
- Microsoft Entra ID
- Microsoft Defender for Endpoint, Microsoft Defender for Identity, and Microsoft Defender for Office
- Microsoft Defender for Cloud Apps
- Microsoft Purview Information Protection
- Microsoft Teams
- App governance

Secure Score also covers non-Microsoft SaaS applications connected through Defender for Cloud Apps, including Okta, Salesforce, ServiceNow, GitHub, Citrix ShareFile, Docusign, and Zoom. This coverage means you can evaluate your security posture across both Microsoft and non-Microsoft productivity tools from a single dashboard.

### Recommendation categories

Recommended actions are organized into four groups that align to the core dimensions of your productivity workload security:

- **Identity**: Microsoft Entra accounts and roles, including multifactor authentication, Conditional Access policies, and privileged role management.
- **Device**: Microsoft Defender for Endpoint recommendations, covered under [Microsoft Secure Score for Devices](/windows/security/threat-protection/microsoft-defender-atp/tvm-microsoft-secure-score-devices), including vulnerability management and endpoint configuration.
- **Apps**: Email and cloud app security, including Exchange Online protection policies and Defender for Cloud Apps configurations.
- **Data**: Microsoft Purview Information Protection recommendations, covering data classification, sensitivity labels, and data loss prevention policies.

Use these categories to identify gaps across different areas of your collaboration environment and prioritize remediation based on your organization's risk profile.

## Interpret Secure Score metrics

The Secure Score overview page in the Microsoft Defender portal provides several metric views to help you understand your posture from different perspectives:

- **Planned score**: The projected score after you complete planned actions, useful for communicating expected improvements to stakeholders.
- **Current license score**: The maximum score achievable with your existing Microsoft licenses, which helps identify whether licensing gaps limit your security coverage.
- **Achievable score**: The score attainable with your current licenses and accepted risk levels.

:::image type="content" source="../media/secure-score-achievable.png" alt-text="Screenshot showing your secure score including planned score, current license score, and achievable score in the Microsoft Defender portal." border="true":::

The historical trend view tracks how your score changes over time, and benchmark comparisons show how you align with organizations of a similar size and industry. These metrics are valuable for measuring the effectiveness of your security strategy and justifying investments to leadership.

### Evaluate and prioritize recommended actions

Each recommended action listed in Microsoft Secure Score provides information, including:

- **Rank**: Position based on points remaining, implementation difficulty, user impact, and complexity. Higher-ranked actions offer the most improvement with the least effort.
- **Score impact**: The projected increase to your overall Secure Score if you complete the action.
- **Points achieved**: The number of points earned out of the maximum available for the action. Partial points are awarded when only some resources are compliant.
- **Status**: The current state of the action: *To address*, *Planned*, *Risk accepted*, *Resolved through third party*, *Resolved through alternate mitigation*, or *Completed*.
- **Category**: The security domain the action belongs to: Identity, Device, Apps, or Data.
- **Product**: The Microsoft or connected non-Microsoft product the action applies to.

The highest ranked actions should be prioritized first. For actions that have high user impact, plan phased rollouts and communicate changes to affected teams. When your organization uses non-Microsoft security tools to address a recommendation, mark those actions as *Resolved through third party* so your score accurately reflects your overall posture. Keep in mind that Microsoft has no visibility into the completeness of those implementations.

:::image type="content" source="../media/secure-score-improvement-action-details.png" alt-text="Screenshot that shows the flyout of a recommended action in the Microsoft Defender portal." border="true":::

## Extend posture evaluation with Microsoft Security Exposure Management

[Microsoft Security Exposure Management](/security-exposure-management/microsoft-security-exposure-management) builds on Secure Score by providing a unified view of security posture across your entire digital estate, including endpoints, cloud resources, and external attack surfaces. While Secure Score acts as an industry baseline and benchmark, Security Exposure Management adds deeper contextual analysis for designing holistic protection strategies for productivity workloads.

Key capabilities that complement Secure Score include:

| Capability | How it extends posture evaluation |
|---|---|
| **Recommendations** | Includes Secure Score recommendations plus recommendations from other sources, such as Microsoft Defender for Cloud, providing broader coverage than Secure Score alone. |
| **Exposure insights** | Aggregates security posture data and provides rich context around the security posture state of your assets and workloads, helping you prioritize security efforts and investments across your entire environment. |
| **Metrics** | Groups recommendations for similar assets together, enabling you to gauge exposure levels for categories of resources quickly. |
| **Initiatives** | Organizes metrics into predefined scenarios, such as a ransomware initiative that gathers all ransomware-related recommendations into a single view. |
| **Attack paths** | Visualizes how an attacker could breach your environment, including hybrid paths that span on-premises and cloud infrastructure. |
| **Enterprise exposure graph** | Enables cross-workload queries to explore assets, assess risk, and visualize relationships between identities, devices, data, and applications. The attack surface map provides visual exploration of resources and connections. |
| **Critical asset management** | Marks predefined and custom assets as critical across devices, identities, and cloud resources. Enables you to focus protection and prioritization on assets that affect business continuity. |

### Vulnerability management integration

[Microsoft Defender Vulnerability Management](/defender-vulnerability-management/defender-vulnerability-management) now resides within Security Exposure Management, providing a unified vulnerability management experience across your digital estate. This integration delivers several benefits for evaluating collaboration workload posture:

- **Unified vulnerability view**: Organizations with both Defender for Cloud and Defender for Endpoint licenses can see all vulnerabilities affecting their devices and cloud resources in a single view.
- **Risk-based prioritization**: Cloud vulnerabilities are prioritized by risk in the Defender portal, helping you focus on the most impactful issues across your productivity workloads.
- **Integrated recommendations**: Vulnerability management recommendations feed into the unified recommendations catalog, with separate views for misconfigurations and vulnerabilities to support different remediation workflows.

### Data connectors

Security Exposure Management supports [data connectors](/security-exposure-management/overview-data-connectors) that integrate with external security solutions and data sources. These connectors consolidate security data from non-Microsoft tools—such as ServiceNow CMDB for asset management, and Tenable, Qualys, and Rapid7 for vulnerability assessment—into a single unified view. Connectors for Wiz and Palo Alto Prisma extend coverage to non-Microsoft cloud security platforms.

Data collected through these connectors is normalized within the enterprise exposure graph, enriching your device inventory, mapping relationships between external assets and existing infrastructure, and revealing new attack paths. For a security architect evaluating productivity workloads, connectors provide a complete picture of posture across both Microsoft and non-Microsoft security tools.

For productivity and collaboration workloads, Security Exposure Management helps you understand the relationships between identities, devices, data, and applications in your Microsoft 365 environment. You can identify where attackers might exploit weaknesses across those surfaces and prioritize remediation accordingly.

## Design considerations for security architects

When you evaluate and design security posture for productivity and collaboration workloads, consider the following approaches:

- **Establish a measurable baseline.** Use Secure Score to set a starting point and monitor scores across identity, device, apps, and data categories to understand where your organization has the most exposure.
- **Align with licensing.** Compare your current score with your current license score. Gaps between these scores represent quick wins that don't require extra spending.
- **Enable SaaS security posture management (SSPM).** Turn on Secure Score recommendations for SaaS applications connected through Defender for Cloud Apps. This extends posture assessment to non-Microsoft productivity tools your organization depends on.
- **Plan for continuous improvement.** Use score history and trend data to track progress over time, set KPIs, and report posture improvements during security reviews.
- **Balance security and usability.** Not every recommended action is appropriate for every environment. Use the risk acceptance workflow to document decisions where you intentionally defer security controls due to business requirements.
- **Combine Secure Score with Exposure Management.** Use Secure Score for baseline measurement and benchmarking, and use Security Exposure Management for deeper analysis of attack paths and cross-workload risks.

## Evaluate AI readiness as a posture dimension

As organizations adopt generative AI tools, security posture evaluation must extend to AI-specific risks. [Data Security Posture Management (DSPM)](/purview/data-security-posture-management-learn-about) in Microsoft Purview provides AI-focused posture metrics that complement Secure Score and Security Exposure Management. DSPM tracks objectives related to data exposure prevention, oversharing risk, and policy coverage. These capabilities are covered in detail in the unit on evaluating data security controls for Microsoft 365 Copilot.

From a posture evaluation perspective, the **AI observability** dashboard in DSPM is especially relevant. It inventories all active AI apps and agents across your organization, highlights high-risk agents, and reports sensitive interactions. This gives you visibility into how AI tools interact with organizational data, which feeds directly into the posture metrics you track alongside Secure Score and Security Exposure Management.

The [Microsoft Security Dashboard for AI](https://ai.security.microsoft.com) provides a complementary executive-level view. It aggregates AI risk signals from Microsoft Entra, Microsoft Defender, and Microsoft Purview into a single dashboard, covering identity governance for AI apps, threat protection for AI workloads, data classification of AI-accessible content, and compliance posture against AI regulations. For security architects, this dashboard provides a starting point for assessing whether existing security controls adequately cover the AI attack surface.

## Align with Microsoft cloud security benchmark v2

The [Microsoft cloud security benchmark v2 (MCSBv2)](/security/benchmark/azure/overview) provides a framework of security controls that validates your posture evaluation approach against Microsoft-recommended best practices. The **Posture and Vulnerability Management (PV)** domain maps directly to the capabilities covered in this unit:

| MCSBv2 control | Secure Score / MSEM alignment |
|---|---|
| **PV-1: Define and establish secure configurations** | Secure Score recommendations define configuration baselines for Microsoft 365 services. MSEM initiatives group related recommendations into predefined scenarios, such as ransomware protection. |
| **PV-2: Audit and enforce secure configurations** | Secure Score continuously audits configurations and reports deviations. MSEM metrics track exposure levels across asset categories, enabling you to detect configuration drift. |
| **PV-5: Perform vulnerability assessments** | Defender Vulnerability Management within MSEM provides unified vulnerability assessments across endpoints and cloud resources, with risk-based prioritization in the Defender portal. |
| **PV-6: Rapidly and automatically remediate vulnerabilities** | Secure Score recommended actions provide guided remediation steps with priority scoring. MSEM attack paths highlight which vulnerabilities require urgent remediation based on exploitability. |

For security architects, referencing MCSBv2 when presenting posture evaluation findings provides a recognized framework that maps to industry standards, including NIST SP 800-53, PCI-DSS v4, CIS Controls v8.1, and ISO 27001:2022.
