Contoso Financial Services uses Cloud Security Posture Management (CSPM)—which assesses Azure resources for misconfigurations from the inside out—and Microsoft Defender Vulnerability Management (MDVM)—which scans enrolled VMs for software vulnerabilities. After their recent acquisition, the security team realized neither tool has visibility into what the acquired company exposed to the internet—because neither tool knows those assets exist. Defender EASM operates from the opposite direction: it starts from the internet and works inward. Here, you explore how EASM is deployed, what it scans, and what it produces.

## Deploy EASM as an Azure resource

Defender EASM is deployed as a standalone Azure resource through the Azure portal. Each EASM workspace is scoped to an Azure subscription and resource group, and is provisioned in a supported region. Once deployed, the EASM scanning engine continuously queries public internet data sources—it doesn't require agents, network access, or enrollment in the target infrastructure. Everything it discovers is based on publicly available data.

The scanning engine uses Microsoft's proprietary recursive technology to map assets connected to seeds you provide. Seeds are known, legitimate assets such as your organization's primary domains, registered IP blocks, or ASNs. From each seed, EASM queries multiple public data sources to discover related infrastructure, then recurses through those connections to expand the map. The next unit covers discovery configuration in detail.

### Deploying an EASM workspace

To deploy EASM, you need at least **Contributor** access to the Azure subscription and resource group where the workspace is created. The deployment takes place entirely in the Azure portal—no agent or network changes are required. At a high level, the steps are:

1. In the Azure portal, search for **Microsoft Defender EASM** and select **Create**.
2. Select or create a **resource group** in a supported region (such as East US or West Europe).
3. Name the workspace and select **Review + create**, then **Create**.
4. Once the resource is provisioned, open it and select **Getting Started** to search for your organization's prebuilt attack surface or configure a custom discovery group.

Once deployed, the workspace begins discovery in the background. The portal shows discovery progress through the run history on the **Discovery** page.

### Operating EASM—roles and Zero Trust alignment

Once the workspace exists, day-to-day operations require a defined set of permissions. Following the Zero Trust principle of **least privilege**, assign only the access level each team member needs:

| Role | What they can do |
|------|-----------------|
| **Owner / Contributor** | Create, edit, and delete EASM resources and inventory assets; configure discovery groups; manage labels |
| **Reader** | View inventory, dashboards, and findings—read-only; can't modify any asset or configuration |

Defender EASM does **not** support cross-tenant resource access, including via Azure Lighthouse. Each EASM resource must be accessed by authenticating directly to the tenant where it was created. This constraint reinforces Zero Trust's **verify explicitly** principle—every access request to EASM data must come from an authenticated identity in the same tenant, with no implicit trust granted across organizational boundaries.

## Distinguish EASM from other security tools

EASM operates from a different vantage point than CSPM and MDVM. Where CSPM assesses known Azure resources from the inside out and MDVM scans enrolled VMs for software vulnerabilities, EASM discovers all internet-facing infrastructure from an attacker's outside-in perspective—including assets not in the inventory yet.

> [!NOTE]
> EASM and MDVM both surface CVE-related findings, but from opposite directions. MDVM identifies CVEs in software installed on enrolled VMs. EASM identifies CVEs in services exposed on the public internet, whether or not those hosts are enrolled in any management system.

## Examine what EASM discovers

EASM catalogs eight types of internet-facing assets:

| Asset type | Description |
|---|---|
| **Domains** | Registered domain names associated with your organization |
| **Hosts** | Subdomains and fully qualified domain names (FQDNs) |
| **Pages** | Web pages including sign in portals and admin interfaces |
| **IP blocks** | IP address ranges associated with your network |
| **IP addresses** | Individual internet-facing IPs |
| **Autonomous System Numbers (ASNs)** | Routing identifiers for your network infrastructure |
| **SSL certificates** | TLS certificates linked to your hosts and domains |
| **WHOIS contacts** | Registrant contact data associated with your domains |

Each discovered asset is assigned to a **state—such as **Approved inventory**, **Candidate**, or **Dependency** - that defines its relationship to your organization. The discovery unit covers all five states and how to use them when reviewing your inventory.

Findings across discovered assets are assigned to a severity rating—high, medium, or low—based on Microsoft assessment of potential issues. High-severity findings include new or frequently exploited CVEs, easily exploitable vulnerabilities, and associations to known-compromised infrastructure. Low-severity findings include deprecated but noncritical technologies, infrastructure nearing expiration, and compliance misalignments. EASM identifies issues such as expired or weak SSL certificates, open administrative ports, services running deprecated protocols, known CVEs on internet-exposed services, and IPs with poor reputation scores. Each finding links to the affected asset in the inventory for investigation.

OWASP Top 10 findings appear in a separate dedicated dashboard and use OWASP category classification—broken access control, cryptographic failures, injection, and so on—rather than EASM's high/medium/low scale. Both systems are covered in detail in the dashboard analysis unit later in this module.

## Explore EASM dashboards and Defender for Cloud integration

EASM includes eight dashboards that organize findings by risk category—including security posture, OWASP Top 10, data protection compliance, and an inventory changes view. The four highest-value dashboards are covered in detail in the dashboard analysis unit later in this module.

EASM also integrates with Defender CSPM. The integration is included with the Defender CSPM plan and requires no extra license or configuration. It surfaces EASM outside-in data in Defender for Cloud's attack path analysis and Cloud Security Explorer. The integration unit covers the specific query patterns it enables.
