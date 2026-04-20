Contoso's security team discovered their external attack surface, organized their inventory, and identified critical findings in the acquired partner infrastructure. Now they need to connect the outside-in insights with their existing Defender for Cloud tooling to get a unified view of their security posture. Here, you learn how EASM integrates with Defender Cloud Security Posture Management (CSPM) to enable attack path analysis and security queries that combine internet exposure data with internal findings.

> [!NOTE]
> The built-in Defender CSPM integration runs automatically with no extra licensing or configuration. If your organization needs the full EASM dashboards, custom discovery groups, and Security Exposure Management integration, which require a standalone Defender EASM workspace.

## Compare EASM integration options in Defender for Cloud

Defender CSPM manages the security posture of your known Azure resources from the inside out—assessing configurations, misconfigurations, and access controls within your environment. EASM adds the outside-in view. When integrated, these two perspectives give you a complete, unified picture—what attackers can see from outside, what misconfigurations exist inside, and how those two views intersect.

EASM integrates with Defender for Cloud at two levels, depending on your organization's needs. The built-in integration is available automatically with the Defender CSPM plan. No separate EASM license or configuration is needed. This integration enables discovery of all internet-facing cloud resources through outside-in scanning, attack path analysis starting from internet-exposed IPs, and Cloud Security Explorer queries that combine exposure data with internal findings.

The full EASM workspace provides the comprehensive capabilities you explored in this module—all eight dashboards, custom discovery groups, and detailed inventory management. You create it as a dedicated Azure resource in the Azure portal and connect it to your tenant. This standalone resource connects to Microsoft Security Exposure Management (MSEM) for the External Attack Surface Protection initiative, giving security teams deeper discovery capabilities and unified external attack surface visibility.

For Contoso, this integration means their Cloud and AI Security Engineers can now analyze the three critical findings from the acquired partner infrastructure (discovered by EASM) alongside their existing Azure security posture (managed by CSPM) in a single workflow.

## Analyze attack paths from internet-exposed resources

The scenarios in this section use the full EASM workspace configuration—the same standalone resource Contoso deployed to run custom discovery and manage their inventory in the previous units. This configuration feeds EASM inventory data directly into Defender CSPM's attack path engine.

Attack path analysis in Defender CSPM traces exploitable paths through your cloud environment—how an attacker could move from an initial foothold to a high-value target. EASM integration extends this capability to include paths that start from internet-exposed IPs discovered through outside-in scanning.

Defender CSPM's attack path analysis finds all exploitable paths from internet-exposed endpoints. With EASM data, the analysis includes IPs and resources discovered by EASM—not just resources already enrolled in your Azure subscription. An attack path might look like this: Internet-exposed IP (discovered by EASM) → Misconfigured VM → SQL database with customer financial records.

Misconfigured resources matter for Contoso because CSPM alone could only trace attack paths starting from known Azure resources. With EASM integration, paths can now begin from the acquired partner infrastructure—hosts that Contoso didn't even know existed before their EASM deployment. EASM expands the visible attack surface to include assets that CSPM alone can't see.

To view attack paths with EASM context, navigate to **Cloud security** > **Attack path analysis** in the Microsoft Defender portal. Filter attack paths by **Internet exposed** to surface paths that start from EASM-discovered resources. Select a path to see the full chain from the internet-exposed entry point to the internal target asset.

When Contoso's team filters by internet-exposed attack paths, they find a high-severity path that begins at one of the Telnet-exposed hosts discovered by EASM on the acquired partner's domain. The path traverses through a misconfigured network peering and reaches a database containing customer financial records. This path was invisible to CSPM alone—it only became visible once EASM identified the external entry point.

## Query internet exposure with Cloud Security Explorer

Cloud Security Explorer lets you run graph-based queries across your cloud resources. With EASM integration, you can correlate internet-facing exposure data with internal resource findings to answer questions that neither tool can answer alone.

Contoso's security team runs several query scenarios to understand their risk posture. To find internet-exposed resources with high-severity vulnerabilities, they query for internet-facing hosts that have vulnerabilities with severity equal to high. The result shows all EASM-discovered internet-facing hosts that also have high-severity vulnerabilities in Defender for Cloud's internal assessment.

To validate whether internet exposure is intentional, they query for virtual machines that are exposed to the internet. This surfaces VMs that EASM identifies as internet-reachable, letting the team verify each exposure against their security policies. For several VMs in the acquired partner infrastructure, the exposure is unintentional—these systems were never meant to be publicly accessible.

To trace from internet exposure to sensitive data, they query for internet-exposed resources that have attack paths leading to storage accounts with sensitive data. The trace identifies which customer financial data stores could be reached by an attacker starting from an internet-exposed entry point. The results highlight two storage accounts containing financial records that are potentially reachable through the attack paths discovered earlier.

These queries combine EASM outside-in exposure data with Defender for Cloud's internal assessment to answer the critical question: "Can an external attacker actually reach our most sensitive assets?"

For Contoso, the Cloud Security Explorer results confirm it—two storage accounts containing financial records are potentially reachable through attack paths that begin at internet-exposed entry points EASM discovered. Those findings now have a complete, traceable chain: from the public internet, through the acquired partner infrastructure, to sensitive internal data.

With EASM integrated into Defender for Cloud, your external attack surface findings become actionable inputs to the same attack path and posture workflows you already use for internal resources. You covered the core EASM workflow—discovery, inventory management, dashboard analysis, and Defender for Cloud integration.
