Learners can find the full list of labs and launch each exercise directly by visiting Govern [AI-ready Infrastructure](https://go.microsoft.com/fwlink/?linkid=2346535) GitHub repository, which serves as the single entry point for the course’s hands‑on activities.
### Background information

The threat protection plan for AI services in Microsoft Defender for Cloud protects AI services on an Azure subscription by providing insights to threats that might affect your generative AI applications. With the AI services threat protection plan enabled, you can control whether alerts include suspicious segments directly from your user's prompts, or the model responses from your AI applications or resources. Enabling user prompt evidence helps you triage, classify alerts and your user's intentions. User prompt evidence consists of prompts and model responses. Both are considered your data. Evidence is available through the Azure portal, Microsoft Defender portal, and any attached partner integrations.

To supplement the protection offered by Microsoft Defender for Cloud, consider also enabling Data Security for Azure AI with Microsoft Purview. This allows you to access, process, and store prompt and response data (including associated metadata) from Azure AI Services, with support for key data security and compliance scenarios such as:
- Sensitive information type (SIT) classification
- Analytics and Reporting through Microsoft Purview DSPM for AI
- Insider Risk Management
- Communication Compliance
- Microsoft Purview Audit
- Data Lifecycle Management
- eDiscovery

These capabilities help your organization manage and monitor AI-generated data in alignment with enterprise policies and regulatory requirements. Data Security for Azure AI requires a Microsoft Purview license, which isn't included with Microsoft Defender for Cloud's Defender for AI Services plan.

### Scenario
Your company is developing a customer engagement platform that supports multilingual virtual agents, automated document processing, and recommendation systems for e-commerce personalization. To protect these AI-driven services, your company plans to enable the AI services threat protection plan in Microsoft Defender for Cloud. Security operations teams configure monitoring rules so that alerts can include prompt and response evidence when unusual behavior is detected in the virtual agents. For workloads that handle sensitive customer data (such as payment information extracted from documents) your company is also considering the use of Data Security for Azure AI with Microsoft Purview to classify sensitive information, enforce data lifecycle policies, and meet compliance requirements across regulated industries.

:::image type="content" source="../media/enable-threat-protection-services.png" alt-text="Diagram illustrating the AI Ready Governance hands‑on exercise for enabling threat protection for AI services.":::

### Prerequisites
- **Azure subscription**: If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.
- **Permissions**: To create Azure AI Services resources, you should have the Owner role assigned at the Azure subscription level.
- Familiarity with Microsoft Defender for Cloud

>[!Note]
>You should ensure that Prompt Shields-based alerts for Azure OpenAI content filtering are enabled. Disabling this capability can affect Microsoft Defender for Cloud's ability to monitor and detect corresponding attacks.

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2346534)
