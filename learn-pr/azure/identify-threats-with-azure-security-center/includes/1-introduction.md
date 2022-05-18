Keeping your cloud data and resources safe is a shared responsibility between you and Azure. It's a full-time job for your security operations (SecOps) team to keep track of created resources across the organization and ensuring they comply with your security policies. A single misconfigured option can expose customer data, or provide access to internal systems to attackers trying to penetrate your network. Fortunately, Azure offers several tools to help identify security issues, secure your services, and harden your exposed network.

Microsoft Defender for Cloud is one of the primary tools in Azure used to detect threats. Defender for Cloud enables organizations to control and monitor the security of all of their running resources using intelligent threat detection to protect them from cyberattacks. As part of that threat detection, Defender for Cloud provides recommendations to close potential security holes, and ensure compliance with your corporate policy and security guidelines.

Defender for Cloud provides an easy-to-read dashboard, which shows compliance, security health, and security alerts. This dashboard is available right off the main Azure portal dashboard, or through the search window.

:::image type="content" source="../media/1-defender-for-cloud-overview.png" alt-text="Screenshot that shows the overview page of Defender for Cloud.":::

> [!TIP]
> Microsoft Defender for Cloud pulls data from all your created resources. The level of detail presented will vary based on the running workloads in your subscription(s). This is particularly true in the Azure Sandbox which doesn't have any data.

## Learning objectives

In this module, you'll:

- Configure Microsoft Defender for Cloud to monitor your Azure resources
- Use the workload protection dashboard to identify potential security issues
- Analyze the recommendations made by Microsoft Defender for Cloud

## Prerequisites

- Basic familiarity with Azure services
