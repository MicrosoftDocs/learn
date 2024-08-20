
Microsoft Defender XDR is an enterprise defense suite of solutions that protects against sophisticated cyberattacks. Microsoft Defender XDR allows admins to assess threat signals from endpoints, applications, email, and identities to determine an attack's scope and impact. It gives greater insight into how the threat occurred, and what systems have been affected. Microsoft Defender XDR can then take automated action to prevent or stop the attack.

The Microsoft Defender XDR suite protects:

- **Endpoints with Microsoft Defender for Endpoint** - Microsoft Defender for Endpoint is a unified endpoint platform for preventative protection, post-breach detection, automated investigation, and response.
- **Assets with Defender Vulnerability Management** - Microsoft Defender Vulnerability Management delivers continuous asset visibility, intelligent risk-based assessments, and built-in remediation tools to help your security and IT teams prioritize and address critical vulnerabilities and misconfigurations across your organization.
- **Email and collaboration with Microsoft Defender for Office 365** - Defender for Office 365 safeguards your organization against malicious threats posed by email messages, links (URLs), and collaboration tools.
- **Identities with Microsoft Defender for Identity** - Microsoft Defender for Identity uses Active Directory signals to identify, detect, and investigate advanced threats, compromised identities, and malicious insider actions directed at your organization.
- **Applications with Microsoft Defender for Cloud Apps** - Microsoft Defender for Cloud Apps delivers full protection for software as a service (SaaS) applications. Defender for Cloud apps is a cloud access security broker that brings deep visibility, strong data controls, and enhanced threat protection to your cloud apps.
- **Cloud workloads and applications with Defender for Cloud** - Microsoft Defender for Cloud combines the capabilities of a development security operations (DevSecOps) solution, a cloud security posture management (CPSM) solution, and a cloud workload protection platform (CWPP) solution. Microsoft Defender for Cloud, through its DevSecOps, CSPM, and CWPP capabilities, enables organizations to manage the security of their resources and workloads and improve their overall security posture, across multicloud environments. Microsoft Defender for Cloud is covered in more detail in the module, [Describe the security management capabilities in Azure](/training/modules/describe-security-management-capabilities-of-azure/).

The Microsoft Defender XDR suite also includes **Microsoft Defender Threat Intelligence**. Microsoft Defender TI aggregates and enriches critical threat information to help security analyst triage, incident response, threat hunting, and vulnerability management workflows.

The information and insights surfaced by the Microsoft Defender XDR suite of solutions are centralized in the Microsoft Defender portal, which delivers a unified security operations platform. As a unified security operations platform, the Microsoft Defender portal now includes information and insights from other Microsoft security products, including Microsoft Sentinel.

### Microsoft Defender XDR Integration with Microsoft Copilot for Security

Microsoft Defender XDR integrates with Microsoft Copilot for Security.

For businesses that are onboarded to Microsoft Copilot for Security, the integration is enabled through plugins accessed through the Copilot portal. There are two separate plugins that support integration with Copilot for Security:

- Microsoft Defender XDR
- Natural language to KQL for Microsoft Defender XDR

:::image type="content" source="../media/defender-plugins.png" lightbox="../media/defender-plugins.png" alt-text="A screenshot of the Microsoft Defender XDR plugin and the Natural language to KQL for Microsoft Defender XDR plugin, in Microsoft Copilot for Security.":::

***Microsoft Defender XDR plugin***

The Microsoft Defender XDR plugin includes capabilities that enable users to:

- Analyze files
- Generate an incident report
- Generate a guided response
- List incidents and related alerts
- Summarize the security state of the device
- more...

Microsoft Defender XDR capabilities in Copilot are built-in prompts that you can use, but you can also enter your own prompts based on the capabilities supported.

Copilot also includes a builtin promptbook for Microsoft Defender XDR incident investigation you can use to get a report about a specific incident, with related alerts, reputation scores, users, and devices.

With the plugin enabled, Copilot integration with Defender XDR can also be experienced through the embedded experience. The scenarios supported through the embedded experience are described in more detail in the module titled, "Describe the embedded experiences of Microsoft Copilot for Security."

***Natural language to KQL for Microsoft Defender***

The Natural language to KQL for Microsoft Defender plugin enables query assistant functionality that converts any natural-language question in the context of threat hunting, into a ready-to-run KQL query. The query assistant saves security teams time by generating a KQL query that can then be automatically run or further tweaked according to the analyst’s needs.
