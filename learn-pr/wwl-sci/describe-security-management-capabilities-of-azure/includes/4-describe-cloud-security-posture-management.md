
One of Microsoft Defender for Cloud's main pillars for cloud security is Cloud Security Posture Management (CSPM). CSPM provides hardening guidance that helps you efficiently and effectively improve your security, and gives you visibility into your current security situation.

## Secure score

The central feature of Microsoft Defender for Cloud that provides visibility into your current security posture is secure score. Defender for Cloud continually assesses your cross-cloud resources for security issues. It then aggregates all the findings into a single score so that you can tell, at a glance, your current security situation: the higher the score, the lower the identified risk level.

All Defender for Cloud customers automatically gain access to the secure score when they enable Defender for Cloud. The Microsoft cloud security benchmark (MCSB) is automatically applied to your environments and generates all the built-in recommendations that contribute to this score.

:::image type="content" source="../media/single-secure-score-via-ui.png" alt-text="Screenshot showing part of Microsoft Defender for Cloud secure score for a multicloud environment.":::

## Hardening recommendations

Microsoft Defender for Cloud provides hardening recommendations based on any identified security misconfigurations and weaknesses. Recommendations are grouped into security controls. Each control is a logical group of related security recommendations and reflects your vulnerable attack surfaces. Your score only improves when you remediate all of the recommendations for a single resource within a control. Use these security recommendations to strengthen the security posture of your organization's Azure, hybrid, and multicloud resources.

:::image type="content" source="../media/defender-for-cloud-security-posture.png" lightbox="../media/defender-for-cloud-security-posture.png" alt-text="Screenshot showing part of Microsoft Defender for Cloud with recommendations.":::

## Attack path analysis

The advanced Defender CSPM plan includes attack path analysis, an AI-powered feature that helps security teams understand how an attacker might chain together vulnerabilities to reach high-value resources. By modeling potential attack paths through your environment, this feature helps you identify and prioritize the most critical risks—those that could lead to significant damage if exploited.

For example, an attack path might reveal that an internet-exposed virtual machine with a known vulnerability has access to a storage account containing sensitive data. Understanding this path helps security teams prioritize addressing the combination of issues rather than treating each vulnerability in isolation.

## Cloud security explorer

The cloud security explorer is a query-based security tool available in the advanced Defender CSPM plan. It lets security teams proactively explore the security state of their cloud environments by running graph-based queries across resources.

Rather than waiting for recommendations to surface, security teams can ask specific security questions about their environment. This proactive approach helps uncover risks before they're exploited and enables more targeted security investigations.

## Governance

Defender CSPM includes governance capabilities that help organizations drive accountability for security remediation. Security administrators can assign recommendations to specific resource owners and set due dates for remediation. This ensures that security issues don't get overlooked and that ownership of fixes is clear across teams.

## Data security posture management

Data security posture management (DSPM) helps organizations protect sensitive data stored in the cloud. It automatically discovers datastores—such as databases, storage accounts, and data services—that contain sensitive information like personal data or financial records. For each discovered datastore, DSPM assesses the security posture and surfaces targeted recommendations to reduce the risk of data exposure or breaches.

Rather than requiring security teams to manually audit each data source, DSPM continuously monitors your data environment and alerts you when datastores containing sensitive data are exposed or inadequately protected. This is especially valuable in multicloud environments, where data may be spread across Azure, Amazon Web Services (AWS), and Google Cloud Platform (GCP) with varying security configurations. DSPM is available with the Defender CSPM plan or with Microsoft Defender for Storage.

## AI security posture management

AI security posture management (AI SPM) helps organizations discover and protect their generative AI workloads. As AI adoption grows, understanding what AI applications your organization runs—and whether they're securely configured—is an important part of managing your overall security posture.

AI SPM maintains an AI Bill of Materials (AI BOM): a catalog of the generative AI models, applications, and services your organization uses. With this inventory, AI SPM assesses the security posture of each AI workload and surfaces built-in security recommendations. It also uses attack path analysis to model how vulnerabilities in your AI environment could be chained together to reach sensitive data.

For example, an AI SPM attack path might reveal that a generative AI application has access to a database containing customer data and is reachable from the internet without proper authentication—a combination of risks that could allow an attacker to extract sensitive information through the AI application. Identifying and addressing these paths proactively reduces the risk of a breach.

AI SPM is available as part of the Defender CSPM plan.

## Integration with Microsoft Security Copilot

For organizations that are onboarded to Microsoft Security Copilot, Defender for Cloud embeds Security Copilot capabilities on the recommendations page. Microsoft Copilot in Defender for Cloud helps security professionals to:

- Understand the context and significance of a recommendation.
- Evaluate the effect of implementing a recommendation.
- Get step-by-step remediation guidance.
- Remediate misconfigurations directly in code.

:::image type="content" source="../media/copilot-in-defender-for-cloud.png" lightbox="../media/copilot-in-defender-for-cloud.png" alt-text="Screenshot showing Copilot embedded in the recommendations page of Microsoft Defender for Cloud.":::

## Defender CSPM plan options

Defender for Cloud offers foundational multicloud CSPM capabilities for free. These capabilities are automatically enabled by default on any subscription or account that has onboarded to Defender for Cloud. The foundational CSPM includes asset discovery, continuous assessment and security recommendations for posture hardening, compliance with the Microsoft cloud security benchmark (MCSB), and secure score.

The optional Defender CSPM plan provides advanced posture management capabilities and tools to assess your security compliance with a wide range of benchmarks, regulatory standards, and any custom security policies. Advanced capabilities include attack path analysis, the cloud security explorer, governance, data security posture management, and AI security posture management. For a complete list of features in foundational and advanced Defender CSPM plans, see [Defender CSPM plan options](/azure/defender-for-cloud/concept-cloud-security-posture-management#plan-availability).
