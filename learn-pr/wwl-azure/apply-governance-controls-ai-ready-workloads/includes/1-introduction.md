Your organization deployed Azure OpenAI Service across three business units, each team spinning up models independently. Within weeks, your compliance officer discovers training datasets containing customer personal data scattered across storage accounts in five different regions—some outside approved jurisdictions. Meanwhile, your security team can't answer an Audit (Standard) question: which production applications consume which AI models, and who approved those connections?

This scenario reflects a common challenge as organizations scale AI workloads. Without governance controls, AI infrastructure becomes a compliance uncertainty. Training datasets multiply across environments without classification. Model deployments bypass network security policies. Data lineage remains invisible, making regulatory audits time-consuming and error-prone. As AI adoption accelerates, these gaps create measurable risk: organizations face potential regulatory fines, data breaches exposing sensitive training data, and operational overhead managing access controls across hundreds of AI resources.

Microsoft Purview and Azure Policy provide a unified governance framework that addresses these challenges head-on. Purview automatically discovers AI assets across your Azure environment, classifies sensitive data, and traces lineage from source datasets through model training to inference endpoints. Azure Policy enforces guardrails that prevent noncompliant deployments before they reach production. Together, these services transform AI governance from reactive firefighting into proactive risk management.

In this module, you implement governance controls for a multi-region AI deployment. You configure Purview to discover and classify Azure OpenAI Service and Azure Machine Learning resources, deploy policy guardrails that enforce data residency and encryption requirements, establish data lineage tracking for training pipelines, and monitor compliance using audit logs and reports. By the end, you have a repeatable framework for governing AI infrastructure that reduces compliance risk while enabling innovation.

## Learning objectives

By the end of this module, you're able to:

- Configure Microsoft Purview to discover and classify AI infrastructure assets
- Implement Azure Policy guardrails for AI resource provisioning and management
- Establish data lineage tracking for AI training datasets and model outputs
- Monitor AI workload compliance using Microsoft Purview audit logs and reports
- Design access controls that protect AI models and sensitive training data

## Prerequisites

- Familiarity with Azure fundamentals and resource management
- Basic understanding of AI and machine learning concepts
- Experience with Microsoft Entra ID (formerly Azure Active Directory) for identity management
