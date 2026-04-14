In this module, you learned how Microsoft Defender External Attack Surface Management gives you an outside-in view of your organization's internet-facing infrastructure. While traditional tools focus on known, enrolled resources, External Attack Surface Management (EASM) discovers assets from an attacker's perspective. This includes shadow IT, forgotten infrastructure, and newly acquired systems outside of your known inventory.

You configured asset discovery using seeds like domains, IP addresses, and ASNs, letting EASM recursively map connections across your attack surface. For Contoso Financial Services, this discovery process revealed critical gaps after their partner acquisition, including unknown assets from the acquired company's infrastructure that traditional inventory methods missed.

Using four of EASM's eight security-focused dashboards, you learned to prioritize risks across your external attack surface. Contoso uncovered Telnet-exposed hosts, expiring SSL certificates, and domain registration issues in their newly acquired partner infrastructure—vulnerabilities that could go unnoticed without EASM's comprehensive visibility.

The integration with Defender CSPM extended that visibility further. By analyzing attack paths that start from internet-exposed resources, Contoso traced a critical exposure from a Telnet-accessible acquired host to their customer financial database—a risk that was invisible to CSPM alone before EASM identified the external entry point.

As you apply these skills in your own environment, you gain the visibility needed to secure not just the assets you know about, but the ones you don't—closing security gaps before attackers find them.

## In this module, you:

- Explored EASM features and capabilities, including the eight asset types, five asset states, and how its outside-in scanning scope and deployment model differ from Defender CSPM and MDVM
- Configured asset discovery by deploying an EASM workspace, providing seeds, and setting up automated and custom discovery groups to identify unknown internet-facing infrastructure
- Used EASM dashboards to prioritize vulnerabilities and security hygiene risks—including CVE exposure, open ports, SSL certificate issues, and OWASP Top 10 web application findings—across your external attack surface
- Integrated EASM findings with Defender CSPM to analyze attack paths starting from internet-exposed resources discovered through outside-in scanning

## Learn more

- [Microsoft Defender EASM overview](/azure/external-attack-surface-management/overview)
- [What is discovery in Defender EASM?](/azure/external-attack-surface-management/what-is-discovery)
- [Use and manage discovery](/azure/external-attack-surface-management/using-and-managing-discovery)
- [Understanding dashboards](/azure/external-attack-surface-management/understanding-dashboards)
- [Understanding inventory assets](/azure/external-attack-surface-management/understanding-inventory-assets)
- [External attack surface management in Defender for Cloud](/azure/defender-for-cloud/concept-easm)
- [Create a Defender EASM Azure resource](/azure/external-attack-surface-management/deploying-the-defender-easm-azure-resource)
