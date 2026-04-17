Contoso Financial Services recently completed a major cloud migration to Azure and acquired a regional banking partner. Their security team uses Microsoft Defender for Cloud's Cloud Security Posture Management (CSPM) capabilities to monitor known Azure resources and Microsoft Defender Vulnerability Management (MDVM) to scan enrolled virtual machines for software vulnerabilities. However, security leadership is concerned about internet-facing assets they don't know about: forgotten test environments, infrastructure inherited from the acquisition with no existing inventory, and developer-created resources that bypass central IT. Traditional vulnerability scanners can't see beyond the firewall, and MDVM only scans VMs that are already enrolled and managed. The team needs an outside-in perspective to discover what attackers can actually see when they scan Contoso's internet presence.

Microsoft Defender External Attack Surface Management (EASM) provides exactly this attacker's-eye view by continuously discovering internet-facing assets you own or operate, even if you don't know about them yet. EASM complements your inside-out CSPM and vulnerability scanning by finding unknown assets, mapping their connections, and identifying security hygiene risks. These risks include expired certificates, open ports, exposed services, and OWASP vulnerabilities—all viewed from the perspective of an attacker scanning your organization from the outside.

In this module, you learn to use EASM to discover and secure your external attack surface. Specifically, you:

- Explain how EASM outside-in discovery complements inside-out CSPM posture management
- Configure asset discovery using seeds to identify unknown internet-facing infrastructure and asset connections
- Use EASM dashboards to prioritize vulnerabilities and security hygiene risks across your attack surface
- Integrate EASM findings with Defender CSPM to analyze attack paths starting from internet-exposed resources
