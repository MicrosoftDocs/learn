Your organization deployed Azure OpenAI Service across three business units, each team spinning up models independently. Within weeks, your compliance officer discovers training datasets containing customer personal data scattered across storage accounts in five different regions—some outside approved jurisdictions. Meanwhile, your security team can't answer an Audit (Standard) question: which production applications consume which AI models, and who approved those connections?

This scenario reflects a common challenge as organizations scale AI workloads. Without governance controls, AI infrastructure becomes a compliance uncertainty. Training datasets multiply across environments without classification. Model deployments bypass network security policies. Data lineage remains invisible, making regulatory audits time-consuming and error-prone. As AI adoption accelerates, these gaps create measurable risk: organizations face potential regulatory fines, data breaches exposing sensitive training data, and operational overhead managing access controls across hundreds of AI resources.

Microsoft Purview and Azure Policy address different parts of these challenges. Purview catalogs supported data sources, classifies sensitive data in supported locations, and captures available lineage through configured integrations. Azure resource inventory tools identify the deployed AI infrastructure, while Azure Policy enforces resource guardrails.

In this module, you explore governance controls for a multi-region AI deployment. You use supported Purview source scans to classify training data and the Azure Machine Learning preview integration to catalog registered ML assets. You examine policy guardrails for resource location and encryption, review supported training-pipeline lineage, and combine catalog findings with compliance and audit evidence. The exercise focuses on enabling threat protection for AI services.

## Learning objectives

By the end of this module, you're able to:

- Configure supported Purview sources to catalog ML assets and classify training data
- Implement Azure Policy guardrails for AI resource provisioning and management
- Track supported lineage between data sources, training datasets, jobs, and models
- Review AI workload governance using catalog metadata, Azure Policy compliance results, and relevant audit logs
- Design access controls that protect AI models and sensitive training data

## Prerequisites

- Familiarity with Azure fundamentals and resource management
- Basic understanding of AI and machine learning concepts
- Experience with Microsoft Entra ID (formerly Azure Active Directory) for identity management
