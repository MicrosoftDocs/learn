Microsoft Defender for Cloud is a cloud-native application protection platform (CNAPP) with a set of security measures and practices designed to protect cloud-based applications from various cyber threats and vulnerabilities. Defender for Cloud covers resources and workloads running in Azure, on other clouds such as Amazon Web Services (AWS) and Google Cloud Platform (GCP), and in on-premises environments. It combines the capabilities of:

- A development security operations (DevSecOps) solution that unifies security management at the code level across multicloud and multiple-pipeline environments.
- A cloud security posture management (CSPM) solution that surfaces actions that you can take to prevent breaches.
- A cloud workload protection platform (CWPP) with specific protections for servers, containers, storage, databases, and other workloads.
- AI security and threat protection capabilities to discover and protect generative AI applications and workloads.

:::image type="content" source="../media/defender-for-cloud-pillars-inline.png" lightbox="../media/defender-for-cloud-pillars-expanded.png" alt-text="Diagram showing the three pillars of Microsoft Defender for Cloud: DevOps security management, cloud security posture management, and cloud workload protection platform.":::

## Three pillars of Microsoft Defender for Cloud

Defender for Cloud organizes its capabilities into three pillars: DevSecOps, CSPM, and CWPP. Together, these pillars give organizations a comprehensive security approach that spans from development pipelines all the way through to production workloads.

### DevSecOps

DevSecOps integrates security practices into every phase of the software development lifecycle—an approach sometimes called "shift-left security" because it moves security checks earlier in the development process. Rather than discovering vulnerabilities at the point of deployment, built-in scans and gates catch issues while code is still being written.

Defender for Cloud helps you incorporate security practices early in the software development process. Defender for DevOps, a service available in Defender for Cloud, empowers security teams to manage DevOps security across multi-pipeline environments, such as GitHub and Azure DevOps. It provides a central console where security teams can configure DevOps resources and review findings from code, secrets, and open-source dependency vulnerability scans across multiple environments.

### Cloud security posture management (CSPM)

Misconfiguration is one of the leading causes of cloud security incidents. A single setting left at its default value, or a permission that was never restricted, can create a significant vulnerability. CSPM addresses this by continuously assessing your systems and automatically alerting security staff when vulnerabilities or misconfigurations are found.

Microsoft Defender for Cloud uses tools and services in your cloud environment to monitor and prioritize security improvements. CSPM aggregates all findings into a secure score that reflects your organization's overall security posture, and provides hardening recommendations that guide security teams toward the most impactful improvements.

### Cloud workload protection platform (CWPP)

Proactive security means protecting workloads from threats before those threats cause damage. CWPP surfaces workload-specific recommendations that lead you to the right security controls to protect your workloads.

Microsoft Defender for Cloud delivers CWPP through Microsoft Defender plans specific to the types of resources in your subscriptions—for example, Defender for Servers, Defender for Storage, or Defender for Databases. When your environment is threatened, security alerts indicate the nature and severity of the threat so you can plan your response.

## Microsoft Security Copilot in Defender for Cloud

Microsoft Security Copilot is an AI-powered security assistant that helps security professionals perform security tasks at machine speed and scale. For organizations that are onboarded to Microsoft Security Copilot, Defender for Cloud embeds Security Copilot capabilities directly into its experience.

The integration with Security Copilot allows you to use natural language prompts to:

- Analyze and understand the context of a security recommendation.
- Get a concise summary of security findings across your environment.
- Receive remediation guidance for a specific issue.
- Delegate a recommendation to the appropriate resource owner.

This AI-powered experience helps security teams work more efficiently, focusing attention on the most critical issues rather than manually parsing security data.

## Integration with Microsoft Defender XDR

When you enable Defender for Cloud, you automatically gain access to Microsoft Defender XDR, an enterprise defense suite that natively coordinates detection, prevention, investigation, and response across endpoints, identities, email, and applications to provide integrated protection against sophisticated attacks. Information on Microsoft Defender XDR is covered in a subsequent module.

## AI security and threat protection

As organizations increase their use of generative AI, securing those workloads has become an essential part of a comprehensive cloud security strategy. Beyond the three core pillars, Defender for Cloud provides dedicated capabilities to help organizations discover and protect their AI applications throughout their lifecycle.

**AI security posture management (AI SPM)** gives security teams visibility into their organization's generative AI workloads. It maintains an AI Bill of Materials (AI BOM)—a catalog of the AI models, applications, and services your organization runs. With this inventory, AI SPM assesses the security posture of those workloads, surfaces built-in recommendations specific to AI, and uses attack path analysis to identify how vulnerabilities in your AI environment could be combined to reach sensitive data. AI SPM is available as part of the Defender CSPM plan and is covered in more detail in the unit on cloud security posture management.

**AI threat protection** identifies threats to generative AI applications and agents in real time. Defender for Cloud works with Microsoft Threat Intelligence and Azure AI Content Safety to detect threats such as:

- **Prompt injection attacks**—attempts by malicious actors to manipulate an AI model's behavior by inserting instructions into its input.
- **Data leakage**—sensitive information being exposed or extracted through AI model responses.
- **Data poisoning**—attempts to corrupt the data an AI model uses, undermining the integrity of its outputs.
- **Credential theft**—attempts to steal tokens or credentials by exploiting AI application components.

Security alerts from AI threat protection integrate with Microsoft Defender XDR, which lets security teams correlate AI workload threats with alerts across the broader environment. Defender for Cloud also includes a Data and AI security dashboard, which gives security teams a central place to monitor AI resources, track risks, and check protection status.

DevSecOps, CSPM, CWPP, and AI security capabilities are covered in more detail throughout the rest of this module. But first, it's important to understand the security policies, standards, and recommendations that Defender for Cloud uses when assessing your environment.
