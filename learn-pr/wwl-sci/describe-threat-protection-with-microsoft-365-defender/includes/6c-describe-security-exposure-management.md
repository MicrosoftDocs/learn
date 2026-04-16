As organizations grow, so do their digital environments. Devices, identities, cloud resources, and applications create a broad and constantly changing attack surface. Without a unified view, security teams struggle to see the full picture and know which risks to address first.

Microsoft Security Exposure Management is a security solution in the Microsoft Defender portal that provides a unified view of security posture across your organization's assets and workloads. It aggregates signals from Microsoft Defender for Endpoint, Microsoft Defender for Cloud, Microsoft Defender for Identity, Microsoft Entra ID, and non-Microsoft tools to continuously discover and enrich asset information with security context. This gives security teams a single place to manage attack surfaces, protect critical assets, and mitigate exposure risk.

## Attack surface management

An attack surface is the total collection of entry points and pathways that an attacker could use to gain access to your environment. As organizations adopt cloud services and hybrid infrastructure, the attack surface extends across on-premises systems, multiple cloud platforms, and external-facing resources. Managing this sprawling attack surface requires visibility into how all these assets connect and interact.

### The enterprise exposure graph

At the core of attack surface management is the enterprise exposure graph. The graph gathers information about assets, users, and workloads from across your organization—including cloud misconfigurations, multicloud assets (Azure, AWS, and GCP), and external attack surface data—to create a comprehensive map of your security posture. Security teams can query the graph to explore assets, assess risk, and hunt for threats across on-premises, hybrid, and multicloud environments.

### The attack surface map

The attack surface map is a visual representation of the enterprise exposure graph. It lets security teams see what assets are at risk and how they connect across on-premises and cloud environments. For example, a security team could use the map to check whether a device has unwanted connections or whether cloud misconfigurations expose on-premises assets.

### Attack paths

Understanding where vulnerabilities exist is important, but it's also critical to understand how an attacker could chain those vulnerabilities together to reach a high-value target. Security Exposure Management automatically generates attack paths based on data collected across assets and workloads, including paths that span on-premises and cloud environments. Each attack path shows the sequence of steps—from an exposed endpoint or misconfigured access setting to a critical asset—that an attacker could follow.

The attack path dashboard provides a high-level view of paths, choke points, and affected critical assets. A choke point is a node where multiple attack paths converge. Securing a single choke point can disrupt multiple attack routes at once, making choke points a high priority for remediation. For each attack path, Security Exposure Management provides recommendations such as fixing a misconfiguration, restricting access permissions, or patching a vulnerability.

# [Dashboard](#tab/overview)
:::image type="content" source="../media/exposure-management-attack-surface-dashboard.png" lightbox="../media/exposure-management-attack-surface-dashboard.png" alt-text="A screenshot of the Attack surface management overview page, also referred to as the dashboard.":::

# [Attack path](#tab/attack-path)
:::image type="content" source="../media/exposure-management-attack-path-with-map.png" lightbox="../media/exposure-management-attack-path-with-map.png" alt-text="A screenshot of a selected attack path and the corresponding map for that attack path.":::

---

## Critical asset management

Not every asset carries the same level of risk. A domain controller or an account with high-level administrative privileges represents a far greater risk if compromised than a standard workstation. Security Exposure Management helps you identify, classify, and prioritize these high-value targets—called critical assets. The solution provides predefined critical asset classifications, including:

- Critical cybersecurity assets such as file servers and domain controllers.
- Databases that contain sensitive data.
- Identity groups such as power users.
- User roles such as privileged role administrators.
- Cloud resources from Azure, AWS, and GCP environments.

You can also create custom classifications tailored to your organization using a query builder to match assets based on criteria like naming conventions or resource tags. Once classified, asset criticality levels appear throughout the Defender portal—in the device inventory, advanced hunting, and attack paths—helping security teams focus on the assets that matter most.

:::image type="content" source="../media/critical-asset-management.png" lightbox="../media/critical-asset-management.png" alt-text="A screenshot of the critical asset management settings page in Microsoft Defender XDR.":::

## Exposure insights

Exposure insights aggregate security posture data across all assets, helping chief information security officers (CISOs), decision makers, and security teams prioritize where to invest security efforts.

### Security initiatives

Security initiatives group related metrics and recommendations for a specific security area or workload. Each initiative provides an overall score that reflects current security posture, along with a target score, the number of critical assets affected, and recent score changes.

Security Exposure Management provides several types of initiatives:

- **Workload initiatives** assess and manage risk for specific workload domains, such as endpoint security, identity resources, and cloud assets.
- **Horizontal threat initiatives** assess risk for specific threat categories, such as ransomware protection or business email compromise.
- **Threat analytics initiatives** assess threat risk based on up-to-date research from Microsoft security researchers, focusing on real-world threat actors and attack vectors.
- **Zero Trust initiative** assesses risk associated with Zero Trust compliance, aligned with Microsoft's Zero Trust adoption framework.

:::image type="content" source="../media/exposure-management-initiatives.png" lightbox="../media/exposure-management-initiatives.png" alt-text="A screenshot of the initiatives page.":::

### Metrics and recommendations

Within each initiative, metrics measure exposure risk for different areas. Each metric gathers one or more recommendations for similar assets. As you act on recommendations and improve metrics, the initiative score rises to reflect a stronger security posture.

Security recommendations come from multiple sources, including Security Exposure Management, Microsoft Secure Score, and Microsoft Defender for Cloud. All recommendations are consolidated into a unified catalog in the Defender portal, organized by attack surface (devices, cloud, identity, SaaS, and data) and categorized by issue type (misconfigurations and vulnerabilities). Every action taken on a recommendation helps reduce exposure and directly improves related metrics and initiative scores.

:::image type="content" source="../media/exposure-management-recommendations.png" lightbox="../media/exposure-management-recommendations.png" alt-text="A screenshot of the exposure management recommendations page.":::

### Microsoft Secure Score and Security Exposure Management

Microsoft Secure Score is a numerical measurement of your organization's security posture—a higher score means you've taken more recommended security actions. Secure Score assigns points for recommended actions based on how fully you've implemented them. For example, if a recommendation asks you to protect all users with multifactor authentication (MFA) and you've protected 50 out of 100 users, you receive a partial score. Secure Score covers recommendations across Microsoft products including Microsoft Entra ID, Microsoft Defender for Endpoint, Microsoft Defender for Office, Microsoft Defender for Cloud Apps, and Microsoft Teams.

Security Exposure Management uses Secure Score as one of its key data sources. Secure Score recommendations feed directly into initiatives and metrics, and improvements to those recommendations directly affect initiative scores.

Within the Defender portal, Security Exposure Management presents multiple secure scores side by side:

- **Microsoft Secure Score** measures overall organizational posture across identities, devices, SaaS applications, and data, covering recommendations from Microsoft Entra ID, Defender for Endpoint, and other Microsoft 365 services.
- **Cloud Secure Score** measures cloud security posture across Azure, AWS, and GCP. This score comes from Microsoft Defender for Cloud and factors in asset risk and criticality to prioritize recommendations for the highest-risk cloud resources.
- **Domain-specific scores** appear within individual initiatives. For example, the endpoint security initiative has its own score based on device-related metrics, while the identity initiative tracks identity-specific posture.

By presenting these scores together, Security Exposure Management gives security teams a consolidated view across all security domains in one place.

:::image type="content" source="../media/exposure-management-secure-score-v2.png" lightbox="../media/exposure-management-secure-score-v2.png" alt-text="A screenshot of the Secure scores page in the Microsoft Defender portal.":::

### Monitoring changes over time

Security Exposure Management tracks the history of initiative scores and metric values over time. Events notify you when there's a significant drop in score, indicating that exposure risk has grown. Security teams can drill down into specific changes to understand what drove a score change, review affected assets, and take corrective action.

## Data connectors

Security Exposure Management isn't limited to Microsoft data sources. It supports data connectors that integrate with non-Microsoft security solutions and platforms, such as ServiceNow CMDB, Tenable, Qualys, and Rapid7. These connectors consolidate security data from across your environment into a single unified view, giving security teams deeper insights into their overall posture without needing to check multiple tools separately.

## How Security Exposure Management relates to Defender Vulnerability Management

Defender Vulnerability Management focuses on **individual vulnerabilities and misconfigurations at the endpoint and software layer**. It identifies specific Common Vulnerabilities and Exposures (CVEs) on devices, evaluates unpatched software, and provides prioritized remediation based on exploit likelihood and asset importance.

Security Exposure Management operates at a **higher, cross-workload level**. Rather than tracking individual CVEs, it answers broader questions: What is my overall attack surface? What path could an attacker take through my endpoints, identities, and cloud resources to reach a critical asset? Defender Vulnerability Management is one of several data sources that feed into Security Exposure Management. For example, a CVE detected on an endpoint might appear as one step in an attack path that also involves a misconfigured cloud resource and an overprivileged identity. Security Exposure Management connects those dots across workload boundaries.

## How Security Exposure Management fits in the Defender portal

Security Exposure Management is available in the Microsoft Defender portal alongside the incident queue, threat hunting, and other Defender XDR capabilities. Security teams access the attack surface map, critical asset classifications, attack paths, and exposure insights from a single location—without switching between separate tools.
