Contoso Financial Services runs Azure OpenAI models through Microsoft Foundry to support document analysis and regulatory research. These models process prompts that contain sensitive financial data—client account details, transaction records, and compliance findings. The security team enabled Defender for Cloud Apps to protect Copilot Studio agents at the session layer. But the Azure AI services that power Contoso's Foundry deployments have no threat detection enabled. If an attacker attempts a jailbreak or data exfiltration through the model inference layer, the security team has no alert, no evidence, and no visibility.

Microsoft Defender for Cloud includes a Cloud Workload Protection plan for AI services—the **Defender for AI Services** plan. When you enable it on an Azure subscription, Defender for Cloud scans text tokens at inference time and generates security alerts for threats like jailbreak attempts, data leakage, and credential theft. These alerts integrate into Microsoft Defender XDR alongside your existing identity, endpoint, and cloud app signals.

This module walks you through enabling and configuring the Defender for AI Services plan, and then using the Data and AI security dashboard to monitor protection coverage across your subscriptions.

## Learning objectives

In this module, you learn how to:

- Enable the Defender for AI Services plan and configure its components for an Azure subscription
- Investigate AI threat protection alerts in the Defender portal
- Monitor AI security posture using the Data and AI security dashboard in Microsoft Defender for Cloud

## Prerequisites

Before you begin, you should have:

- Experience navigating Microsoft Defender for Cloud in the Azure portal
- Familiarity with enabling Defender for Cloud workload protection plans
- Understanding of Azure AI services concepts (Azure OpenAI, model deployments)
- **Owner** or **Contributor** role on the target Azure subscription
