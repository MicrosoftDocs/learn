While Defender for Cloud monitors resources you know about, attackers probe your external presence for assets you might have forgotten. Microsoft Defender External Attack Surface Management (Defender EASM) provides the outside-in view that complements your inside-out security posture. As a security architect, designing an EASM solution helps identify shadow IT, forgotten infrastructure, and external exposure before attackers exploit them.

## Understanding external attack surface management

Your external attack surface consists of all internet-facing assets that could be entry points for attacks: domains, hosts, IP addresses, web applications, SSL certificates, and their relationships. Defender EASM discovers these assets by starting with known infrastructure (seeds) and recursively mapping connections to uncover assets you might not know you own.

Defender EASM discovers and catalogs:

| Asset type | Examples |
|-----------|----------|
| Domains | Primary domains, subdomains, acquired company domains |
| Hosts | Web servers, mail servers, DNS servers |
| IP addresses and blocks | Public IP ranges, cloud-hosted IPs |
| Web pages | Sign-in portals, APIs, forgotten applications |
| SSL certificates | Certificate chains, expiration status |
| ASNs and WHOIS data | Network ownership, registration contacts |

**Design consideration**: Defender EASM provides an external perspective—it discovers what attackers can see. Combine this with Defender for Cloud's internal view for complete attack surface visibility.

## Designing discovery configuration

Discovery starts with seeds—known assets that Defender EASM uses to map your attack surface. Your seed selection directly affects discovery completeness.

**Seed types**: Provide domains, IP blocks, hosts, email contacts, ASNs, or WHOIS organization names. The more accurate seeds you provide, the more complete your discovered attack surface.

**Discovery groups**: Organize seeds into discovery groups based on business units, brands, subsidiaries, or acquired companies. Each group runs independently with its own recurrence schedule.

**Recurrence frequency**: Configure weekly discovery (recommended) for continuous monitoring, or run one-time discoveries for initial assessment. Weekly cadence catches new assets and infrastructure changes.

**Exclusions**: Specify entities to exclude from discovery, such as subsidiaries you don't own or third-party infrastructure that shouldn't appear in your inventory.

**Design consideration**: Start with your organization's prebaked attack surface if available—Microsoft maintains preconfigured attack surfaces for many organizations. Then customize with additional seeds for subsidiaries, brands, or recently acquired companies.

## Managing asset inventory

Discovered assets require classification to distinguish owned infrastructure from third-party dependencies:

| Asset state | Description | Use case |
|-------------|-------------|----------|
| Approved Inventory | Assets you own and are responsible for | Your primary domains, servers, applications |
| Dependency | Third-party infrastructure supporting your assets | CDN providers, hosting services |
| Monitor Only | Related but not directly controlled | Franchisees, partner organizations |
| Candidate | Requires manual review to confirm ownership | Newly discovered assets with unclear ownership |
| Requires Investigation | Flagged for deeper analysis | Assets with weak connection confidence |

Only **Approved Inventory** assets appear in dashboard metrics by default and receive daily scanning. Design your workflow to regularly review Candidate assets and promote legitimate assets to Approved Inventory.

**Labels and external IDs**: Apply labels to organize assets by business unit, compliance requirement, or remediation priority. External IDs help correlate EASM data with your existing asset management systems.

## Designing integration with Defender for Cloud

Defender for Cloud's CSPM plan includes EASM integration at no extra cost. This integration enables internet-exposure validation by combining outside-in discovery with inside-out configuration assessment.

The integration provides:
- Correlation between externally discovered assets and internal cloud resources
- Validation that internal resources marked as internet-facing match external visibility
- Identification of unexpected external exposure

**Design consideration**: The EASM integration in Defender CSPM uses lightweight discovery. For comprehensive external attack surface analysis with full asset-level details, deploy a dedicated Defender EASM resource.

## Designing data connections and workflows

Defender EASM data becomes more valuable when integrated with your security operations:

**Log Analytics integration**: Export EASM data to Log Analytics for:
- Creating or enriching security incidents in Microsoft Sentinel
- Building investigation playbooks
- Triggering automated remediation workflows
- Correlating external assets with internal security events

**Azure Data Explorer**: For organizations requiring custom analytics, export to Azure Data Explorer for:
- Building custom Power BI reports
- Running complex KQL queries across attack surface data
- Long-term data retention and trend analysis

**Microsoft Security Copilot**: When integrated, Security Copilot can query EASM data using natural language, helping analysts quickly understand attack surface risks and prioritize remediation.

**Design consideration**: Data connections are subject to the pricing of the destination platform (Log Analytics or Azure Data Explorer). Factor these costs into your EASM design.

## Using dashboards for prioritization

Defender EASM provides eight dashboards to prioritize security efforts:

| Dashboard | Purpose |
|-----------|---------|
| Overview | Default landing page with key attack surface context |
| Inventory Changes | New, modified, and removed assets over time |
| Attack Surface Summary | High-level view of risks by severity (high, medium, low), cloud hosting, IP reputation |
| Security Posture | CVE exposure, domain configuration, open ports, SSL certificate status |
| Data Protection Compliance | Compliance risks for data protection requirements on EU-accessible infrastructure |
| OWASP Top 10 | Critical web application security risks based on OWASP list |
| CWE Top 25 | Common software weaknesses based on annual MITRE list |
| CISA Known Exploits | Vulnerabilities with confirmed exploitation by threat actors |

Use the Attack Surface Summary to identify high-severity findings—critical CVEs, compromised infrastructure associations, deprecated technology, or compliance issues. Each insight includes suggested remediation actions.

## Understanding pricing and billable assets

Defender EASM pricing is based on billable assets—the Approved Inventory assets actively monitored. Design your inventory classification to balance comprehensive coverage with cost:

- Only Approved Inventory assets count toward billing
- Monitor the billable assets dashboard to track costs
- New resources include a 30-day free trial
- Use asset states strategically—keep assets in Candidate state until you confirm ownership and want active monitoring

## Addressing common design challenges

**Shadow IT discovery**: EASM excels at finding forgotten assets. Establish a process for reviewing Candidate assets and investigating Requires Investigation items to catch shadow IT.

**Acquisition integration**: When acquiring companies, create separate discovery groups with the acquired organization's domains and IP blocks. Review discovered assets against the acquisition's documented infrastructure.

**Third-party risk**: Use the Dependency state for assets owned by third parties that support your operations. Track these assets separately from your owned infrastructure while maintaining visibility into their security posture.

**False positives**: Some discovered assets might not belong to your organization despite apparent connections. Use exclusions to prevent these from appearing in future discoveries, and mark observations as nonapplicable when CVEs don't affect your specific configuration.

Your external attack surface represents what adversaries see when they scan your organization. Defender EASM provides that attacker's perspective, enabling you to identify and remediate exposures before they become entry points.
