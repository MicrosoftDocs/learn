AI workloads often rely on multiple connected services, including models in Azure AI Foundry, data in Azure Storage or SQL, and compute hosted in containers or virtual machines. Without centralized discovery, it can be difficult to know where these resources exist or how they relate to each other.

The **AI workloads plan** in Microsoft Defender for Cloud automatically identifies AI assets across your cloud environments and builds an inventory that shows how data, models, and services connect. This discovery process creates the foundation for assessing and protecting your AI environment.

:::image type="content" source="../media/defender-cloud-ai-lifecycle.png" alt-text="Diagram showing the Defender for Cloud protection model across the development lifecycle and runtime protection. It includes Cloud Ops Security (DevOps), Cloud Security Posture Management (CSPM), and Cloud Workload Protection (CWPP).":::

Defender for Cloud aligns protections across the full lifecycle of an AI workload. Cloud Ops Security addresses risks during development, Cloud Security Posture Management (CSPM) focuses on configuration and posture, and Cloud Workload Protection (CWPP) detects runtime threats.

Enabling the AI workloads plan is the first step in protecting AI environments. Turning it on allows Defender for Cloud to discover AI resources across clouds and begin building the inventory that later supports posture management and threat detection.

## Turn on the AI workloads plan

Before you can review AI-specific insights in Defender for Cloud, you need to make sure the **AI workloads** plan is enabled for each subscription that contains AI resources.

### Steps to turn on the AI workloads plan

1. In the **Azure portal**, open **Microsoft Defender for Cloud**.
1. Expand **Management**, then select **Environment settings**.
1. Choose the subscription you want to configure.
1. Under **Defender plans**, switch **AI workloads** to **On**.

   :::image type="content" source="../media/enable-ai-workloads-plan.png" alt-text="Screenshot showing the Defender plans page in Microsoft Defender for Cloud with the AI Services plan switched to On." lightbox="../media/enable-ai-workloads-plan.png":::

Once enabled, Defender for Cloud begins discovering AI services such as Azure AI Foundry, Azure OpenAI Service, and Azure Machine Learning. Discovery results typically appear in the **Data & AI security** dashboard within minutes.

### Configure optional AI settings

After turning on the AI Services plan, select **Settings** under **Monitoring coverage** to view optional extensions for **suspicious prompt evidence** and **data security for AI interactions**.

- **Suspicious prompt evidence** captures short, redacted snippets of AI prompts that triggered security alerts. These appear in Microsoft Defender XDR during alert investigations.
- **Data security for AI interactions** integrates with Microsoft Purview to classify and protect prompt and response data for compliance and data security outcomes.

   :::image type="content" source="../media/defender-ai-services-settings.png" alt-text="Screenshot showing the Settings and monitoring page for AI Services in Defender for Cloud with options to enable suspicious prompt evidence and data security for AI interactions." lightbox="../media/defender-ai-services-settings.png":::

These extensions aren't required for the AI workloads plan to function, but turning them on provides deeper visibility and investigation capabilities across Defender and Purview.

### Supporting steps for full coverage

To give the AI workloads plan complete context across your environment, verify that related plans and configurations are also active. These aren't required to enable the plan but improve the quality and depth of findings.

- **Defender CSPM**: Provides posture recommendations and attack path analysis for AI-related resources.
- **Sensitive data discovery**: Adds visibility into where sensitive or regulated data resides.
- **Defender for Storage** and **Defender for Databases**: Extend protection to AI data stores and models that rely on these services.
- **Cross-cloud connectors (optional)**: If your organization uses AWS or GCP, connect those environments so Defender for Cloud can discover AI workloads there as well.
- **Microsoft.Security resource provider**: Confirm this provider is registered for each subscription to ensure policy and assessment data flow correctly.

Once the AI workloads plan is enabled, insights appear in the **Data & AI security dashboard**. The dashboard brings together information about AI and data resources, showing protection coverage and highlighting issues such as exposed assets or misconfigurations. These insights serve as a foundation for assessing and improving your AI security posture.
